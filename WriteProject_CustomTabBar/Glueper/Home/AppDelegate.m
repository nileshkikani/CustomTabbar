//
//  AppDelegate.m
//  WriteYourProjectNameHere
//
//  Created by Nilesh on 30/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "MasterViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "PlayMainView.h"
#import "WalletMainView.h"
#import "CouponsMainView.h"
#import "ProfileMainView.h"
#import "SettingsMainView.h"
#import "CustomListIPhone.h"
#import "TabBarIphone.h"

#define kAnimationKey @"transitionViewAnimation"


@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize navigationController = _navigationController;

@synthesize objPlayView, navPlay, objWallet, navWallet, objCoupons, navCoupons, objProfile, navProfile, objSettings, navSetting;

@synthesize tabBarController, objList;

- (void)dealloc
{
    [_window release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [_navigationController release];

    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
        
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
    {
        splashView = [[UIImageView alloc] initWithFrame:iphoneFrame];
        splashView.image = [UIImage imageNamed:@"Default"];
        [self.window addSubview:splashView];
        [self.window makeKeyAndVisible];
        [self performSelector:@selector(loadViewIphone) withObject:nil afterDelay:2.0];
        
        UIImage *img = [UIImage imageNamed:@""];
        objPlayView = [[PlayMainView alloc] initWithNibName:@"PlayMainView" bundle:nil];
        navPlay = [[UINavigationController alloc] initWithRootViewController:objPlayView];
        [objPlayView.tabBarItem initWithTitle:@"Play" image:img tag:1];
        
        objWallet = [[WalletMainView alloc] initWithNibName:@"WalletMainView" bundle:nil];
        navWallet = [[UINavigationController alloc] initWithRootViewController:objWallet];
        [objWallet.tabBarItem initWithTitle:@"Wallet" image:img tag:1];
        
        objCoupons = [[CouponsMainView alloc] initWithNibName:@"CouponsMainView" bundle:nil];
        navCoupons = [[UINavigationController alloc] initWithRootViewController:objCoupons];
        [objCoupons.tabBarItem initWithTitle:@"Coupons" image:img tag:1];
        
        objProfile = [[ProfileMainView alloc] initWithNibName:@"ProfileMainView" bundle:nil];
        navProfile = [[UINavigationController alloc] initWithRootViewController:objProfile];
        [objProfile.tabBarItem initWithTitle:@"Profile" image:img tag:1];
        
        objSettings = [[SettingsMainView alloc] initWithNibName:@"SettingsMainView" bundle:nil];
        navSetting = [[UINavigationController alloc] initWithRootViewController:objSettings];
        [objSettings.tabBarItem initWithTitle:@"Setting" image:img tag:1];
        
        tabBarController = [[TabBarIphone alloc] init];
        [self hideTabBar:self.tabBarController];
    } 
    else 
    {
        splashView = [[UIImageView alloc] initWithFrame:ipadFrame];
        splashView.image = [UIImage imageNamed:@"Default_iPad"];
        [self.window addSubview:splashView];
        [self.window makeKeyAndVisible];
        [self performSelector:@selector(loadViewIpad) withObject:nil afterDelay:2.0];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)loadViewIphone 
{
    [splashView removeFromSuperview];
    MasterViewController *masterViewController = [[[MasterViewController alloc] initWithNibName:@"MasterViewController_iPhone" bundle:nil] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:masterViewController] autorelease];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    CATransition *animation = [CATransition animation];
	[animation setDelegate:self];	
	[animation setType:kCATransitionFade];
	[animation setDuration:0.5];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:
								  kCAMediaTimingFunctionEaseInEaseOut]];
	[[self.window layer] addAnimation:animation forKey:kAnimationKey];
}

-(void)loadViewIpad 
{
    [splashView removeFromSuperview];
    MasterViewController *masterViewController = [[[MasterViewController alloc] initWithNibName:@"MasterViewController_iPad" bundle:nil] autorelease];
    UINavigationController *masterNavigationController = [[[UINavigationController alloc] initWithRootViewController:masterViewController] autorelease];
    
    self.window.rootViewController = masterNavigationController;
    [self.window makeKeyAndVisible];
    CATransition *animation = [CATransition animation];
	[animation setDelegate:self];	
	[animation setType:kCATransitionFade];
	[animation setDuration:0.5];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:
								  kCAMediaTimingFunctionEaseInEaseOut]];
	[[self.window layer] addAnimation:animation forKey:kAnimationKey];
}

- (void) showAlertWithTitle:(NSString *)title message:(NSString *)message {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	[alert show];
	[alert release];
}

