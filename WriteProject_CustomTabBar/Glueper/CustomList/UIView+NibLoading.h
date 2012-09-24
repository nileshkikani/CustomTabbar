//
//  UIView+NibLoading.h
//  BookListing
//
//  Created by Chintan on 09/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NibLoading)

+(UIView*) loadInstanceFromNib:(id)fileOwner;

@end
