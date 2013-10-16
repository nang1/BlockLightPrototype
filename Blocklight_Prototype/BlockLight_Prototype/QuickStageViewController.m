//
//  QuickStageViewController.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "QuickStageViewController.h"

@interface QuickStageViewController ()

@end

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

#pragma mark Accessors
// don't get what this is exactly, but its used multiple times
- (QuickStageView*)contentView {
    return (QuickStageView*)self.view;
}

// Imports: Production.h - calls Scene.h
- (void)loadView {
    QuickStageView* _stageView = [[QuickStageView alloc] initWithFrame:CGRectZero andViewController:self];
    self.view = _stageView;
    
    // this production is meant only as scratch paper
    // the user must save it otherwise it all data will be removed
    _quickProduction = [[Production alloc] init];
    
    // create initial scene and frame to start
    Scene* _newScene = [[Scene alloc] init];
    [_newScene.frames addObject:[[Frame alloc] init]];
    [_newScene.frames addObject:[[Frame alloc] init]];
    [_quickProduction.scenes addObject:_newScene];
	
    // JNN: not sure if this works
    _gestureCtrl = [[TVGestureController alloc] initWithFrame2: [_newScene.frames objectAtIndex:_newScene.curFrame] withStageView:_stageView];
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
                                                             action:@selector(showStageEditor)];
    _viewButton = [[UIBarButtonItem alloc] initWithTitle:@"View"
                                                             style:UIBarButtonItemStyleBordered
                                                             target:self
                                                             action:@selector(viewButtonClick)];

    // add left-side tool bar buttons
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:back, undo, redo, _settingsBtn, _viewButton, nil];
    
    // Tool buttons on right side
    _propsButton = [[UIBarButtonItem alloc] initWithTitle:@"Set Pieces"
                                                               style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(addProps)];
    _notesButton = [[UIBarButtonItem alloc] initWithTitle:@"Notes"
                                                              style:UIBarButtonItemStyleBordered
                                                             target:self
                                                             action:@selector(addNote)];
    _actorsButton = [[UIBarButtonItem alloc] initWithTitle:@"Performers"
                                                              style:UIBarButtonItemStyleBordered
                                                             target:self
                                                             action:@selector(addActor)];
    _sceneButton = [[UIBarButtonItem alloc] initWithTitle:@"Scenes"
                                                               style:UIBarButtonItemStyleBordered
                                                              target:self
                                                              action:@selector(selectScene)];
    
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
	return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** Methods that tool bar buttons call when selected **/
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
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Undo Button" message:@"This button will undo you last change to the stage. Will implement undo button at a later time." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}

// Redo the move that the user last did
- (void)redoButton {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Redo Button" message:@"This button will redo the change caused by undo. Will implement redo button at a later time." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}

// Push stage editor view
// sets the height, width, etc of stage
- (void)showStageEditor {
    _tvPopoverCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)SETTINGS withStage:[self contentView] withProduction:_quickProduction];
    [self createPopover:_tvPopoverCtrl withType:(EditTools)SETTINGS];
}

// Shows view options such as grid lines, opacity, etc.
// this is where we enable or disable certain stage options for the stage view
- (void)viewButtonClick {        
    _tvPopoverCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)VIEWS withStage:[self contentView] withProduction:_quickProduction];
    [self createPopover:_tvPopoverCtrl withType:(EditTools)VIEWS];
}

// Gives a popover to select props for stage
- (void)addProps {
    _tvPopoverCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)PROPS withStage:[self contentView] withProduction:_quickProduction];
    [self createPopover:_tvPopoverCtrl withType:(EditTools)PROPS];
}

// Adds a note to the stage
- (void)addNote
{
    _tvPopoverCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)NOTES withStage:[self contentView] withProduction:_quickProduction];
    [self createPopover:_tvPopoverCtrl withType:(EditTools)NOTES];
}

// Create a picker/popup to select an actor
- (void)addActor {
    _tvPopoverCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)ACTORS withStage:[self contentView] withProduction:_quickProduction];
    [self createPopover:_tvPopoverCtrl withType:(EditTools)ACTORS];
}

