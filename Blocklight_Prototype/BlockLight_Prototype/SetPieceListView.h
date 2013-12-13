//
//  SetPieceListView.h
//  Blocklight_Prototype
//
//  Popover view to let the user look at a list of set pieces and
//  select one to add to the stage.
//  Depending on what the user selected in SetPieceView, a
//  different list will show
// 
//  Created by Nicole Ang on 10/21/13.
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
 
    // Number of props for each category
    NSInteger _numPlants;
    NSInteger _numStairs;
    NSInteger _numPlatforms;
    NSInteger _numFurniture;
    NSInteger _numUncategorized;
}

@property (strong) TVPopoverViewController* popoverCtrl;

// These methods may need to be modified as we add the implementation
- (id)initWithFrame:(CGRect) frame withProductionFrame:(Frame*)currentFrame withViewController:(TVPopoverViewController*)viewController;
- (void)setListType:(ListType)lType;

@end
