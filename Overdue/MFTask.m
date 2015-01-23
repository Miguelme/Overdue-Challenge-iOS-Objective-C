//
//  MFTask.m
//  Overdue
//
//  Created by Miguel Fagundez on 12/15/14.
//  Copyright (c) 2014 Miguel Fagundez. All rights reserved.
//

#import "MFTask.h"

@implementation MFTask


// Constructor con un diccionario
-(id)initWithData:(NSDictionary *)data{
    self = [super init];
    if (self){
        self.taskTitle = data[TITLE];
        self.descrip = data[DESCRIPTION];
        self.date = data[DATE];
        self.isCompleted = [data[COMPLETION] boolValue];
        
    }
    return self;
}
// Constructor vacio
-(id)init{
    self = [self initWithData:nil];
    return self;
    
}
@end
