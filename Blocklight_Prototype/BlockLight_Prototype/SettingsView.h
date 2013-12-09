//
//  SettingsView.h
//  Previously: DimensionsView.h
//  Blocklight_Prototype
//
//  Originally Created by Barrett Ames on 7/30/12.
//  Recreated by Jordan Nguyen on 10/16/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TVPopoverViewController.h"

@class TVPopoverViewController;

@interface SettingsView : UITableView <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    TVPopoverViewController* _popoverCtrl;
    UITextField* _stageName;
    UITextField* _stageWidth;
    UITextField* _stageHeight;
}

@property (strong) TVPopoverViewController* popoverCtrl;
@property (strong) UITextField* stageName;
@property (strong) UITextField* stageWidth;
@property (strong) UITextField* stageHeight;

- (id)initWithViewController:(TVPopoverViewController*)viewController;

@end