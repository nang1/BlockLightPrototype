//
//  SetPieceView.h
//  Blocklight_Prototype
//
//  A view that lets the user pick whether or not to draw
//  spike tape or traffic patterns. Also lets the user see the
//  categories of the set pieces in the aplication.
//
//  Created by Nicole Ang on 9/25/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVPopoverViewController.h"
#import "Frame.h"
#import "Defaults.h"

@class TVPopoverViewController;

@interface SetPieceView : UITableView <UITableViewDelegate, UITableViewDataSource> {
    TVPopoverViewController* _popoverCtrl;
    
    Frame* _frame; // where all the set pieces are stored
    UISwitch* _spikeTapeSwitch;
    UISwitch* _trafficPatternSwitch;
}

@property (strong) TVPopoverViewController* popoverCtrl;

// These methods may need to be modified as we add the implementation
- (id)initWithFrame:(CGRect) frame withProductionFrame:(Frame*)currentFrame withViewController:(TVPopoverViewController*)viewController;
- (void)spikeTape;
- (void)trafficPatterns;

@end
