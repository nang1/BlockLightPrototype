//
//  edu_asuAppDelegate.h
//  Blocklight_Prototype
//
//  Created by Jordan Nguyen on 9/17/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickStageViewController.h"
#import "TVNavigationController.h"

@interface edu_asuAppDelegate : UIResponder <UIApplicationDelegate> {
    QuickStageViewController* _quickStageController;
    TVNavigationController* _navController;
}

@property (strong, nonatomic) UIWindow *window; // auto-generated
@property (strong) QuickStageViewController* quickStageController;
@property (strong) TVNavigationController* navController;

@end

/*
#import <UIKit/UIKit.h>

@interface edu_asuAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
*/