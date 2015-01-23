//
//  MFViewController.h
//  Overdue
//
//  Created by Miguel Fagundez on 12/15/14.
//  Copyright (c) 2014 Miguel Fagundez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFAddTaskViewController.h"
#import "MFDetailTaskViewController.h"
/* Delegado:
    -    Del Modal que despliega
    -    De la tableView que usa para poder hacer el borrado y el seteo de datos
 */
@interface MFViewController : UIViewController<MFAddTaskViewControllerDelegate,MFDetailTaskViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *taskObjects;

- (IBAction)addTaskButtonPressed:(id)sender;
- (IBAction)reorderButtonPressed:(id)sender;

@end