// Create a picker/popover to select a scene
- (void)selectScene {
    _tvPopoverCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)SCENES withStage:[self contentView] withProduction:_quickProduction];
    [self createPopover:_tvPopoverCtrl withType:(EditTools)SCENES];
}

// check if popover was dismissed.
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    // check to see if number of notes, actors, or setpieces inside frame had changed
    Scene *tempScene = [_quickProduction.scenes objectAtIndex:_quickProduction.curScene];
    Frame *tempFrame = [tempScene.frames objectAtIndex:tempScene.curFrame];
    
    if([tempFrame.notes count] > [[self contentView].noteLabels count])
    {
        // a note was added
        [self addNoteToStage:[tempFrame.notes lastObject]];
    }
    
    // if actor was added
    
    
    // if setpiece was added
    if([tempFrame.props count] > [[self contentView].propsArray count]){
        [self addSetPieceToStage:[tempFrame.props lastObject]];
    }
    
    [[self view] setNeedsDisplay]; // refreshes the view
}

// Create popover to display views that allow user to edit stage
- (void)createPopover:(TVPopoverViewController*)_popoverViewCtrl withType:(EditTools)_type{
    _popoverNavCtrl = [[UINavigationController alloc] initWithRootViewController:_popoverViewCtrl];
    _btnPopover = [[UIPopoverController alloc] initWithContentViewController:_popoverNavCtrl];    
    
    // assign popover to appear over a tool bar button
    switch(_type){
        case SETTINGS:
        {
            [_btnPopover presentPopoverFromBarButtonItem:_settingsBtn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
            break;
        case NOTES:
        {
            [_btnPopover presentPopoverFromBarButtonItem:_notesButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
            break;
        case VIEWS:
            [_btnPopover presentPopoverFromBarButtonItem:_viewButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            break;
        case PROPS:
            [_btnPopover presentPopoverFromBarButtonItem:_propsButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            break;
        case ACTORS:
            [_btnPopover presentPopoverFromBarButtonItem:_actorsButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            break;
        case SCENES:
            [_btnPopover presentPopoverFromBarButtonItem:_sceneButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            break;
        case GRID:
            // This is here to stop the warning, but GridOptionsView shouldn't be
            // called from here, its a sub-view of ViewView
        case ALLPROPS:
            // This is here to stop the warning, but this view shouldn't be called
            // from here, it is a sub-view of SetPieceView
            break;
    }
    // array of views that user can interact w/ while popover is visible
    _btnPopover.passthroughViews = [[NSArray alloc] init];
    _btnPopover.delegate = self;
    // need to set this to dismiss popover
    _popoverViewCtrl.popover = _btnPopover;
    _popoverViewCtrl.popoverNav = _popoverNavCtrl;
}

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
		Scene* scene = [_quickProduction.scenes objectAtIndex:_quickProduction.curScene];
	    scene.curFrame = indexPath.row;
		
		//NSLog(@"Current frame is: %d",scene.curFrame);

		//TODO: Put notes and performers in their positions
		Frame* frame = [scene.frames objectAtIndex:scene.curFrame];
        [_gestureCtrl changeFrame:frame]; // the frame had changed


		for (UILabel *lbl in [self contentView].noteLabels)
		{
			//if ([lbl isKindOfClass:[UILabel class]]){
				[lbl removeFromSuperview];
			//}
			
		}
//	NSInteger i = 0;
//		for (UILabel* lbl in self.view.
			
//		}

		// remove all notes in current view
		[[self contentView].noteLabels removeAllObjects];
		
		// add new notes
		for(Note* note in frame.notes)
        {
            [self addNoteToStage:note];
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
		
		return cell;
	}
	else{
		return cell;
	}
}

- (void)productionOptionsAS{
	_productionSheet = [[UIActionSheet alloc] initWithTitle:@"Production" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Copy Previous Frame", @"New Frame", nil];
	
	[_productionSheet showFromRect:_productionOptions.frame inView:self.view animated:YES];
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	if ([actionSheet isEqual:_productionSheet]){
		Frame* newFrame = [[Frame alloc] init];
		//[self contentView].noteLabel.text = @"";
		switch (buttonIndex) {
				
				//'copy' BUTTON
			case 0:{
				Scene* scene = [_quickProduction.scenes objectAtIndex:_quickProduction.curScene];
				Frame* curFrame = [scene.frames objectAtIndex:scene.curFrame];
				Frame* newFrame = [[Frame alloc]init];
				newFrame.spikePath = [UIBezierPath bezierPathWithCGPath:curFrame.spikePath.CGPath];
				newFrame.spikePath.lineCapStyle = kCGLineCapRound;
				newFrame.spikePath.miterLimit = 0;
				newFrame.spikePath.lineWidth =5 ;
				scene.curFrame = scene.curFrame +1;
				[scene.frames insertObject:newFrame atIndex:scene.curFrame ];
				[self contentView].myPath = newFrame.spikePath;
				[[[UIApplication sharedApplication] keyWindow]  setNeedsDisplay];
				//[self saveIcon];
                
			}
				break;
			case 1:{/*
                     //'new frame' BUTTON
                     Scene* scene = [_quickProduction.scenes objectAtIndex:_quickProduction.curScene];
                     Frame* curFrame = [scene.frames objectAtIndex:scene.curFrame];
                     
                     for( Performer* p in _group.performers){
                     NSString* key = [NSString stringWithFormat:@"%d",p.uniqueID.intValue];
                     Position* pos = [curFrame.performerPositions objectForKey:key];
                     
                     if(pos != nil){
                     [p.view removeFromSuperview];
                     }
                     }
                     
                     [self contentView].myPath = [[UIBezierPath alloc] init];
                     [self contentView].myPath.lineCapStyle=kCGLineCapRound;
                     [self contentView].myPath.miterLimit=0;
                     [self contentView].myPath.lineWidth=5;
                     
                     scene.curFrame = scene.curFrame +1;
                     [scene.frames insertObject:newFrame atIndex:scene.curFrame ];
                     [[[UIApplication sharedApplication] keyWindow]  setNeedsDisplay];
                     //[self saveIcon];*/
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

- (void)addNoteToStage:(Note*)note
{
    // create label for the note
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(600, 30, 100, 300)];
    //UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(note.notePosition.xCoordinate, note.notePosition.yCoordinate, 100,50)];
    tempLabel.text = note.noteStr;
    //tempLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tempLabel.lineBreakMode = NSLineBreakByClipping;
    tempLabel.numberOfLines = 0;
    tempLabel.textColor = [UIColor blackColor];
    tempLabel.backgroundColor = [UIColor clearColor];
    //tempLabel.center = CGPointMake(note.notePosition.xCoordinate, note.notePosition.yCoordinate);
    tempLabel.hidden = [self contentView].hiddenNotes;
    
    // assign the note a UIPanGesture Recognizer so that it can move around on stage
    UIPanGestureRecognizer * noteMover = [[UIPanGestureRecognizer alloc] initWithTarget:_gestureCtrl action:@selector(panGestureMoveAround:)];
    [noteMover setDelegate:_gestureCtrl];
    [tempLabel setUserInteractionEnabled:YES];
    [tempLabel addGestureRecognizer:noteMover];
    [tempLabel sizeToFit];
    [tempLabel setCenter:CGPointMake(note.notePosition.xCoordinate, note.notePosition.yCoordinate)];
    //NSLog(@"Center: (%d, %d)", note.notePosition.xCoordinate, note.notePosition.yCoordinate);
    
    // finally, add the label as a subview which will appear on stage
    [[self contentView].noteLabels addObject:tempLabel];
    //[self.view addSubview:tempLabel];
    [[self contentView] addSubview: [[self contentView].noteLabels lastObject]];
}

- (void)addActorToStageFromFrame
{
    // TODO: logic for adding actors to stage
}

- (void)addSetPieceToStage:(UILabel*)imageLabel
{
    /*
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Add a tree" message:@"Almost there. Just need to figure out get image." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
     //*/
    
    ///*
    // some of this needs to be moved to AllSetPieceView file
    //UIImage* newIcon = [UIImage imageNamed:@"tree"];
    //*/
}

@end
