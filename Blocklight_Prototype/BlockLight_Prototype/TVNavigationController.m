//
//  TVNavigationController.m
//  Prototype
//
//  Created by Brian Knorr on 3/5/09.
//  All rights reserved.
//
// code taken from
// http://starterstep.wordpress.com/2009/03/05/changing-a-uinavigationcontroller%E2%80%99s-root-view-controller/

#import "TVNavigationController.h"

@implementation TVNavigationController

@synthesize fakeRootViewController;

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

/*************************************************
 * @function: initWithRootViewController
 * @discussion: override the standard init
 * @param: UIViewController* rootViewController
 * @return: id to this instance
 *************************************************/
-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    // create the fake controller and set it as the root
    UIViewController* fakeController = [[UIViewController alloc] init]; // autorelease];
    
    if(self = [super initWithRootViewController:fakeController])
    {
        self.fakeRootViewController = fakeController;
        // hide the back button on the perceived root
        rootViewController.navigationItem.hidesBackButton = YES;
        // push the perceived root (at index 1)
        [self pushViewController:rootViewController animated:NO];
    }
    
    return self;
}

/*************************************************
 * @function: viewControllers
 * @discussion: override to remove fake root controller
 * @return: NSArray* of view controllers
 *************************************************/
- (NSArray*)viewControllers
{
    NSArray *viewControllers = [super viewControllers];
    if(viewControllers != nil && viewControllers.count > 0)
    {
        NSMutableArray* array = [NSMutableArray arrayWithArray:viewControllers];
        [array removeObjectAtIndex:0];
        return array;
    }
    return viewControllers;
}

/*************************************************
 * @function: popToRootViewControllerAnimated
 * @discussion: override so it pops to the perceived root
 * @param: BOOL animated
 * @return: NSArray* of view controllers that were popped from the stack
 *************************************************/
- (NSArray*)popToRootViewControllerAnimated:(BOOL)animated
{
    // we use index 0 because we overrided "viewControllers"
    return [self popToViewController:[self.viewControllers objectAtIndex:0] animated:animated];
}

/*************************************************
 * @function: viewControllers
 * @discussion: this is the new method that lets you
 *     set the perceived root, the previous one will
 *     be popped (released)
 * @param: UIViewController* rootViewController
 *************************************************/
- (void)setRootViewController:(UIViewController*)rootViewController
{
    rootViewController.navigationItem.hidesBackButton = YES;
    [self popToViewController:fakeRootViewController animated:NO];
    [self pushViewController:rootViewController animated:NO];
}

/*************************************************
 * @function: dealloc
 * @discussion: sets the fakeRootViewController to nil
 *************************************************/
- (void)dealloc
{
    self.fakeRootViewController = nil;
    //[super dealloc];
}
@end
