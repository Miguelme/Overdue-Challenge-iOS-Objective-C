//
//  MFEditTaskViewController.m
//  Overdue
//
//  Created by Miguel Fagundez on 12/15/14.
//  Copyright (c) 2014 Miguel Fagundez. All rights reserved.
//

#import "MFEditTaskViewController.h"

@interface MFEditTaskViewController ()

@end

@implementation MFEditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textField.text = self.task.taskTitle;
    self.textView.text = self.task.descrip;
    self.datePicker.date = self.task.date;
    
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
#pragma mark Actualiza la tarea actual, que es pasada por referencia
- (void) updateTask {
    self.task.taskTitle = self.textField.text;
    self.task.descrip = self.textView.text;
    self.task.date = self.datePicker.date;
}

#pragma mark Implementacion de los botones
- (IBAction)saveButtonPressed:(id)sender {
    [self updateTask];
    [self.delegate didUpdateTask];
}
@end
