//
//  MFViewController.m
//  Overdue
//
//  Created by Miguel Fagundez on 12/15/14.
//  Copyright (c) 2014 Miguel Fagundez. All rights reserved.
//

#import "MFViewController.h"
@interface MFViewController ()

@end

@implementation MFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // Recuperando el property list del NSUserDefaults
    NSArray *taskAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:OBJECTS] mutableCopy];
    
    // Agregando lo persistente en el arreglo de la tabla
    for (NSDictionary *taskDictionary in taskAsPropertyLists)
        [self.taskObjects addObject:[self taskFromPropertyList:taskDictionary]];

    
    // Seteando delegados necesarios para la tabla
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Prueba de Local Notification
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    // debe de activarse dentro de 5 segundos
    notification.fireDate = [[NSDate alloc] initWithTimeIntervalSinceNow:15];
    
    // mensaje que saldrá en la alerta
    notification.alertBody = @"Mensaje de Alert!";
    
    // sonido por defecto
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    // título del botón
    notification.alertAction = @"Ahora te lo cuento";
    notification.hasAction = YES;
    
    // activa la notificación
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark Implementaciones de los botones

// Hace el segue a la pantalla para agregar un task
- (IBAction)addTaskButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"toAddTaskViewControllerSegue" sender:nil];
}

- (IBAction)reorderButtonPressed:(id)sender {
    if (self.tableView.editing == YES)
        [self.tableView setEditing:NO animated:YES];
    else [self.tableView setEditing:YES animated:YES];
    [self saveTasks];
}

#pragma mark Conversores para usar property list y guardar en el NSUserDefaults

// Conversor de PropertyList a Task
- (MFTask *)taskFromPropertyList:(NSDictionary *)dictionary{
    MFTask *task = [[MFTask alloc] initWithData:dictionary];
    return task;
}
// Conversor de Task a PropertyList
-(NSDictionary *)taskObjectAsPropertyList:(MFTask *)task{
    NSDictionary *dictionary =@{TITLE:task.taskTitle, DESCRIPTION:task.descrip, DATE: task.date, COMPLETION: @(task.isCompleted)};
    
    return dictionary;

}


#pragma mark Implementaciones por ser delegado de AddTaskViewController
-(void)didAddTask:(MFTask *)task{
    
    // Agregando entemporal
    [self.taskObjects addObject:task];
    
    // Obteniendo los persistentes
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:OBJECTS] mutableCopy];
    
    // Agregando en persistencia
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    [taskObjectsAsPropertyLists addObject:[self taskObjectAsPropertyList:task]];
    
    // Guardando datos para persistencia en NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:OBJECTS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Haciendo el dismiss del modal, a pesar de que esa vista tiene el controlador MFAddTaskViewController
    [self dismissViewControllerAnimated:YES completion:nil];
    // Recargando data de tableView
    [self.tableView reloadData];
}

-(void)didCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Implementaciones por ser delegado de DetailTaskViewController
// Actualiza las tareas
-(void)updateTasks{
    [self saveTasks];
    [self.tableView reloadData];
}



#pragma mark Implementaciones por ser delegado del table view

// Secciones
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
// Numero de rows en una seccion
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.taskObjects count];
}
// Estructura el valor de la celda
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    MFTask *task = self.taskObjects[indexPath.row];
    cell.textLabel.text = task.taskTitle;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:task.date];
    cell.detailTextLabel.text = stringFromDate;
    
    if (task.isCompleted) cell.backgroundColor = [UIColor greenColor];
    else if ([self isDate:[NSDate date] GreaterThan:task.date])
        cell.backgroundColor = [UIColor redColor];
    else cell.backgroundColor = [UIColor yellowColor];
    return cell;
}
// Controla la seleccion de un row de la tabla
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MFTask *task = self.taskObjects[indexPath.row];
    [self updateCompletionOfTask:task forIndexPath:indexPath];

}
// Para permitir el borrado
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

// Para la edicion, en especial el borrado por el if
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        NSMutableArray *newTaskObjectsData = [[NSMutableArray alloc] init];
        for (MFTask *task in self.taskObjects)
            [newTaskObjectsData addObject:[self taskObjectAsPropertyList:task]];
        
        [[NSUserDefaults standardUserDefaults] setObject:newTaskObjectsData forKey:OBJECTS];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"toDetailTaskViewController" sender:indexPath];
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    MFTask *task = self.taskObjects[sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObjects insertObject:task atIndex:destinationIndexPath.row];
}


#pragma mark Implementaciones del Segue

// Preparacion para el segue al modal y el seteo del delegado del mismo
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[MFAddTaskViewController class]]){
        MFAddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
        
    }
    else if ([segue.destinationViewController isKindOfClass:[MFDetailTaskViewController class]]){
        MFDetailTaskViewController *detailTaskVC = segue.destinationViewController;
        NSIndexPath *indexPath = sender;
        MFTask *taskObject = self.taskObjects[indexPath.row];
        detailTaskVC.task =taskObject;
        detailTaskVC.delegate = self;
    }
}

#pragma mark Metodos de ayuda

// Lazy instantiation para el arreglo que estara en la tabla
-(NSMutableArray *)taskObjects{
    if (!_taskObjects){
        _taskObjects = [[NSMutableArray alloc] init];
    }
    return _taskObjects;
}

// Comparativa de fechas
-(BOOL) isDate:(NSDate *)date1 GreaterThan:(NSDate *)date2{
    NSTimeInterval menor = [date1 timeIntervalSince1970];
    NSTimeInterval mayor = [date2 timeIntervalSince1970];
    if (menor < mayor) return NO;
    return YES;
}

// Actualiza la completitud de una tarea
-(void)updateCompletionOfTask:(MFTask *)task forIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:OBJECTS] mutableCopy];
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    task.isCompleted = !task.isCompleted;
    [taskObjectsAsPropertyLists insertObject:[self taskObjectAsPropertyList:task] atIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:OBJECTS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
}

// Guarda las tareas
-(void)saveTasks{
    NSMutableArray *tasksObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    for (MFTask *task in self.taskObjects)
         [tasksObjectsAsPropertyLists addObject:[self taskObjectAsPropertyList:task]];
    
    [[NSUserDefaults standardUserDefaults] setObject:tasksObjectsAsPropertyLists forKey:OBJECTS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
