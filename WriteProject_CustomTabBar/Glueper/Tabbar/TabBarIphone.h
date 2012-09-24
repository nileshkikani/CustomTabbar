//
//  TabBarController.h
//  DogsInfo
//
//  Created by Chintan Adatiya on 06/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define tabBarFrame CGRectMake(0, 768, 1024, 48)
#define btnYaxis 48
#define btnHeight1 48

@interface TabBarIphone : UITabBarController <UITabBarControllerDelegate, UITabBarDelegate> {
	
	@public
	UIView *view;
	
	UIButton *btn1;
	UIButton *btn2;
	UIButton *btn3;
}

-(void)setFor:(NSString*)str;

- (void) loadBookContent;

-(void) addCustomElements;
-(void) selectTab:(int)tabID;

@end
