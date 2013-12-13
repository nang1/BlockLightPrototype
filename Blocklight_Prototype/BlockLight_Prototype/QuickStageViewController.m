//
//  QuickStageViewController.m
//  Prototype
//
//  A controller that handles all the user interactions in the quick
//  stage editor.
//
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "QuickStageViewController.h"

@implementation QuickStageViewController

@synthesize quickProduction = _quickProduction;
@synthesize settingsBtn = _settingsBtn;
@synthesize viewButton = _viewButton;
@synthesize propsButton = _propsButton;
@synthesize notesButton = _notesButton;
@synthesize actorsButton = _actorsButton;
@synthesize sceneButton = _sceneButton;
@synthesize btnPopover = _btnPopover;
@synthesize tvPopoverCtrl = _tvPopoverCtrl;
@synthesize popoverNavCtrl = _popoverNavCtrl;
@synthesize gestureCtrl = _gestureCtrl;

/* Use loadView function instead
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */

#pragma mark - Accessors -

/*************************************************
 * @function: contentView
 * @discussion: used as a quick wrapper to get the QuickStageView
 *    associated with the controller instead of having to typecast
 *    the current UIView all the time
 * @return: QuickStageView*
 *************************************************/
- (QuickStageView*)contentView
{
    return (QuickStageView*)self.view;
}

/**********************************************************
 * @function: loadView
 * @discussion: Creates the quick stage editor view. 
 *              uses imports: Production.h which calls init method
 *              in Scene.h
 *********************************************************/
- (void)loadView {
    // This production is meant only as scratch paper
    // The user must save it otherwise it all data will be removed upon
    // exiting the application.
    _quickProduction = [[Production alloc] init];
    
    // create initial scene and frame to start
    Scene* _newScene = [[Scene alloc] init];
    [_newScene.frames addObject:[[Frame alloc] init]];
    [_newScene.frames addObject:[[Frame alloc] init]];
    [_quickProduction.scenes addObject:_newScene];
    
    // set the QuickStageView as the view
    QuickStageView* _stageView = [[QuickStageView alloc] initWithFrame:CGRectZero andViewController:self andStage:_quickProduction.stage];
    self.view = _stageView;
    
    // make the gesture controller with the current frame and view
    _gestureCtrl = [[TVGestureController alloc] initWithFrame2:[_newScene getCurFrame] withStageView:_stageView];
}

