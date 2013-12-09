//
//  QuickStageViewController.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
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

// Imports: Production.h - calls Scene.h
- (void)loadView {
    // this production is meant only as scratch paper
    // the user must save it otherwise it all data will be removed
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

// This function does additional setup after loadView()
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

    // add left-side tool bar buttons
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
    
    // add right-side tool bar buttons
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
    
    
	// Add button and table to view
	[[self contentView] addSubview:_productionOptions];
	[[self contentView] addSubview:_timeline];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	// TODO: some of these viewControllers have this correct, and others don't, need to resolve this
    // JNN: may have already been fixed now
	return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Methods that tool bar buttons call when selected -

// Go back to main menu
- (void)backToMain{
    /* This means we need to go back to a Split View
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [mainDelegate toggleEditViewWithGroup:_group];
     */
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Back Button" message:@"This button will move you back to the main menu. Will implement back button at a later time." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}

// Undo the move that the user last did
- (void)undoButton {
    // Get frame
    Scene *tempScene = [_quickProduction.scenes objectAtIndex:_quickProduction.curScene];
    Frame *tempFrame = [tempScene.frames objectAtIndex:tempScene.curFrame];

    if([tempFrame.undoArray count] == 0){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Undo Button" message:@"No saved action to undo." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    } else {
        // Get last change
        Undo_Redo* lastChange = [tempFrame.undoArray lastObject];
        switch(lastChange.changeType){
            case -1: // Added an object, so delete it
                if([lastChange.obj isKindOfClass:[Note class]]){
                    [_gestureCtrl removeNoteAtIndex:lastChange.index];
                }
                else if([lastChange.obj isKindOfClass:[Actor class]]){
                    [_gestureCtrl removeActorAtIndex:lastChange.index];
                }
                else if([lastChange.obj isKindOfClass:[SetPiece class]]){
                    [_gestureCtrl removeSetPieceAtIndex:lastChange.index];
                }
                break; // End undo adding an object
                
            case -5: // Deleted an object, bring it back
                if([lastChange.obj isKindOfClass:[Note class]]){
                    [tempFrame.notes addObject:lastChange.obj];
                    [self addNoteToStage:[tempFrame.notes lastObject]];
                    // Save note's index for redo feature
                    lastChange.index = [tempFrame.notes count] - 1;
                }
                else if([lastChange.obj isKindOfClass:[Actor class]]){
                    [tempFrame.actorsOnStage addObject:lastChange.obj];
                    [self addActorToStage:[tempFrame.actorsOnStage lastObject]];
                    // Save actor's index for redo feature
                    lastChange.index = [tempFrame.actorsOnStage count] - 1;
                }
                else if([lastChange.obj isKindOfClass:[SetPiece class]]){
                    [tempFrame.props addObject:lastChange.obj];
                    [self addSetPieceToStage:[tempFrame.props lastObject]];
                    // Save set piece's index for redo feature
                    lastChange.index = [tempFrame.props count] - 1;
                }
                break; // End undo deleting an object
                
            case -10: // Moved a piece. To undo, move it back to previous position
                if([lastChange.obj isKindOfClass:[Note class]]){
                    // Change note position to its previous position
                    Note *prevPos = (Note*)lastChange.obj;
                    Note* currentPos = [tempFrame.notes objectAtIndex:lastChange.index];
                    [currentPos.notePosition updateX:[prevPos.notePosition xCoordinate] Y:[prevPos.notePosition yCoordinate]];

                    // Update View
                    UILabel* tempView = [[self contentView].noteLabels objectAtIndex:lastChange.index];
                    [self updateUndoRedoView:prevPos.notePosition ofObject:tempView];
                }
                else if([lastChange.obj isKindOfClass:[Actor class]]){
                    // Change actor position to its previous position
                    Actor *prevPos = (Actor*)lastChange.obj;
                    Actor* currentPos = [tempFrame.actorsOnStage objectAtIndex:lastChange.index];
                    [currentPos.actorPosition updateX:[prevPos.actorPosition xCoordinate] Y:[prevPos.actorPosition yCoordinate]];
						
                    // Update view
                    UIImageView* tempView =[[self contentView].actorArray objectAtIndex:lastChange.index];
                    [self updateUndoRedoView:prevPos.actorPosition ofObject:tempView];
                }
				else if([lastChange.obj isKindOfClass:[SetPiece class]]){
                    // Change set piece position to its previous position
                    SetPiece *prevPos = (SetPiece*)lastChange.obj;
                    SetPiece* currentPos = [tempFrame.props objectAtIndex:lastChange.index];
                    [currentPos.piecePosition updateX:[prevPos.piecePosition xCoordinate] Y:[prevPos.piecePosition yCoordinate]];
						
                    // Update view
                    UIImageView* tempView = [[self contentView].propsArray objectAtIndex:lastChange.index];
                    [self updateUndoRedoView:prevPos.piecePosition ofObject:tempView];
				}
                break;
            default: // pinched / rotated an object
                break;
        }
        // lastChange was altered, make a copy and put into redoArray
        Undo_Redo *changeCopy = [lastChange copy];
        [tempFrame.redoArray addObject:changeCopy];
        // remove the change from frame's undoArray, put into redoArray
        [tempFrame.undoArray removeLastObject];
    }
}

// An undo move was performed, need to update view to show movement
-(void)updateUndoRedoView:(Position*)pos ofObject:(UIView*)obj{
    CGRect r = [obj frame];
    r.origin.x = pos.xCoordinate;
    r.origin.y = pos.yCoordinate;
    [obj setFrame:r];
    NSLog(@"Moved position %i, %i", pos.xCoordinate, pos.yCoordinate);
}

// Redo the move that the user last did
- (void)redoButton {
    /*UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Redo Button" message:@"This button will redo the change caused by undo. Will implement redo button at a later time." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];*/
    // Get frame
    Scene *tempScene = [_quickProduction.scenes objectAtIndex:_quickProduction.curScene];
    Frame *tempFrame = [tempScene.frames objectAtIndex:tempScene.curFrame];
        
    if([tempFrame.redoArray count] == 0){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Redo Button" message:@"No saved action to undo." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
    } else {
        // Get last change
        Undo_Redo* lastChange = [tempFrame.redoArray lastObject];
        switch(lastChange.changeType){
            case -1: // An object was deleted, bring it back
                if([lastChange.obj isKindOfClass:[Note class]]){
                    [tempFrame.notes addObject:lastChange.obj];
                    [self addNoteToStage:[tempFrame.notes lastObject]];
                    // Save note's index for redo feature
                    //lastChange.index = [tempFrame.notes count] - 1;
                }
                else if([lastChange.obj isKindOfClass:[Actor class]]){
                    [tempFrame.actorsOnStage addObject:lastChange.obj];
                    [self addActorToStage:[tempFrame.actorsOnStage lastObject]];
                    // Save actor's index for redo feature
                    //lastChange.index = [tempFrame.actorsOnStage count] - 1;
                }
                else if([lastChange.obj isKindOfClass:[SetPiece class]]){
                    [tempFrame.props addObject:lastChange.obj];
                    [self addSetPieceToStage:[tempFrame.props lastObject]];
                    // Save set piece's index for redo feature
                    //lastChange.index = [tempFrame.props count] - 1;
                }
                NSLog(@"trying to add back an object");
                break;
            default:
                break;
        }
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
    {    // These popovers are created from VIEW and PROPS respectively
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

-(NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
	NSInteger rows = 0;
	Scene* scene = [_quickProduction.scenes objectAtIndex:_quickProduction.curScene];
	
	if ([tableView isEqual:_timeline]){
		rows = [scene.frames count];
	}
	return rows;
}


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

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	CGFloat height = 50.0;
	if ([tableView isEqual:_timeline]){
		height = 68.0f;
	}
	//TODO: Add more if/else blocks for other table views when added.
	return height;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	if ([tableView isEqual:_timeline]){
        Scene* scene = [_quickProduction getCurScene];
	    scene.curFrame = indexPath.row;
		
		//NSLog(@"Current frame is: %d",scene.curFrame);

        Frame* frame = [scene getCurFrame];
        // Consider clearing the undoArray
        // [frame.undoArray removeAllObjects];
        [_gestureCtrl changeFrame:frame]; // the frame had changed

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
		
		// add new notes, props, and actors from frame
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

- (void)productionOptionsAS{
	_productionSheet = [[UIActionSheet alloc] initWithTitle:@"Production" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Delete Current Frame", @"Copy Current Frame", @"New Frame", nil];
	
	[_productionSheet showFromRect:_productionOptions.frame inView:self.view animated:YES];
	
}

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
