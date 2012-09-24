//
//  DBHelper.h
//  CoreDataTest
//
//  Created by Danish Khan on 10/6/10.
//  Copyright 2010 DevLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Event;

@interface DBHelper : NSObject {

}

-(NSMutableArray*) getAllPatients;
-(void) deleteAllPatients;
-(void) deleteAllBodyParts;
-(NSArray*) getAllBodyParts:(NSString *)partFor;

@end
