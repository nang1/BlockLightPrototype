//
//  SettingsView.h
//  Previously: DimensionsView.h
//  Blocklight_Prototype
//
//  Created by Barrett Ames on 7/30/12.
//  Recreated by Jordan Nguyen on 10/16/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TVPopoverViewController.h"
#import "Stage.h"

@class TVPopoverViewController;

@interface SettingsView : UITableView <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    TVPopoverViewController* _popoverCtrl;
    Stage* _stage;
    UITextField* _stageName;
    UITextField* _stageWidth;
    UITextField* _stageHeight;
    /*
    UIButton* _selectPreset;
    //*/
}

@property (strong) TVPopoverViewController* popoverCtrl;
@property (strong) Stage* stage;
@property (strong) UITextField* stageName;
@property (strong) UITextField* stageWidth;
@property (strong) UITextField* stageHeight;
/*
@property (strong) UIButton* selectPreset;
//*/

- (id)initWithViewController:(TVPopoverViewController*)viewController withStage:(Stage*)stage;

@end