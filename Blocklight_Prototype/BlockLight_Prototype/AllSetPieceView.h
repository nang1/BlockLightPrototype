//
//  AllSetPieceView.h
//  Blocklight_Prototype
//
//  Created by game on 10/7/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TVPopoverViewController.h"
#import "Frame.h"
#import "SetPiece.h"

@interface AllSetPieceView : UITableView <UITableViewDelegate, UITableViewDataSource> {
    TVPopoverViewController* _popoverCtrl;
    
    Frame* _frame; // where all the set pieces are stored
}

@property (strong) TVPopoverViewController* popoverCtrl;

// These methods may need to be modified as we add the implementation
- (id)initWithFrame:(CGRect) frame withProductionFrame:(Frame*)currentFrame withViewController:(TVPopoverViewController*)viewController;
- (void)addNewSetPiece:(NSString*)imageType;

@end
