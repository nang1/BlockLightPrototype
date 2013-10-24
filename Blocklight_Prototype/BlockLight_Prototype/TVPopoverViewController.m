//
//  TVPopoverViewController.m
//  Prototype
//
//  Created by nang1 on 9/21/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "TVPopoverViewController.h"

@interface TVPopoverViewController ()

@end

@implementation TVPopoverViewController

@synthesize popover = _popover;
@synthesize quickView = _quickView;
@synthesize production = _production;
@synthesize popoverNav = _popoverNav;

- (id)initPopoverView:(EditTools)_type withStage:(QuickStageView*) quickStage withProduction:(Production*)production {
    self = [super init];
    
    if(self == nil)
        return nil;

    // else continue initialization
    _quickView = quickStage;
    _production = production; // JIC
    
    // figure out which view we need to display
    switch(_type){
        case SETTINGS:
        {
            // set size and title
            self.contentSizeForViewInPopover = CGSizeMake(320,460);
            self.title = @"Settings";
            
            // create starting view to display settings options
            SettingsView* _settingsView = [[SettingsView alloc] initWithViewController:self];
            self.view = _settingsView;
        }
            break;
            
        case NOTES:
        {
            // set size and title
            self.contentSizeForViewInPopover = CGSizeMake(320, 300);
            self.title = @"Add Note";
            
            // work around to getting current frame
            Scene* tempScene = [production.scenes objectAtIndex: production.curScene];
            Frame* tempFrame = [tempScene.frames objectAtIndex:tempScene.curFrame];
            
            // create view to add a note
            NoteView* _noteView = [[NoteView alloc] initWithFrame:CGRectMake(0,0,320,300) withProductionFrame:tempFrame withViewController:self];
            self.view = _noteView;
        }
            break;
        case VIEWS:
        {
            // set size and title
            self.contentSizeForViewInPopover = CGSizeMake(320, 460);
            self.title = @"View Options";
            
            // create starting view to disply view options
            ViewView* _viewView = [[ViewView alloc] initWithViewController:self];
            self.view = _viewView;
        }
            break;
            
        case PROPS:
        {
            // set size and title
            self.contentSizeForViewInPopover = CGSizeMake(320, 550);
            self.title = @"Props";
            
            Scene* tempScene = [production.scenes objectAtIndex: production.curScene];
            Frame* tempFrame = [tempScene.frames objectAtIndex:tempScene.curFrame];
            
            // create view to select a set piece
            SetPieceView* _setPieceView = [[SetPieceView alloc] initWithFrame:CGRectMake(0,0,320,216) withProductionFrame:tempFrame withViewController:self];
            self.view = _setPieceView;
        }
            break;
            
        case ACTORS:
        {
            // set size and title
            self.contentSizeForViewInPopover = CGSizeMake(320, 300);
            self.title = @"Add Performers";
            
            // work around to getting current frame
            Scene* tempScene = [production.scenes objectAtIndex: production.curScene];
            Frame* tempFrame = [tempScene.frames objectAtIndex:tempScene.curFrame];
            
            // create view to add actors
            ActorView* _actorView = [[ActorView alloc] initWithFrame:CGRectMake(0,0,320,300) withProductionFrame:tempFrame withViewController:self];
            self.view = _actorView;
        }
            break;
            
        case SCENES:
        {
            // set size and title
            self.contentSizeForViewInPopover = CGSizeMake(320, 300);
            self.title = @"Scene Selection";
            
            // create view to select a scene
            UIView* _sceneView = [[UIView alloc] init];
            _sceneView.backgroundColor = [UIColor lightGrayColor];
            
            UILabel* description = [[UILabel alloc] initWithFrame: CGRectMake(10,10,300,200)];
            description.text = @"This popover will let the user move";
            description.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            description.backgroundColor = [UIColor clearColor];
            UILabel* description2 = [[UILabel alloc] initWithFrame: CGRectMake(25,25,300,200)];
            description2.text = @"between different scenes.";
            description2.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            description2.backgroundColor = [UIColor clearColor];
            
            [_sceneView addSubview:description];
            [_sceneView addSubview:description2];
            self.view = _sceneView;
        }
            break;
            
        case GRID:
        { // This is called only when user clicks Grid Options in VIEWS
            // set size and title
            self.contentSizeForViewInPopover = CGSizeMake(320, 300);
            self.title = @"Grid Options";
            
            // create view to adjust grid lines
            GridOptionsView* _gridView = [[GridOptionsView alloc] initWithViewController:self];
            self.view = _gridView;
        }
            break;
            
        case PROPSLIST: // User clicked a set piece category in SetPieceView
        {
            // set size and title
            self.contentSizeForViewInPopover = CGSizeMake(320, 550);
            self.title = @"Props List";
            
            Scene* tempScene = [production.scenes objectAtIndex: production.curScene];
            Frame* tempFrame = [tempScene.frames objectAtIndex:tempScene.curFrame];
            
            // create view to select a set piece
            SetPieceListView* _setPieceListView = [[SetPieceListView alloc] initWithFrame:CGRectMake(0,0,320,216) withProductionFrame:tempFrame withViewController:self];
            self.view = _setPieceListView;
        }
            break;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// used to set the category of set pieces list
- (void)setPropListType:(ListType)pType {
    [(SetPieceListView*)self.view setListType:pType];
}

// dismiss this popover view
- (void)dismissPopoverView {
    //dismiss popover with or w/o animation
    [_popover dismissPopoverAnimated:NO];
    
    // check if popover was dismissed
    [_popover.delegate popoverControllerDidDismissPopover:_popover];
}

@end
