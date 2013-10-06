//
//  TVNavigationController.h
//  Prototype
//
//  Created by game on 9/9/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//
// code taken from
// http://starterstep.wordpress.com/2009/03/05/changing-a-uinavigationcontroller%E2%80%99s-root-view-controller/

#import <UIKit/UIKit.h>

@interface TVNavigationController : UINavigationController {
    UIViewController* fakeRootViewController;
}

@property (nonatomic, retain) UIViewController* fakeRootViewController;

- (void)setRootViewController:(UIViewController*)rootViewController;

@end
