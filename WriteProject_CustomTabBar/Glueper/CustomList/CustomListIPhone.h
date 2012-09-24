//
//  CustomListIPhone.h
//  Connected
//
//  Created by Kalpesh on 16/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomListIPhoneDelegate.h"

#import "UIView+NibLoading.h"

@interface CustomListIPhone : UIView {
	
	NSObject<CustomListIPhoneDelegate> *delegate;
	
    IBOutlet UIButton *btnPlay, *btnWallet, *btnCoupons, *btnProfile, *btnSetting;
    
    IBOutlet UIImageView *imagView;
    
    IBOutlet UIView *view;
}

@property (nonatomic, retain) IBOutlet UIView *view;
@property (nonatomic, retain) UIImageView *imagView;
@property (nonatomic, assign) NSObject<CustomListIPhoneDelegate> *delegate;

-(IBAction)onClickplay:(id)sender;
-(IBAction)onClickWallet:(id)sender;
-(IBAction)onClickCoupons:(id)sender;
-(IBAction)onClickProfile:(id)sender;
-(IBAction)onClickSettings:(id)sender;

@end
