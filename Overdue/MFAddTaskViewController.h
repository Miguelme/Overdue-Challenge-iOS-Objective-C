//
//  MFAddTaskViewController.h
//  Overdue
//
//  Created by Miguel Fagundez on 12/15/14.
//  Copyright (c) 2014 Miguel Fagundez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFTask.h"

@protocol MFAddTaskViewControllerDelegate <NSObject>

-(void)didCancel;
-(void)didAddTask:(MFTask *)task;

@end

@interface MFAddTaskViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) id<MFAddTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *textField;


- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)addTaskButtonPressed:(id)sender;

@end