/**********************************************************
 * @function: viewDidLoad
 * @discussion: This method provides additional setup after loadView()
 *              It sets up the navigation bar at the top of the screen
 *              and the frame timeline at the bottom of the screen.
 *********************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //*** Set tool bar ***
    
    // Tool buttons on left side
    UIBarButtonItem* back = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                        style:UIBarButtonItemStyleBordered
                                                        target:self
                                                        action:@selector(backToMain)];
    UIBarButtonItem* undo = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo
                                                        target:self
                                                        action:@selector(undoButton)];
    UIBarButtonItem* redo = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRedo
                                                        target:self
                                                        action:@selector(redoButton)];
    _settingsBtn = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                    style:UIBarButtonItemStyleBordered
                                                   target:self
                                                   action:@selector(pressPopoverButton:)];
    _viewButton = [[UIBarButtonItem alloc] initWithTitle:@"View"
                                                   style:UIBarButtonItemStyleBordered
                                                  target:self
                                                  action:@selector(pressPopoverButton:)];

    // add left-side tool bar buttons to navigation bar
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:back, undo, redo, _settingsBtn, _viewButton, nil];
    
    // set title to production's stage name
    self.navigationItem.title = _quickProduction.stage.name;
    
    // Tool buttons on right side
    _propsButton = [[UIBarButtonItem alloc] initWithTitle:@"Set Pieces"
                                                    style:UIBarButtonItemStyleBordered
                                                   target:self
                                                   action:@selector(pressPopoverButton:)];
    _notesButton = [[UIBarButtonItem alloc] initWithTitle:@"Notes"
                                                    style:UIBarButtonItemStyleBordered
                                                   target:self
                                                   action:@selector(pressPopoverButton:)];
    _actorsButton = [[UIBarButtonItem alloc] initWithTitle:@"Performers"
                                                     style:UIBarButtonItemStyleBordered
                                                    target:self
                                                    action:@selector(pressPopoverButton:)];
    _sceneButton = [[UIBarButtonItem alloc] initWithTitle:@"Scenes"
                                                    style:UIBarButtonItemStyleBordered
                                                   target:self
                                                   action:@selector(pressPopoverButton:)];
    
    // add right-side tool bar buttons to navigation bar
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:_propsButton, _notesButton, _actorsButton, _sceneButton, nil];
    
    // Add a timeline view for frames at the bottom of the screen
	//Timeline setup
	Scene* scene = [_quickProduction.scenes objectAtIndex:_quickProduction.curScene];
	_timeline = [[UITableView alloc] initWithFrame:CGRectMake(50, 505, 600, 50) style:UITableViewStyleGrouped];
	_timeline.delegate = self;
	_timeline.dataSource = self;
	_timeline.separatorStyle = UITableViewCellSeparatorStyleNone;
	// Rotates the view.
	CGAffineTransform transform = CGAffineTransformMakeRotation(-1.5707963);
	_timeline.transform = transform;
	// Repositions and resizes the view.
	CGRect contentRect = CGRectMake(60, 640, 900, 65);
	_timeline.frame = contentRect;
	_timeline.pagingEnabled= NO;
	_timeline.backgroundView = nil;
	_timeline.backgroundView = [[UIView alloc] init] ;
	_timeline.backgroundColor = [UIColor lightTextColor];
	
	// Selects the current frame in the time line
	NSIndexPath *ip=[NSIndexPath indexPathForRow:scene.curFrame inSection:0]; //need to find where curFrame is defined and edit
	[_timeline selectRowAtIndexPath:ip animated:NO scrollPosition:UITableViewScrollPositionBottom];
	
	// Creating the Production options button
	_productionOptions = [UIButton buttonWithType:UIButtonTypeCustom];
	_productionOptions.frame = CGRectMake(960, 640, 65, 65);
	UIImage* productionImage = [UIImage imageNamed:@"production-settings"];
	UIImageView* productionView = [[UIImageView alloc] initWithImage:productionImage];
	productionView.frame = CGRectMake(18, 5, 28, 31);
	//label sits on top of button
	UILabel* productionLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 35, 65, 15)];
	productionLabel.text = @"Production";
	productionLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
	productionLabel.backgroundColor = [UIColor clearColor];
	
	_productionOptions.backgroundColor = [UIColor lightTextColor];
	[_productionOptions addSubview:productionView];
	[_productionOptions addSubview:productionLabel];
	[_productionOptions addTarget:self action:@selector(productionOptionsAS) forControlEvents:UIControlEventTouchUpInside];
    
    
	// Add production settings button and timeline table to quick stage view
	[[self contentView] addSubview:_productionOptions];
	[[self contentView] addSubview:_timeline];
}

/**********************************************************
 * @function: viewDidUnload
 * @discussion: what should happen after the view unloads?
 *     (inherited from: UIViewController*)
 *********************************************************/
- (void)viewDidUnload {
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

/**********************************************************
 * @function: shouldAutorotateToInterfaceOrientation
 * @discussion: Indicates whether to support different orientations or not.
 *    TODO: some of these viewControllers have this correct, and others
 *          others don't, need to resolve this.
 *           Update: may have already been fixed now.
 *********************************************************/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return YES;
}

/*********************************************************
 * @function: didReceiveMemoryWarning
 * @discussion: what should happen when the memory is low?
 *     (inherited from: UIViewController*)
 *********************************************************/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Methods that tool bar buttons call when selected -

/*********************************************************
 * @function: backToMain
 * @discussion: User clicked the 'Back' button. This should go back to the 
 *              main menu.
 *********************************************************/
