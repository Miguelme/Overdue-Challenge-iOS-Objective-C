//
//  MFEditTaskViewController.h
//  Overdue
//
//  Created by Miguel Fagundez on 12/15/14.
//  Copyright (c) 2014 Miguel Fagundez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFTask.h"
@protocol MFEditTaskViewControllerDelegate <NSObject>
-(void) didUpdateTask;
@end
@interface MFEditTaskViewController : UIViewController
@property (weak, nonatomic) id<MFEditTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) MFTask *task;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *textField;
- (IBAction)saveButtonPressed:(id)sender;

@end
