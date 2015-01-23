//
//  MFDetailTaskViewController.h
//  Overdue
//
//  Created by Miguel Fagundez on 12/15/14.
//  Copyright (c) 2014 Miguel Fagundez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFTask.h"
#import "MFEditTaskViewController.h"
@protocol MFDetailTaskViewControllerDelegate<NSObject>
-(void)updateTasks;
@end
@interface MFDetailTaskViewController : UIViewController<MFEditTaskViewControllerDelegate>
@property (weak, nonatomic) id<MFDetailTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) MFTask *task;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
- (IBAction)editButtonBarPressed:(id)sender;

@end
