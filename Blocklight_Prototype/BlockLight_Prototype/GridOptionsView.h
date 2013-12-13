//
//  GridOptionsView.h
//  Blocklight_Prototype
//
//  This view is called from the ViewView popover.
//  It allows the user to edit the grid lines on the stage.
//
//  Created by Nicole Ang on 10/16/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVPopoverViewController.h"

@interface GridOptionsView : UITableView <UITableViewDelegate, UITableViewDataSource> {
    TVPopoverViewController* _popoverCtrl;
    
    UISwitch* _gridSwitchView;
    UISwitch* _rulerSwitchView;
    UISwitch* _metricSwitchView;
    
    UIButton* _horizontal;
    UIButton* _vertical;
    
    UISlider* _spacingSlider;
    UISlider* _opacitySlider;
}

@property (strong) TVPopoverViewController* popoverCtrl;
@property (nonatomic, strong) UISwitch* gridSwitchView;
@property (nonatomic, strong) UISwitch* rulerSwitchView;
@property (nonatomic, strong) UISwitch* metricSwitchView;
@property (nonatomic, strong) UIButton* horizontal;
@property (nonatomic, strong) UIButton* vertical;
@property (nonatomic, strong) UISlider* spacingSlider;
@property (nonatomic, strong) UISlider* opacitySlider;

// These methods may need to be modified as we add the implementation
- (id)initWithViewController:(TVPopoverViewController*)viewController;
- (void)gridSwitch;
- (void)rulerSwitch;
- (void)metricSwitch;
- (void)horzButton;
- (void)vertButton;
- (void)spacingChange;
- (void)opacityChange;

@end