- (void)backToMain{
    /* This means we need to go back to a Split View. Refer to older version of BlockLight
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [mainDelegate toggleEditViewWithGroup:_group];
     */
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Back Button" message:@"This button will move you back to the main menu. Will implement back button at a later time." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}

#pragma mark Methods to perform undo and redo
/*********************************************************
 * @function: UndoRedoAction __withFrame
 * @discussion: Figure out what action needs to be performed
 * @param: Undo_Redo* lastChange - object with the information about 
 *                                 the last thing the user did
 *         Frame* tempFrame - need to know which frame to update
 *                            when performing the undo/redo
 *********************************************************/
-(void)UndoRedoAction:(Undo_Redo*)lastChange withFrame:(Frame*)tempFrame {
    switch(lastChange.changeType){
        case -1: // An object was deleted, bring it back
            [self UndoRedoDelete:lastChange];
            lastChange.changeType = -5;
            break;
            
        case -5: // An object was added, now delete it
            [self UndoRedoAdd:lastChange withFrame:tempFrame];
            lastChange.changeType = -1;
            break;
            
        case -10: // An object's position was undone, redo it
            [self UndoRedoGesture:lastChange withFrame:tempFrame];
            break;
            
        default:
            break;
    }
}

/*********************************************************
 * @function: UndoRedoUpdateView __ofObject __ withScale
 * @discussion: An undo/redo move was performed, need to update
 *              the view to show the change.
 * @param: Position* pos - where the item should be moved to
 *         UIView* obj - the view that needs to be updated
 *         CGAffineTransform newScale - the scale and rotation of the object's view
 *********************************************************/
-(void)UndoRedoUpdateView:(Position*)pos ofObject:(UIView*)obj withScale:(CGAffineTransform)newScale{
    [obj setCenter:CGPointMake(pos.xCoordinate, pos.yCoordinate)];
    [obj setTransform:newScale];
}

/*********************************************************
 * @function: UndoRedoDelete
 * @discussion: An undo/redo action is to delete an object that
 *              was added to the frame. Find out what object it is
 *              and remove it from the corresponding array.
 * @param: Undo_Redo* lastChange - information about the object that was added
 *********************************************************/
-(void)UndoRedoDelete:(Undo_Redo*)lastChange{
    if([lastChange.obj isKindOfClass:[Note class]]){
        [_gestureCtrl removeNoteAtIndex:lastChange.index];
    }
    else if([lastChange.obj isKindOfClass:[Actor class]]){
        [_gestureCtrl removeActorAtIndex:lastChange.index];
    }
    else if([lastChange.obj isKindOfClass:[SetPiece class]]){
        [_gestureCtrl removeSetPieceAtIndex:lastChange.index];
    }
    NSLog(@"Undo adding object / Redo deleting object");
}

/*********************************************************
 * @function: UndoRedoAdd __withFrame
 * @discussion: An undo/redo action is to add an object that
 *              was deleted from the frame. Find out what object it is
 *              and add it from the corresponding array.
 * @param: Undo_Redo* lastChange - information about the object that was added
 *         Frame* tempFrame - the frame to add the object back into
 *********************************************************/
-(void)UndoRedoAdd:(Undo_Redo*)lastChange withFrame:(Frame*)tempFrame{
    if([lastChange.obj isKindOfClass:[Note class]]){
        [tempFrame.notes addObject:lastChange.obj];
        [self addNoteToStage:[tempFrame.notes lastObject]];
        // Save note's index for undo/redo, which will delete it again
        lastChange.index = [tempFrame.notes count] - 1;
    }
    else if([lastChange.obj isKindOfClass:[Actor class]]){
        [tempFrame.actorsOnStage addObject:lastChange.obj];
        [self addActorToStage:[tempFrame.actorsOnStage lastObject]];
        // Save actor's index for undo/redo, which will delete it again
        lastChange.index = [tempFrame.actorsOnStage count] - 1;
    }
    else if([lastChange.obj isKindOfClass:[SetPiece class]]){
        [tempFrame.props addObject:lastChange.obj];
        [self addSetPieceToStage:[tempFrame.props lastObject]];
        // Save set piece's index for undo/redo, which will delete it again
        lastChange.index = [tempFrame.props count] - 1;
    }
    NSLog(@"Undo deleting object / Redo adding new object");
}

/*********************************************************
 * @function: UndoRedoGesture
 * @discussion: An undo/redo pan/pinch/rotate gesture. Find out what object it is
 *              and change its position and scaleRotationMatrix.
 * @param: Undo_Redo* lastChange - information about the object that was added
 *         Frame* tempFrame - the frame that the changed item is located in
 *********************************************************/
-(void)UndoRedoGesture:(Undo_Redo*)lastChange withFrame:(Frame*)tempFrame {
    if([lastChange.obj isKindOfClass:[Note class]]){
        // Change note position to its previous position
        Note* prevPos = (Note*)lastChange.obj;
        Note* currentPos = [tempFrame.notes objectAtIndex:lastChange.index];
        Position* tempCurrentPos = [currentPos.notePosition copy];
        CGAffineTransform tempCurrentTrans = currentPos.scaleRotationMatrix;
        [currentPos.notePosition updateX:[prevPos.notePosition xCoordinate] Y:[prevPos.notePosition yCoordinate]];
        currentPos.scaleRotationMatrix = prevPos.scaleRotationMatrix;
        
        // Update View
        UILabel* tempView = [[self contentView].noteLabels objectAtIndex:lastChange.index];
        [self UndoRedoUpdateView:prevPos.notePosition ofObject:tempView withScale:prevPos.scaleRotationMatrix];
        
        // Save position and transform matrix for undo/redo
        [prevPos.notePosition updateX:tempCurrentPos.xCoordinate Y:tempCurrentPos.yCoordinate];
        prevPos.scaleRotationMatrix = tempCurrentTrans;
    }
    else if([lastChange.obj isKindOfClass:[Actor class]]){
        // Change actor position to its previous position
        Actor *prevPos = (Actor*)lastChange.obj;
        Actor* currentPos = [tempFrame.actorsOnStage objectAtIndex:lastChange.index];
        Position* tempCurrentPos = [currentPos.actorPosition copy];
        CGAffineTransform tempCurrentTrans = currentPos.scaleRotationMatrix;
        [currentPos.actorPosition updateX:[prevPos.actorPosition xCoordinate] Y:[prevPos.actorPosition yCoordinate]];
        currentPos.scaleRotationMatrix = prevPos.scaleRotationMatrix;
        
        // Update view
        UIImageView* tempView =[[self contentView].actorArray objectAtIndex:lastChange.index];
        [self UndoRedoUpdateView:prevPos.actorPosition ofObject:tempView withScale:prevPos.scaleRotationMatrix];
        
        // Save position and transform matrix for undo/redo
        [prevPos.actorPosition updateX:tempCurrentPos.xCoordinate Y:tempCurrentPos.yCoordinate];
        prevPos.scaleRotationMatrix = tempCurrentTrans;
    }
    else if([lastChange.obj isKindOfClass:[SetPiece class]]){
        // Change set piece position to its previous position
        SetPiece *prevPos = (SetPiece*)lastChange.obj;
        SetPiece* currentPos = [tempFrame.props objectAtIndex:lastChange.index];
        Position* tempPos = [currentPos.piecePosition copy];
        CGAffineTransform tempCurrentTrans = currentPos.scaleRotationMatrix;
        [currentPos.piecePosition updateX:[prevPos.piecePosition xCoordinate] Y:[prevPos.piecePosition yCoordinate]];
        currentPos.scaleRotationMatrix = prevPos.scaleRotationMatrix;
        
        // Update view
        UIImageView* tempView = [[self contentView].propsArray objectAtIndex:lastChange.index];
        [self UndoRedoUpdateView:prevPos.piecePosition ofObject:tempView withScale:prevPos.scaleRotationMatrix];
        
        // Save position and transform matrix for undo/redo
        [prevPos.piecePosition updateX:tempPos.xCoordinate Y:tempPos.yCoordinate];
        prevPos.scaleRotationMatrix = tempCurrentTrans;
    }
    NSLog(@"Undo/Redo move/pinch/rotate gesture");
}

/*********************************************************
 * @function: undoButton
 * @discussion: Undo the move that the user last did
 *********************************************************/
- (void)undoButton {
    // Get frame that the user is currently viewing
    Scene *tempScene = [_quickProduction.scenes objectAtIndex:_quickProduction.curScene];
    Frame *tempFrame = [tempScene.frames objectAtIndex:tempScene.curFrame];
    
    if([tempFrame.undoArray count] == 0){
        // No action to undo
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Undo Button" message:@"No saved action to undo." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    } else {
        // Get last change
        Undo_Redo* lastChange = [tempFrame.undoArray lastObject];
        [self UndoRedoAction:lastChange withFrame:tempFrame];
        
        // lastChange was altered during UndoRedoAction
        // make a copy and put into redoArray
        Undo_Redo *changeCopy = [lastChange copy];
        [tempFrame.redoArray addObject:changeCopy];
        
        // remove the change from frame's undoArray
        [tempFrame.undoArray removeLastObject];
    }
}

/*********************************************************
 * @function: redoButton
 * @discussion: Redo the move that the user last did
 *********************************************************/
- (void)redoButton {
    // Get frame
    Scene *tempScene = [_quickProduction.scenes objectAtIndex:_quickProduction.curScene];
    Frame *tempFrame = [tempScene.frames objectAtIndex:tempScene.curFrame];
    
    if([tempFrame.redoArray count] == 0){
        // No moves to redo
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Redo Button" message:@"No saved action to undo." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
    } else {
        // Get last change
        Undo_Redo* lastChange = [tempFrame.redoArray lastObject];
        [self UndoRedoAction:lastChange withFrame:tempFrame];
        
        // lastChange was altered during UndoRedoAction
        // make a copy and put into undoArray
        Undo_Redo *changeCopy = [lastChange copy];
        [tempFrame.undoArray addObject:changeCopy];
        
        // remove change from frame's redoArray
        [tempFrame.redoArray removeLastObject];
    }
}

/*************************************************
 * @function: pressPopoverButton
 * @discussion: Method for creating popover upon bar button press
 * @param: UIBarButtonItem* btn
 *     - the UIBarButtonItem the user had pressed
 *************************************************/
-(void) pressPopoverButton:(UIBarButtonItem *)btn
{
    EditTools type = GRID; // just giving it some default value
    
    // instead of checking the buttons, could check btn.title or btn.tag instead
    if([btn isEqual:_settingsBtn])
    {
        type = SETTINGS; // Stage editor view to edit the name, width, and height of the stage
        // See: SettingsView.m
    }
    else if([btn isEqual:_viewButton])
    {
        type = VIEWS; // Shows view options such as grid lines, opacity, etc.
        // this is where we enable or disable certain stage options for the stage view
        // See: ViewView.m and GridOptionsView.m
    }
    else if([btn isEqual:_propsButton])
    {
        type = PROPS; // Gives a popover to select props for stage
        // See: SetPieceView.m and SetPieceListView.m
    }
    else if([btn isEqual:_notesButton])
    {
        type = NOTES; // Adds a note to the stage
        // See: NoteView.m
    }
    else if([btn isEqual:_actorsButton])
    {
        type = ACTORS; // Create a picker/popup to select an actor
        // See: ActorView.m
    }
    else if([btn isEqual:_sceneButton])
    {
        type = SCENES; // Create a picker/popover to select a scene
        // TODO: Currently doesn't have a view
    }
    else // GRID or PROPSLIST, don't create a popover here
    {    // These popovers are created from the VIEW and PROPS popovers respectively
        return;
    }
    
    // Create popover to display views that allow user to edit stage
    _tvPopoverCtrl = [[TVPopoverViewController alloc] initPopoverView:type withStage:[self contentView] withProduction:_quickProduction];
    _popoverNavCtrl = [[UINavigationController alloc] initWithRootViewController:_tvPopoverCtrl];
    _btnPopover = [[UIPopoverController alloc] initWithContentViewController:_popoverNavCtrl];
    
    // assign popover to appear over a tool bar button
    [_btnPopover presentPopoverFromBarButtonItem:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    // array of views that user can interact w/ while popover is visible
    _btnPopover.passthroughViews = [[NSArray alloc] init];
    _btnPopover.delegate = self;
    // need to set this to dismiss popover
    _tvPopoverCtrl.popover = _btnPopover;
    _tvPopoverCtrl.popoverNav = _popoverNavCtrl;
}

/*************************************************
 * @function: popoverControllerDidDismissPopover
 * @discussion: Checks if the popover was dismissed.
 *    Add any new pieces in the frame to the stage (in a roundabout manner).
 *    Also save the change to the undoArray in case the user has a change
 *    of mind and wants to undo rather than drag the piece to the trash.
 * @param: UIPopoverController* popoverController
 *    - The UIPopoverController which was dismissed
 *************************************************/
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    
    // the title of the stage changes when you modify it in the SettingsView
    // self.navigation.title should change when the user finishes typing
    // ...yeah, I cheated and made it change whenever the popover is dismissed
    self.navigationItem.title = _quickProduction.stage.name;
    
    // Check to see if number of notes, actors, or setpieces inside frame had changed
    Frame *tempFrame = [_quickProduction getCurFrameFromScene];
    
    // a note was added
    if([tempFrame.notes count] > [[self contentView].noteLabels count])
    {
        [self addNoteToStage:[tempFrame.notes lastObject]];
        Undo_Redo* newChange = [[Undo_Redo alloc] init];
        newChange.changeType = -1;
        newChange.index = [tempFrame.notes count] - 1;
        newChange.obj =[tempFrame.notes lastObject];
        [tempFrame.undoArray addObject:newChange];
    }
    
    // a actor was added
    if([tempFrame.actorsOnStage count] > [[self contentView].actorArray count])
    {
        [self addActorToStage:[tempFrame.actorsOnStage lastObject]];
        Undo_Redo* newChange = [[Undo_Redo alloc] init];
        newChange.changeType = -1;
        newChange.index = [tempFrame.actorsOnStage count] - 1;
        newChange.obj =[tempFrame.actorsOnStage lastObject];
        [tempFrame.undoArray addObject:newChange];
    }
    
    // a setpiece was added
    if([tempFrame.props count] > [[self contentView].propsArray count]){
        [self addSetPieceToStage:[tempFrame.props lastObject]];
        Undo_Redo* newChange = [[Undo_Redo alloc] init];
        newChange.changeType = -1;
        newChange.index = [tempFrame.props count] - 1;
        newChange.obj =[tempFrame.props lastObject];
        [tempFrame.undoArray addObject:newChange];
    }
    
    [[self view] setNeedsDisplay]; // refreshes the view
}

#pragma mark - Timeline Table Methods -
/*************************************************
 * @function: tableView __ numberOfRowsInSection
 * @discussion: Determines the number of rows in a section
 * @param: UITableView* tableView
 * @param: NSIndexPath* indexPath
 * @return: NSInteger
 *************************************************/
-(NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
	NSInteger rows = 0;
	Scene* scene = [_quickProduction.scenes objectAtIndex:_quickProduction.curScene];
	
	if ([tableView isEqual:_timeline]){
		rows = [scene.frames count];
	}
	return rows;
}

/*************************************************
 * @function: numberOfSectionsInTableView
 * @discussion: Determines the number of sections for a table
 * @param: UITableView* tableView
 * @return: NSInteger
 *************************************************/
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	NSInteger sections = 1;
//	if([tableview isequal:.....])

// TODO: when we need sections in a tableview, implement here.
// Timeline, the only thing that needs it so far, has 1 section.
// This is one of the protocol methods that doesn't /need/ to be implemented
// but if you want custom #'s of sections you need to code it.

	return sections;
}

