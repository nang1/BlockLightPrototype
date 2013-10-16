//
//  QuickStageViewController.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
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

@class TVPopoverViewController;
//@class TVGestureController;

@interface QuickStageViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate>{
    Production* _quickProduction;
    
    // These tool bar buttons are here because they are used
    // to locate position for popovers
    UIBarButtonItem* _viewButton;
    UIBarButtonItem* _propsButton;
    UIBarButtonItem* _notesButton;
    UIBarButtonItem* _actorsButton;
    UIBarButtonItem* _sceneButton;
    
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

@property (strong) Production* quickProduction;
@property (strong) UIBarButtonItem* viewButton;
@property (strong) UIBarButtonItem* propsButton;
@property (strong) UIBarButtonItem* notesButton;
@property (strong) UIBarButtonItem* actorsButton;
@property (strong) UIBarButtonItem* sceneButton;
@property (nonatomic, retain) UIPopoverController* btnPopover;
@property (nonatomic, retain) TVPopoverViewController* tvPopoverCtrl;
@property (nonatomic, retain) UINavigationController* popoverNavCtrl;
@property (nonatomic, retain) TVGestureController* gestureCtrl;

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController;
- (void)createPopover:(TVPopoverViewController*)_popoverViewCtrl withType:(EditTools)_type;
- (void)addNoteToStage:(Note*)note;
- (void)addActorToStageFromFrame;
- (void)addSetPieceToStage:(SetPiece*)newPiece;

@end
