//
//  MFDetailTaskViewController.m
//  Overdue
//
//  Created by Miguel Fagundez on 12/15/14.
//  Copyright (c) 2014 Miguel Fagundez. All rights reserved.
//

#import "MFDetailTaskViewController.h"
#import "MFEditTaskViewController.h"
@interface MFDetailTaskViewController ()

@end

@implementation MFDetailTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.task.taskTitle;
    NSLog(@"Nombre %@",self.task.taskTitle);
    self.detailLabel.text = self.task.descrip;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yy"];
    self.dateLabel.text = [formatter stringFromDate:self.task.date];
    
    
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

#pragma mark Implementaciones de Delegado
-(void)didUpdateTask{
    self.titleLabel.text = self.task.taskTitle;
    self.detailLabel.text = self.task.descrip;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:self.task.date];
    self.dateLabel.text = stringFromDate;
    [self.delegate updateTasks];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark Implementacion de botones
-(IBAction)editButtonBarPressed:(id)sender {
    [self performSegueWithIdentifier:@"toEditTaskViewController" sender:nil];
}


#pragma mark Implementacion de Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[MFEditTaskViewController class]]){
        MFEditTaskViewController *editTaskVC = segue.destinationViewController;
        editTaskVC.task = self.task;
        editTaskVC.delegate = self;
        
    }
}
@end
