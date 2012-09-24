

//  AlertCurrencyPicker.h
//  SalesBell
//
//  Created by Chintan Adatiya on 20/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParsingDelegate.h"

@interface Parsing : NSObject {
		
	NSMutableData *webData;
    
    NSMutableArray *arrTableData;

    NSObject<ParsingDelegate> *delegate;
}


@property (nonatomic, assign) NSObject<ParsingDelegate> *delegate;

-(id) init;

-(void)parsingOperation;

-(NSString*) trimString:(NSString *)theString; 
-(NSString *) removeNull:(NSString *) string;
-(void)parsingForUrl:(NSString *)strUrl;


@end