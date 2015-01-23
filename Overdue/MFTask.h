//
//  MFTask.h
//  Overdue
//
//  Created by Miguel Fagundez on 12/15/14.
//  Copyright (c) 2014 Miguel Fagundez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrefixHeader.pch"

@interface MFTask : NSObject

@property (strong, nonatomic) NSString *taskTitle;
@property (strong, nonatomic) NSString *descrip;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL isCompleted;

-(id)initWithData:(NSDictionary *)data;

@end
