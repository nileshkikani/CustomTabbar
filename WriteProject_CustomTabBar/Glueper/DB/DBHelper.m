//
//  DBHelper.m
//  CoreDataTest
//
//  Created by Danish Khan on 10/6/10.
//  Copyright 2010 DevLab. All rights reserved.
//

#import "DBHelper.h"
#import "AppDelegate.h"
#import "Event.h"

@implementation DBHelper

AppDelegate *appDelegate;

-(id) init {
    
    if((self = [super init])) {
        appDelegate = [AppDelegate sharedAppDelegate];
    }
    return self;
}


#pragma -
#pragma Fetching Libs

-(NSMutableArray*) getAllPatients {
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];	
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:YES];    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [sort release];
    
    NSError *error;
    NSMutableArray *arrPatients = (NSMutableArray*)[appDelegate.managedObjectContext
                                            executeFetchRequest:fetchRequest error:&error];
	[arrPatients retain];
    
    [fetchRequest release];
    
    return arrPatients;
}

-(void) deleteAllPatients {
	
	NSManagedObjectContext *moc = appDelegate.managedObjectContext;
	
	//---------------Fetching and Deleting Category---------
	NSFetchRequest *fetchRequest;
	NSEntityDescription *entity;
	NSArray *Result;
	NSError *error;	
	//---------------Fetching and Deleting ITems---------
	fetchRequest = [[NSFetchRequest alloc] init];
	entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:moc];	
	[fetchRequest setEntity:entity];
	
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"library == %@",appDelegate.objLibrary];  
//    [fetchRequest setPredicate:predicate];
    
	Result = [moc executeFetchRequest:fetchRequest error:nil];
    	
	for (NSManagedObject *managedObject in Result) {
            
            [moc deleteObject:managedObject];
    }
    	
	error = nil;
	[moc save:&error];
	
}

#pragma mark -
#pragma mark path for Document Directory 

-(NSString *)applicationDocumentsDirectory {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
	return basePath;
}


@end
