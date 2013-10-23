//
//  GridOptionsView.h
//  Blocklight_Prototype
//
//  Created by nang1 on 10/16/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVPopoverViewController.h"

@interface GridOptionsView : UITableView <UITableViewDelegate, UITableViewDataSource> {
    TVPopoverViewController* _popoverCtrl;
    
    UISwitch* _gridSwitchView;
    UISwitch* _rulerSwitchView;
    UISwitch* _metricSwitchView;
    
    UISlider* _spacingSlider;
    UISlider* _opacitySlider;
}

@property (strong) TVPopoverViewController* popoverCtrl;
@property (nonatomic, strong) UISwitch* gridSwitchView;
@property (nonatomic, strong) UISwitch* rulerSwitchView;
@property (nonatomic, strong) UISwitch* metricSwitchView;
@property (nonatomic, strong) UISlider* spacingSlider;
@property (nonatomic, strong) UISlider* opacitySlider;

// These methods may need to be modified as we add the implementation
- (id)initWithViewController:(TVPopoverViewController*)viewController;
- (void)gridSwitch;
- (void)rulerSwitch;
- (void)metricSwitch;
- (void)spacingChange;
- (void)opacityChange;

@end