+(AppDelegate *)sharedAppDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(NSDate *)convertStringToDate:(NSString *) date format:(NSString *)format {
	
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
	NSDate *nowDate = [[[NSDate alloc] init] autorelease];
	[formatter setDateFormat:format];
	nowDate = [formatter dateFromString:date];
    
	return nowDate;
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

-(void) showLoadingView {
	
	//NSLog(@">>>>>>>>>>>>>>>>> loading view Landscape right ");
    UIView *viewBack;
    if (loadView == nil) {
		loadView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
        loadView.opaque = NO;
        loadView.backgroundColor = [UIColor clearColor];
        //loadView.alpha = 0.8;
		
        viewBack = [[UIView alloc] initWithFrame:CGRectMake(95, 230, 130, 40)];
        viewBack.backgroundColor = [UIColor blackColor];
        viewBack.alpha = 0.7f;
        viewBack.layer.masksToBounds = NO;
        viewBack.layer.cornerRadius = 8; 
        
        spinningWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(5.0, 5.0, 30.0, 30.0)];
        [spinningWheel startAnimating];
        //        spinningWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [viewBack addSubview:spinningWheel];
        [spinningWheel release];		
        
        UILabel *lblLoading = [[UILabel alloc] initWithFrame:CGRectMake(23, 6, 110, 25)];
        lblLoading.backgroundColor = [UIColor clearColor];
        lblLoading.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
        lblLoading.textAlignment = UITextAlignmentCenter;
        lblLoading.textColor = [UIColor whiteColor];
        lblLoading.text = @"Loading...";
        [viewBack addSubview:lblLoading];
        [loadView addSubview:viewBack];
    }    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        loadView.frame = iphoneFrame;
        viewBack.frame = loadiPhone;        
    }
    else
    {
        loadView.frame = ipadFrame;  
        viewBack.frame = loadiPad;
    }
    
    [self.window addSubview:loadView];
}

-(void) hideLoadingView {
    
	[loadView removeFromSuperview];
}


-(void)addTabBarControllerInwindow 
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.window cache:YES];
    
    [self.navigationController.view removeFromSuperview];
    [self.window addSubview:[tabBarController view]];
    [UIView commitAnimations];
    objList = [[CustomListIPhone alloc] initWithFrame:CGRectMake(0, 435, 320, 44)];
    objList.delegate = self;
    [objList viewDidLoad];
    objList.hidden = TRUE;
    [self.window addSubview:objList];
    //    [self showTabBar:tabBarController];
    tabBarController.selectedIndex = 0;    
    objList.hidden = FALSE;
}

-(void)removeTabBarControllerInwindow 
{
    //    [self.window addSubview:tabBarController.view];
    tabBarController.selectedIndex = 0;    
    [self.tabBarController.view removeFromSuperview];
    //[objList removeFromSuperview];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.window cache:YES];
    
    [self.window addSubview:[self.navigationController view]];
    //    [self showTabBar:tabBarController];
    [UIView commitAnimations];
}

- (void) hideTabBar:(UITabBarController *) tabbarcontroller {
    
    int height = 480;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    for(UIView *view in tabbarcontroller.view.subviews) {
        if([view isKindOfClass:[UITabBar class]]) {
            [view setFrame:CGRectMake(view.frame.origin.x, height, view.frame.size.width, view.frame.size.height)];
        } 
        else {
            [view setFrame:CGRectMake(view.frame.origin.x,view.frame.origin.y, 320, 436)];
        }
    }
    [UIView commitAnimations];
}

- (void) showTabBar:(UITabBarController *) tabbarcontroller {
    
    int height = 480;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; 
    
    for(UIView *view in tabbarcontroller.view.subviews) {
        
        if([view isKindOfClass:[UITabBar class]]) {
            [view setFrame:CGRectMake(view.frame.origin.x, height, view.frame.size.width, view.frame.size.height)];            
        } 
        else {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, height)];
        }
    }    
    
    [UIView commitAnimations];
}

- (void)PlayViewSelected:(CustomListIPhone *)navBar
{
    [self loadBookContent:0];
}

- (void)WalletViewSelected:(CustomListIPhone *)navBar
{
    [self loadBookContent:1];
}

- (void)CouponsViewSeleceted:(CustomListIPhone *)navBar
{
    [self loadBookContent:2];
}

- (void)ProfileViewSeleceted:(CustomListIPhone *)navBar
{
    [self loadBookContent:3];
}

- (void)SettingsViewSeleceted:(CustomListIPhone *)navBar
{
    [self loadBookContent:4];
}

- (void) loadBookContent :(int)index {	
    
    if(self.tabBarController.selectedIndex == index) {
        return;
    }
    
    self.tabBarController.selectedIndex = index;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ProjectdataBase" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ProjectdataBase.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
