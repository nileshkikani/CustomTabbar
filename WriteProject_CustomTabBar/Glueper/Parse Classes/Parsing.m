//
//  AlertCurrencyPicker.m
//  SalesBell
//
//  Created by Chintan Adatiya on 20/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Parsing.h"
#import "AppDelegate.h"

#import <QuartzCore/QuartzCore.h>
#import "constant.h"
#import "JSON.h"
#import "Event.h"
#import "DBHelper.h"

@implementation Parsing

AppDelegate *appDelegate;

@synthesize delegate;

#pragma mark -
#pragma mark init methods


- (id) init {
    
	if ((self = [super init])) {
        
        appDelegate = [AppDelegate sharedAppDelegate];
    }
	return self;
}

-(void)parsingForUrl:(NSString *)strUrl
{
    NSLog(@">>>>>>>>>>> parsing Operation called : %@", strUrl);
    
    [appDelegate showLoadingView];
    
	NSURL *url = [NSURL URLWithString:strUrl];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:120.0];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];	
	
	if( theConnection ) {		
		//webData = [[NSMutableData data] retain];
	}
	else {
		NSLog(@"theConnection is NULL");
	}
}

-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response {
	
	webData = [[NSMutableData data] retain];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	
	[webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	
	NSLog(@"ERROR with theConenction");
	UIAlertView *connectionAlert = [[UIAlertView alloc] initWithTitle:@"Information !" message:@"Internet / Service Connection Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[connectionAlert show];
	[connectionAlert release];
	[connection release];
    
    [webData release];
    
    [delegate fetchDataFail:error];
    return;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    NSLog(@"Received data :%@",theXML);
    [theXML release];
    
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
	//[responseData release];
	
	NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
    
	NSMutableArray *patientsArray = [json objectWithString:responseString error:&error];
       
    DBHelper *objHelper = [[DBHelper alloc] init];
    [objHelper deleteAllPatients];
       
    for (int i = 0; i < [patientsArray count]; i++) {
        
        Event *objpatient = (Event *)[NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:appDelegate.managedObjectContext];
        
        NSDictionary *dictPatient = [patientsArray objectAtIndex:i];
           
        NSString *str = [dictPatient objectForKey:@"diagnosis"];
        str = [self removeNull:str];
        
        objpatient.timeStamp = [NSDate date];
    }
    
    [delegate fetchDataSuccess];
}

-(NSString*) trimString:(NSString *)theString {
	NSString *theStringTrimmed = [theString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
	return theStringTrimmed;
}

-(NSString *) removeNull:(NSString *) string {    
    
	NSRange range = [string rangeOfString:@"null"];
    //NSLog(@"in removeNull : %d  >>>> %@",range.length, string);
	if (range.length > 0 || string == nil) {
		string = @"";
	}
	string = [self trimString:string];
	return string;
}

#pragma mark -
#pragma mark
- (void)dealloc {

    [super dealloc];
}


@end