//
//  TVPopoverViewController.h
//  Prototype
//
//  A controller class that controls what view will appear in the popover
//  when the user clicks on a button in the navigation bar in the
//  stage editor.
// 
//  Created by Nicole Ang on 9/21/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Defaults.h"
#import "Production.h"
#import "QuickStageView.h"
#import "NoteView.h"
#import "SettingsView.h"
#import "ViewView.h"
#import "SetPieceView.h"
#import "SetPieceListView.h"
#import "GridOptionsView.h"
#import "ActorView.h"

@interface TVPopoverViewController : UIViewController
{
    // This connects to btnPopover in QuickStageViewController
    UIPopoverController* _popover;
    QuickStageView* _quickView;
    Production* _production;
    
    // Used for popovers that may contain multiple views
    // i.e. SetPieceView and ViewView
    UINavigationController* _popoverNav;
}

- (id)initPopoverView:(EditTools)_type withStage:(QuickStageView*) quickStage withProduction:(Production*)production;
-(void)dismissPopoverView;
- (void)setPropListType:(ListType)pType;

@property (nonatomic, strong) UIPopoverController* popover;
@property (nonatomic, strong) QuickStageView* quickView;
@property (nonatomic, strong) Production* production;
@property (nonatomic, strong) UINavigationController* popoverNav;

@end
