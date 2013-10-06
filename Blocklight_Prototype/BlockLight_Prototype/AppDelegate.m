//
//  AppDelegate.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize quickStageController = _quickStageController;
@synthesize navController = _navController;

// don't understand function
- (void)dealloc {
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    // Override point for customization after application launch.
    UIImage* bg =  [UIImage imageNamed:@"bg-main"];
    self.window.backgroundColor = [UIColor colorWithPatternImage:bg];
    
    // quick stage setup
    _quickStageController = [[QuickStageViewController alloc] init];
    _quickStageController.view.frame = self.window.bounds;
    
    //navigation bar setup, this gives the tool bar for quick stage
    _navController = [[TVNavigationController alloc] initWithRootViewController:_quickStageController];
    [_navController.navigationBar setTintColor:[UIColor blackColor]];
    _navController.toolbar.barStyle = UIBarStyleBlack;
    
    [self.window addSubview:_navController.view];
    self.window.rootViewController = _navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
