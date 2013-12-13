//
//  AppDelegate.h
//  Prototype
//
//  Controls the inital start-up of BlockLight.
//  Also handles what happens when the user exists the application.
// 
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickStageViewController.h"
#import "TVNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    QuickStageViewController* _quickStageController;
    TVNavigationController* _navController;
}

@property (strong, nonatomic) UIWindow *window; // auto-generated
@property (strong) QuickStageViewController* quickStageController;
@property (strong) TVNavigationController* navController;

@end
