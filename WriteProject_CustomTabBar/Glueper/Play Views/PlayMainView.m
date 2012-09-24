//
//  PlayMainView.m
//  Glueper
//
//  Created by Nilesh on 01/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayMainView.h"
#import "AppDelegate.h"


@implementation PlayMainView

AppDelegate *appDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [AppDelegate sharedAppDelegate];
    
    self.title = @"Play";
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated 
{
    self.navigationController.navigationBarHidden = FALSE;
}

-(IBAction)onClickButton:(id)sender
{
    [appDelegate removeTabBarControllerInwindow];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
