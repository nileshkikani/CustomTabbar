

#import "TabBarIphone.h"
#import <QuartzCore/QuartzCore.h>

#import "AppDelegate.h"

@implementation TabBarIphone

AppDelegate *appDelegate;

NSString *strForPurpose;
NSString *strAdd;

#pragma mark -
#pragma mark Custom Methods

/*-(void) onClickSave {
	[appDelegate saveAction]; 
}*/

#pragma mark -
#pragma mark Init Methods

-(id) init {
	[super init];
    
	appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
	self.viewControllers = [NSArray arrayWithObjects:								
							    appDelegate.navPlay,
							    appDelegate.navWallet,
                                appDelegate.navCoupons,
                                appDelegate.navProfile,
                                appDelegate.navSetting,nil];
	
	self.delegate = self;
	self.customizableViewControllers = nil;
	return self;
}

#pragma mark -
#pragma mark View Methods

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationController.navigationBar.hidden = FALSE;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self tabBar].hidden = FALSE;
}

-(void)setFor:(NSString*)str {
	strAdd=str;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController 
	shouldSelectViewController:(UIViewController *)viewController {
	//NSLog(@"didSelectItem:(UITabBarItem *)item  %@ ",viewController);
    
    return TRUE;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
		[self setSelectedIndex:0];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	[super dealloc];
}


@end