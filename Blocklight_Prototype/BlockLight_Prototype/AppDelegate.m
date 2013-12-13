//
//  AppDelegate.m
//  Prototype
//
//  Controls the initial start-up of BlockLight.
//  Also handles what happens when the user exits the application.
//
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize quickStageController = _quickStageController;
@synthesize navController = _navController;

/**********************************************************
 * @function: dealloc
 * @discussion: Unsure how this function works. 
 *********************************************************/
- (void)dealloc {
    [_window release];
    [super dealloc];
}

/**********************************************************
 * @function: application __didFinishLaunchingWithOptions
 * @discussion: After the application has started, this method
 *              make the application start showing the quick stage editor.
 *       TODO: Edit here to make application show the main menu instead.
 * @param: UIApplication* application
 * @param: NSDictionary* launchOptions
 *********************************************************/
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

/**************************************************************************
 * @function: applicationWillResignActive
 * @discussion: Sent when the application is about to move from active to
 *              inactive state. This can occur for certain types of temporary
 *              interruptions (such as an incoming phone call or SMS message)
 *              or when the user quits the application and it begins the
 *              transition to the background state.
 *              Use this method to pause ongoing tasks, disable timers, and
 *              throttle down OpenGL ES frame rates.
 *              Game should use this method to pause the game.
 * @param: UIApplication* application
 *************************************************************************/
- (void)applicationWillResignActive:(UIApplication *)application
{  }

/**************************************************************************
 * @function: applicationDidEnterBackground
 * @discussion: Use this method to release shared resources, save user data,
 *              invalide timers, and store enough application state infomration
 *              to restore your application to its current state in case it
 *              is terminated later.
 *              If your application supports background execution, this
 *              method is called instead of applicatiionWillTerminate: when the user quits
 * @param: UIApplication* application
 **************************************************************************/
- (void)applicationDidEnterBackground:(UIApplication *)application
{  }

/**************************************************************************
 * @function: applicationDidEnterForeground
 * @discussion: Called as part of the transition from the background to the
 *              inactive state; here you can uno many of the changes made on
 *              entering the background.
 * @param: UIApplication* application
 **************************************************************************/
- (void)applicationWillEnterForeground:(UIApplication *)application
{  }

/**************************************************************************
 * @function: applicationDidBecomeActive
 * @discussion: Restart any tasks that were paused (or not yet started)
 *              while the application was inactive. If the application was
 *              previously in the background, optionally refresh the user interface.
 * @param: UIApplication* application
 **************************************************************************/
- (void)applicationDidBecomeActive:(UIApplication *)application
{   }

/**************************************************************************
 * @function: applicationWillTerminate
 * @discussion: Called when the application is about to terminate. Save data
 *              if appropriate. See alos applicationDidEnterBackground.
 * @param: UIApplication* application
 **************************************************************************/
- (void)applicationWillTerminate:(UIApplication *)application
{    }

@end
