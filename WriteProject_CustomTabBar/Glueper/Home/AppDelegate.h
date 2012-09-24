//
//  AppDelegate.h
//  WriteYourProjectNameHere
//
//  Created by Nilesh on 30/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomListIPhoneDelegate.h"

#define ipadFrame CGRectMake(0, 0, 768, 1024)
#define iphoneFrame CGRectMake(0, 0, 320, 480)
#define loadiPhone CGRectMake(95, 230, 130, 40)
#define loadiPad CGRectMake(319, 502, 130, 40)


@class PlayMainView, WalletMainView, CouponsMainView, ProfileMainView, SettingsMainView;
@class TabBarIphone;
@class CustomListIPhone;

@interface AppDelegate : UIResponder <UIApplicationDelegate, CustomListIPhoneDelegate>
{
    
    UIImageView *splashView;
    
    UIView *loadView;
    
    UIActivityIndicatorView *spinningWheel;
    
    PlayMainView *objPlayView;
    UINavigationController *navPlay;
    
    WalletMainView *objWallet;
    UINavigationController *navWallet;
    
    CouponsMainView *objCoupons;
    UINavigationController *navCoupons;
    
    ProfileMainView *objProfile;
    UINavigationController *navProfile;
    
    SettingsMainView *objSettings;
    UINavigationController *navSetting;
    
    TabBarIphone *tabBarController;
    CustomListIPhone *objList;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (retain, nonatomic) PlayMainView *objPlayView;
@property (retain, nonatomic) UINavigationController *navPlay;

@property (retain, nonatomic) WalletMainView *objWallet;
@property (retain, nonatomic) UINavigationController *navWallet;

@property (retain, nonatomic) CouponsMainView *objCoupons;
@property (retain, nonatomic) UINavigationController *navCoupons;

@property (retain, nonatomic) ProfileMainView *objProfile;
@property (retain, nonatomic) UINavigationController *navProfile;

@property (retain, nonatomic) SettingsMainView *objSettings;
@property (retain, nonatomic) UINavigationController *navSetting;

@property (retain, nonatomic) TabBarIphone *tabBarController;
@property (retain, nonatomic) CustomListIPhone *objList;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void) showAlertWithTitle:(NSString *)title message:(NSString *)message;
+(AppDelegate *)sharedAppDelegate;
-(NSDate *)convertStringToDate:(NSString *) date format:(NSString *)format;
-(NSString*) trimString:(NSString *)theString;
-(NSString *) removeNull:(NSString *) string;
-(void) showLoadingView;
-(void) hideLoadingView;
- (void) showTabBar:(UITabBarController *) tabbarcontroller;
- (void) hideTabBar:(UITabBarController *) tabbarcontroller;
- (void) loadBookContent :(int)index;
-(void)addTabBarControllerInwindow;
-(void)removeTabBarControllerInwindow;

@property (strong, nonatomic) UINavigationController *navigationController;


@end
