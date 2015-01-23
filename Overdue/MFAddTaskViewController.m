//
//  MFAddTaskViewController.m
//  Overdue
//
//  Created by Miguel Fagundez on 12/15/14.
//  Copyright (c) 2014 Miguel Fagundez. All rights reserved.
//

#import "MFAddTaskViewController.h"

@interface MFAddTaskViewController ()

@end

@implementation MFAddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.delegate = self;
    self.textField.delegate = self;
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

#pragma mark Implementacion de constructor a partir del campo de texto
-(MFTask *)returnNewTaskObject{
    MFTask *taskObject = [[MFTask alloc] init];
    taskObject.taskTitle = self.textField.text;
    taskObject.descrip = self.textView.text;
    taskObject.date = self.datePicker.date;
    taskObject.isCompleted = NO;
    return taskObject;
}

#pragma mark Implementacion de los botones
- (IBAction)cancelButtonPressed:(id)sender {
    [self.delegate didCancel];
}

- (IBAction)addTaskButtonPressed:(id)sender {
    [self.delegate didAddTask:[self returnNewTaskObject]];
}

#pragma mark Delegado del textView y textField
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
    
}
@end

