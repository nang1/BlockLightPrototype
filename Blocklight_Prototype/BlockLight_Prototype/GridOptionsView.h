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
}

@property (strong) TVPopoverViewController* popoverCtrl;

// These methods may need to be modified as we add the implementation
- (id)initWithViewController:(TVPopoverViewController*)viewController;
- (void)opacityChange;

@end
