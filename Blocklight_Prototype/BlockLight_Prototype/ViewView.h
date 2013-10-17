//
//  ViewView.h
//  Blocklight_Prototype
//
//  Created by nang1 on 9/25/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVPopoverViewController.h"
#import "Defaults.h"

@class TVPopoverViewController;

@interface ViewView : UITableView <UITableViewDataSource, UITableViewDelegate> {
    TVPopoverViewController* _popoverCtrl;
    UISwitch* _noteSwitchView;
}

@property (strong) TVPopoverViewController* popoverCtrl;
@property (nonatomic, strong) UISwitch* noteSwitchView;

// These methods may need to be modified as we add the implementation
- (id)initWithViewController:(TVPopoverViewController*)viewController;
- (void)gridSwitch;
- (void)noteSwitch;

@end
