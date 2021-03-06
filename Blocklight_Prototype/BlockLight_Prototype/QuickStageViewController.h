//
//  QuickStageViewController.h
//  Prototype
//
//  A controller that handles the user actions in the quick stage editor.
//
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Production.h"
#import "Frame.h"
#import "QuickStageView.h"
#import "TVNavigationController.h"
#import "TVPopoverViewController.h"
#import "Defaults.h"
#import "NoteView.h"
#import "TimeLineViewCell.h"
#import "TVGestureController.h"
#import "Undo_Redo.h"

@class TVPopoverViewController;

@interface QuickStageViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIPopoverControllerDelegate>{
    Production* _quickProduction;
    
    // These tool bar buttons are here because they are used
    // to locate position for popovers
    UIBarButtonItem* _settingsBtn;
    UIBarButtonItem* _viewButton;
    UIBarButtonItem* _propsButton;
    UIBarButtonItem* _notesButton;
    UIBarButtonItem* _actorsButton;
    UIBarButtonItem* _sceneButton;
    
    // an actual button for handling production options
    UIButton* _productionOptions;
	UIActionSheet* _productionSheet;
    
    // controlls the popovers when a tool bar button is selected
    UIPopoverController* _btnPopover;
    TVPopoverViewController* _tvPopoverCtrl;
    
    // used for popovers that may contain multiple views
    UINavigationController* _popoverNavCtrl;

    // controls the gesture movements on stage
    TVGestureController* _gestureCtrl;
	
	//Timeline
	UITableView* _timeline;
}

// Buttons
@property (strong) Production* quickProduction;
@property (strong) UIBarButtonItem* settingsBtn;
@property (strong) UIBarButtonItem* viewButton;
@property (strong) UIBarButtonItem* propsButton;
@property (strong) UIBarButtonItem* notesButton;
@property (strong) UIBarButtonItem* actorsButton;
@property (strong) UIBarButtonItem* sceneButton;
@property (strong) UIButton* productionOptions;
//@property (strong) UIActionSheet* productionSheet;

// Controllers
@property (nonatomic, retain) UIPopoverController* btnPopover;
@property (nonatomic, retain) TVPopoverViewController* tvPopoverCtrl;
@property (nonatomic, retain) UINavigationController* popoverNavCtrl;
@property (nonatomic, retain) TVGestureController* gestureCtrl;

// Methods:
- (void)pressPopoverButton:(UIBarButtonItem*)btn;
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController;

- (void)addNoteToStage:(Note*)note;
- (void)addActorToStage:(Actor*)actor;
- (void)addSetPieceToStage:(SetPiece*)newPiece;
- (void)productionOptionsAS;

@end
