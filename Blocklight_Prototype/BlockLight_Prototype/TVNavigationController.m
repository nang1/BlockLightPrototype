//
//  TVNavigationController.m
//  Prototype
//
//  Created by game on 9/9/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//
// code taken from
// http://starterstep.wordpress.com/2009/03/05/changing-uinavigationcontroller%E2%80%99s-root-view-controller/

#import "TVNavigationController.h"

@interface TVNavigationController ()

@end

@implementation TVNavigationController
/* Auto-generated code
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/

@synthesize fakeRootViewController;
// override the standrad init
-(id)initWithRootViewController:(UIViewController *)rootViewController {
    // create the fake controller and set it as the root
    // UIViewController *fakeController = [[[UIViewController alloc] init] autorelease];
    UIViewController* fakeController = [[UIViewController alloc] init];
    
    if(self = [super initWithRootViewController:fakeController]) {
        self.fakeRootViewController = fakeController;
        // hide the back button on the perceived root
        rootViewController.navigationItem.hidesBackButton = YES;
        // push the perceived root (at index 1)
        [self pushViewController:rootViewController animated:NO];
    }
    
    return self;
}

// override to remove fake root controller
- (NSArray*)viewControllers {
    NSArray *viewControllers = [super viewControllers];
    if(viewControllers != nil && viewControllers.count > 0) {
        NSMutableArray* array = [NSMutableArray arrayWithArray:viewControllers];
        [array removeObjectAtIndex:0];
        return array;
    }
    return viewControllers;
}

// override so it pops to the perceived root
- (NSArray*)popToRootViewControllerAnimated:(BOOL)animated {
    // we use index 0 because we overrided "viewControllers"
    return [self popToViewController:[self.viewControllers objectAtIndex:0] animated:animated];
}

// this is the new method that lets you set the perceived root, the previous one will be popped (released)
- (void)setRootViewController:(UIViewController*)rootViewController {
    rootViewController.navigationItem.hidesBackButton = YES;
    [self popToViewController:fakeRootViewController animated:NO];
    [self pushViewController:rootViewController animated:NO];
}

- (void)dealloc {
    self.fakeRootViewController = nil;
    //[super dealloc];
}
@end
