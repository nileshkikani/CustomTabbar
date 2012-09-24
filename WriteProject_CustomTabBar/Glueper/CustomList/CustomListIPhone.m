//
//  CustomListIPhone.m
//  Connected
//
//  Created by Kalpesh on 16/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomListIPhone.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

#define bgColor [UIColor clearColor]
#define btnHeight 68
#define btnWidth 107

@implementation CustomListIPhone

AppDelegate *appDelegate;

@synthesize delegate, imagView;
@synthesize view;
#pragma mark -
#pragma mark init methods

-(id) initWithFrame:(CGRect)frame {
    
    if(self == [super initWithFrame:frame]) {     
        self = (CustomListIPhone *)[CustomListIPhone loadInstanceFromNib:self];
        self.frame = frame;      
        self.hidden = TRUE;
    }
    
    return self;
}

-(void)viewDidLoad {
    //NSLog(@"Custom View did load");
    appDelegate = [AppDelegate sharedAppDelegate];
    self.hidden = FALSE;
    //The setup code (in viewDidLoad in your view controller)
}

-(IBAction)onClickplay:(id)sender
{
    NSLog(@"Play button Clicked");
    [delegate PlayViewSelected:self];
}

-(IBAction)onClickWallet:(id)sender
{
    [delegate WalletViewSelected:self];
}

-(IBAction)onClickCoupons:(id)sender
{
    [delegate CouponsViewSeleceted:self];
}

-(IBAction)onClickProfile:(id)sender
{
    [delegate ProfileViewSeleceted:self];
}

-(IBAction)onClickSettings:(id)sender
{
    [delegate SettingsViewSeleceted:self];
}

#pragma mark -
#pragma mark
- (void)dealloc {
	//[array release];
    [super dealloc];
}

@end
