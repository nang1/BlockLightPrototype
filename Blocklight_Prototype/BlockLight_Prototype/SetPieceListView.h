//
//  SetPieceListView.h
//  Blocklight_Prototype
//
//  Created by nang1 on 10/21/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVPopoverViewController.h"
#import "Frame.h"
#import "SetPiece.h"
#import "Defaults.h"

@interface SetPieceListView : UITableView <UITableViewDelegate, UITableViewDataSource> {
    TVPopoverViewController* _popoverCtrl;
    
    Frame* _frame; // where all the set pieces are stored
    
    ListType listType; // indicates which category of set pieces should be displayed
}

@property (strong) TVPopoverViewController* popoverCtrl;

// These methods may need to be modified as we add the implementation
- (id)initWithFrame:(CGRect) frame withProductionFrame:(Frame*)currentFrame withViewController:(TVPopoverViewController*)viewController;
- (void)addNewSetPiece:(NSString*)imageType;
- (void)setListType:(ListType)lType;

@end