/*************************************************
 * @function: tableView __ heightForRowAtIndexPath
 * @discussion: Set height for table
 * @param: UITableView* tableView
 * @param: NSIndexPath* indexPath
 * @return: CGFloat
 *************************************************/
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	CGFloat height = 50.0;
	if ([tableView isEqual:_timeline]){
		height = 68.0f;
	}
	//TODO: Add more if/else blocks for other table views when added.
	return height;
}

/*************************************************
 * @function: tableView __ didSelectRowAtIndexPath
 * @discussion: How to respond to a row that got selected
 * @param: UITableView* tableView
 * @param: NSIndexPath* indexPath
 *************************************************/
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	if ([tableView isEqual:_timeline]){
        // User clicked on a frame in the timeline
        Scene* scene = [_quickProduction getCurScene];
	    scene.curFrame = indexPath.row;
		
		//NSLog(@"Current frame is: %d",scene.curFrame);

        Frame* frame = [scene getCurFrame];
        // Consider clearing the undo/redoArray before switching to the frame
        // [frame.undoArray removeAllObjects];
        // [frame.redoArray removeAllObjects];
        [_gestureCtrl changeFrame:frame]; // the view has switched frames

        // remove current objects from view
		for (UILabel *lbl in [self contentView].noteLabels)
		{
            [lbl removeFromSuperview];
		}
        for(UIImageView *tempView in [self contentView].propsArray){
            [tempView removeFromSuperview];
        }
        for(UIImageView *tempView in [self contentView].actorArray){
            [tempView removeFromSuperview];
        }

		// remove all notes, props, and actors in current view's arrays
		[[self contentView].noteLabels removeAllObjects];
        [[self contentView].propsArray removeAllObjects];
        [[self contentView].actorArray removeAllObjects];
		
		// add new notes, props, and actors from selected frame
		for(Note* note in frame.notes)
        {
            [self addNoteToStage:note];
		}
        for(SetPiece* piece in frame.props){
            [self addSetPieceToStage:piece];
        }
        for(Actor* piece in frame.actorsOnStage){
            [self addActorToStage:piece];
        }
        
		[self.view setNeedsDisplay];
	}
}

