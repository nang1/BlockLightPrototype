//
//  TVPopoverViewController.h
//  Prototype
//
//  Created by nang1 on 9/21/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

//@class NoteView;

#import <UIKit/UIKit.h>
#import "Defaults.h"
#import "Production.h"
#import "QuickStageView.h"
#import "NoteView.h"
#import "ViewView.h"
#import "SetPieceView.h"
#import "AllSetPieceView.h"
#import "GridOptionsView.h"

@interface TVPopoverViewController : UIViewController
{
    // This connects to btnPopover in QuickStageViewController
    UIPopoverController* _popover;
    QuickStageView* _quickView;
    Production* _production;
    
    // Used for popovers that may contain multiple views
    UINavigationController* _popoverNav;
}

- (id)initPopoverView:(EditTools)_type withStage:(QuickStageView*) quickStage withProduction:(Production*)production;
-(void)dismissPopoverView;

@property (nonatomic, strong) UIPopoverController* popover;
@property (nonatomic, strong) QuickStageView* quickView;
@property (nonatomic, strong) Production* production;
@property (nonatomic, strong) UINavigationController* popoverNav;

@end