/*************************************************
 * @function: tableView __ cellForRowAtIndexPath
 * @discussion: UITableView Datasource for view Popover
 *     NOTE: took out some of the rows in the old Blocklight code
 * @param: UITableView* tableView
 * @param: NSIndexPath* indexPath
 * @return: UITableViewCell*
 *************************************************/
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	//TODO: NSInteger row = indexPath.row;  ... etc
	UITableViewCell* cell = nil;
	
	if([tableView isEqual:_timeline]){
		cell = [[TimeLineViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
		Scene *scene = [_quickProduction.scenes objectAtIndex:_quickProduction.curScene];
		Frame* frame = [scene.frames objectAtIndex:scene.curFrame];
		cell.backgroundColor = [UIColor colorWithPatternImage:frame.frameIcon];
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		
        // put a label on each frame of the timeline
        int myInteger = indexPath.row;
        myInteger++;
        NSString* myNewString = [NSString stringWithFormat:@"%i", myInteger];
        cell.textLabel.text = myNewString;
        [cell.textLabel setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
        
		return cell;
	}
	else{
		return cell;
	}
}

/*************************************************
 * @function: productionOptionAS
 * @discussion: User clicked the gear on the timeline. This will
 *              display options to add/copy/delete frames from 
 *              the timeline.
 *************************************************/
- (void)productionOptionsAS{
	_productionSheet = [[UIActionSheet alloc] initWithTitle:@"Production" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Delete Current Frame", @"Copy Current Frame", @"New Frame", nil];
	
	[_productionSheet showFromRect:_productionOptions.frame inView:self.view animated:YES];
}

/*************************************************
 * @function: actionSheet __clickedButtonAtIndex
 * @discussion: User selected an option to edit the frame timeline.
 * @param: UIActionSheet* actionSheet
 * @param: NSInteger buttonIndex - indicates which button the user clicked
 *************************************************/
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	if ([actionSheet isEqual:_productionSheet]){
		//Frame* newFrame = [[Frame alloc] init];
		switch (buttonIndex) {

			// 'delete' button
			case 0:
            {
				Scene *scene = [_quickProduction.scenes objectAtIndex:_quickProduction.curScene];
				
				// Don't delete if there is only one frame left - probably breaks the app =(
				if([scene.frames count] != 1){
					[scene.frames removeObjectAtIndex:scene.curFrame];
					[_timeline reloadData];
					scene.curFrame -=1;

					NSIndexPath *ip = [NSIndexPath indexPathForRow:scene.curFrame inSection:0];
					[_timeline selectRowAtIndexPath:ip animated:NO scrollPosition:UITableViewScrollPositionBottom];
					
					//Need to manually 'select' the previous frame so that we don't have leftover
					//views on screen from old frame.
					[_timeline.delegate tableView:_timeline didSelectRowAtIndexPath:ip];
					[[self view] setNeedsDisplay];
				}
				
			}
			break;
                
			// 'copy' button
			case 1:{
				Scene *scene = [_quickProduction.scenes objectAtIndex:_quickProduction.curScene];
				Frame* curFrame = [scene.frames objectAtIndex:scene.curFrame];
				Frame* newFrame = [[Frame alloc]init];
				newFrame.actorsOnStage = [[NSMutableArray alloc]initWithArray:curFrame.actorsOnStage copyItems:YES];
				newFrame.notes = [[NSMutableArray alloc]initWithArray:curFrame.notes copyItems:YES];
				newFrame.props = [[NSMutableArray alloc]initWithArray:curFrame.props copyItems:YES];
				[scene.frames addObject:newFrame];
				[_timeline reloadData];
				
				NSIndexPath *ip=[NSIndexPath indexPathForRow:scene.curFrame inSection:0];
				[_timeline selectRowAtIndexPath:ip animated:NO scrollPosition:UITableViewScrollPositionBottom];
				[[self view] setNeedsDisplay];
			}
				break;
				
			// 'new frame' button
			case 2:{
				Scene *scene = [_quickProduction.scenes objectAtIndex:_quickProduction.curScene];
				[scene.frames addObject:[[Frame alloc] init]];
				[_timeline reloadData];
				
				NSIndexPath *ip=[NSIndexPath indexPathForRow:scene.curFrame inSection:0];
				[_timeline selectRowAtIndexPath:ip animated:NO scrollPosition:UITableViewScrollPositionBottom];
				[[self view] setNeedsDisplay];
			}
				
			default:
				break;
		}
	}
}

#pragma mark - Add Pieces to Stage Methods -

/*************************************************
 * @function: addNoteToStage
 * @discussion: Adds a note piece to the stage
 * @param: Note* note
 *     - The note to add to the stage
 *************************************************/
- (void)addNoteToStage:(Note*)note
{
    // create label for the note
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(600, 30, 200, 300)];
    //UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(note.notePosition.xCoordinate, note.notePosition.yCoordinate, 100,50)];
    tempLabel.text = note.noteStr;
    tempLabel.lineBreakMode = NSLineBreakByClipping; // NSLineBreakByWordWrapping;
    tempLabel.numberOfLines = 0;
    tempLabel.textColor = [UIColor blackColor];
    tempLabel.backgroundColor = [UIColor clearColor];
    tempLabel.hidden = [self contentView].hiddenNotes;
    
    // assign the gesture recognizers for user interaction
    [_gestureCtrl addGestureRecognizersToView:tempLabel];
    
    // perform transformations
    [tempLabel sizeToFit];
    [tempLabel setCenter:CGPointMake(note.notePosition.xCoordinate, note.notePosition.yCoordinate)];
    [tempLabel setTransform:note.scaleRotationMatrix];
    
    // finally, add the label as a subview which will appear on stage
    [[self contentView].noteLabels addObject:tempLabel];
    [[self contentView] addSubview: [[self contentView].noteLabels lastObject]];
}

/*************************************************
 * @function: addActorToStage
 * @discussion: Adds an actor piece to the stage
 * @param: Actor* actor
 *     - The actor to add to the stage
 *************************************************/
- (void)addActorToStage:(Actor*)actor
{
    UIImageView* newActorIconView = [[UIImageView alloc] initWithImage:actor.actorIcon];
    
    // assign the gesture recognizers for user interaction
    [_gestureCtrl addGestureRecognizersToView:newActorIconView];
    
    // perform transformations
    [newActorIconView sizeToFit];
    [newActorIconView setCenter:CGPointMake(actor.actorPosition.xCoordinate, actor.actorPosition.yCoordinate)];
    [newActorIconView setTransform:actor.scaleRotationMatrix];
    newActorIconView.tag = 10;
    
    // put actor's name underneath icon
    UILabel* nameLbl = actor.actorName;
    nameLbl.textAlignment = NSTextAlignmentCenter;
    [newActorIconView addSubview:nameLbl];
    
    // save icon to quickstageview
    [[self contentView].actorArray addObject:newActorIconView];
    
    // add icon as subview to make it appear on the stage
    [[self contentView] addSubview:[[self contentView].actorArray lastObject]];
}

/*************************************************
 * @function: addSetPieceToStage
 * @discussion: Adds a set piece to the stage
 * @param: SetPiece* newPiece
 *     - The set piece to add to the stage
 *************************************************/
- (void)addSetPieceToStage:(SetPiece*)newPiece
{       
    UIImageView* newIconView = [[UIImageView alloc] initWithImage:newPiece.icon];
    
    // assign the gesture recognizers for user interaction
    [_gestureCtrl addGestureRecognizersToView:newIconView];
    
    // perform transformations
    [newIconView sizeToFit];
    [newIconView setCenter:CGPointMake(newPiece.piecePosition.xCoordinate, newPiece.piecePosition.yCoordinate)];
    [newIconView setTransform:newPiece.scaleRotationMatrix];
    
    // save icon to quickstageview
    [[self contentView].propsArray addObject:newIconView];

    // add icon as subview to make it appear on the stage
    [[self contentView] addSubview:[[self contentView].propsArray lastObject]];
}

@end
