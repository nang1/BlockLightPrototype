//
//  QuickStageViewController.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "QuickStageViewController.h"

//@interface QuickStageViewController ()

//@end

@implementation QuickStageViewController

@synthesize quickProduction = _quickProduction;
@synthesize performerPopover = _performerPopover;
//@synthesize viewButton = _viewButton; // _viewButton is defined outside init function because the method it calls, uses it.

/* Use loadView function instead
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */

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
	
    [_quickProduction.scenes addObject:_newScene];
	NSLog(@"Size of frames: %d\n",[_newScene.frames count]);
}

-(QuickStageView*)contentView{
	return (QuickStageView*)self.view;
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
    UIBarButtonItem* editStage = [[UIBarButtonItem alloc] initWithTitle:@"Edit Stage"
                                                             style:UIBarButtonItemStyleBordered
                                                             target:self
                                                             action:@selector(showStageEditor)];
    UIBarButtonItem* viewButton = [[UIBarButtonItem alloc] initWithTitle:@"View"
                                                             style:UIBarButtonItemStyleBordered
                                                             target:self
                                                             action:@selector(viewButton)];

    // add left-side tool bar buttons
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:back, undo, redo, editStage, viewButton, nil];
    
    // Tool buttons on right side
    UIBarButtonItem* props = [[UIBarButtonItem alloc] initWithTitle:@"Set Pieces"
                                                               style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(propsButton)];
    UIBarButtonItem* notes = [[UIBarButtonItem alloc] initWithTitle:@"Notes"
                                                              style:UIBarButtonItemStyleBordered
                                                             target:self
                                                             action:@selector(addNote)];
    //UIBarButtonItem* actors = [[UIBarButtonItem alloc] initWithTitle:@"Performers"
															//style:UIBarButtonItemStyleBordered
//                                                             target:self
//                                                             action:@selector(addActor)];

	_performers = [[UIBarButtonItem alloc] initWithTitle:@"Performers"
	style:UIBarButtonItemStyleBordered
	target:self
	action:@selector(addActor)];
	
	
    UIBarButtonItem* scenes = [[UIBarButtonItem alloc] initWithTitle:@"Scenes"
                                                               style:UIBarButtonItemStyleBordered
                                                              target:self
                                                              action:@selector(selectScene)];
    
    // add right-side tool bar buttons
//    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:props, notes, actors, scenes, nil];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:props, notes, _performers, scenes, nil];
	
	
	//Timeline setup
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
	Scene* scene = [_quickProduction.scenes objectAtIndex:0];
	
	NSIndexPath *ip=[NSIndexPath indexPathForRow:scene.curFrame inSection:0]; //need to find where curFrame is defined and edit
	[_timeline selectRowAtIndexPath:ip animated:NO scrollPosition:UITableViewScrollPositionBottom];

	[[self contentView] addSubview:_timeline];
}

-(void)tableView:(UITableView*)tableView didselectRowAtIndexPath:(NSIndexPath*)indexPath{
	NSInteger section = [indexPath section];
	NSInteger row = [indexPath row];
	
	if ([tableView isEqual:_timeline])
	{
		Scene *scene = 	[_quickProduction.scenes objectAtIndex:0];
		scene.curFrame = indexPath.row;
		Frame* frame = [scene.frames objectAtIndex:indexPath.row];
		
		// Attempt to put actors on stage
		for (Actor* p in frame.actors)
		{
			
		}
	}
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
    //DimensionsViewController* editor = [ [ DimensionsViewController alloc] init];
    //[self.navigationController pushViewController:editor animated:YES];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Edit Stage Button" message:@"This button will create a popup to let you edit stage width and height. Will implement edit stage button at a later time." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];

}

// Shows view options such as grid lines, opacity, etc.
// this is where we enable or disable certain stage options for the stage view
// ** old Blocklight has some code, but it was causing errors in here ***
- (void)viewButton {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"View Button" message:@"This button will create a popup to enable&disable view options, such as grid lines. Will implement later." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}

// Gives a popover to select props for stage
- (void)propsButton {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Set Pieces Button" message:@"This button will create a popup to select props to place on stage. Will implement later." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}

// Adds a note to the stage
- (void)addNote {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Note Button" message:@"This button will create a popup to write a note. Will implement later." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}

// Create a picker/popup to select an actor
- (void)addActor {
	UITableViewController* performerViewController = [[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
	performerViewController.title = @"Performers";
	
	_performerNav = [[UINavigationController alloc] initWithRootViewController:performerViewController];
	_performerTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 216) style:UITableViewStylePlain];

	performerViewController.view = _performerTable;
	
	_performerTable.dataSource = self;
	_performerTable.delegate = self;
	
	performerViewController.contentSizeForViewInPopover = CGSizeMake(280,90);
	_performerPopover = [[UIPopoverController alloc]initWithContentViewController:_performerNav];
	[_performerPopover presentPopoverFromBarButtonItem:_performers permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	_performerPopover.passthroughViews = [[NSArray alloc]init];
	



//    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Performers Button" message:@"This button will let you select an actor to place on the stage. Will implement later." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
//    [alert show];
}

// Create a picker/popover to select a scene
- (void)selectScene {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Scenes Button" message:@"This button will let you select a scene to switch to. Will implement later." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
	NSInteger rows = 0;
	
	// Determine # of rows in performer table inside of Performers button.
	if ([tableView isEqual:_performerTable])
	{
		Scene* curScene = [_quickProduction.scenes objectAtIndex:0];
		Frame* curFrame = [curScene.frames objectAtIndex:0];
		float benchwarmers = [curFrame.actors count] - [curFrame.actorsOnStage count];
		rows = ceil(benchwarmers/3.0f);
	}
	else if ([tableView isEqual:_timeline])
	{
		Scene* scene = [_quickProduction.scenes objectAtIndex:0];
		rows = [scene.frames count];
	}
	return rows;
}

// Set height for tables
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	CGFloat height = 50.0;
	if([tableView isEqual:_performerTable]){
		height = 90.0;
	}

	else if ([tableView isEqual:_timeline])
	{
		height = 68.0f;
	}
	return height;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
	NSInteger sections = 1;
	if ([tableView isEqual:_performerTable])
	{
		sections = 1;
	}
	return sections;
}


-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger row = [indexPath row];
//	NSInteger section = [indexPath section];

	UITableViewCell* cell = nil;
	
	if ([tableView isEqual:_performerTable])
	{
		GridTableViewCell* gridCell;
		
		Scene* scene = [_quickProduction.scenes objectAtIndex:0];
		Frame* frame = [scene.frames objectAtIndex:0];
		
		gridCell = [[GridTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"gridReuse"];
		
		NSInteger benchwarmers = [frame.actors count] - [frame.actorsOnStage count];
		
		if (row*3 < benchwarmers)
		{
			Actor* actor = [frame.actors objectAtIndex:row*3];
			UIImageView* actorView = [[UIImageView alloc]initWithImage:actor.icon];
			[actor addTarget:self action:@selector(panGestureMoveAround:)];
			[actor setDelegate:self];
			[gridCell.cell1 addSubview:actorView];
			[gridCell.cell1 setUserInteractionEnabled:YES];
			[gridCell.cell1 addGestureRecognizer:actor];
		}
		
		if (row*3+1 < benchwarmers)
		{
			Actor* actor2 = [frame.actors objectAtIndex:row*3+1];
			UIImageView* actorView2 = [[UIImageView alloc]initWithImage:actor2.icon];
			[actor2 addTarget:self action:@selector(panGestureMoveAround:)];
			[actor2 setDelegate:self];
			[gridCell.cell1 addSubview:actorView2];
			[gridCell.cell1 setUserInteractionEnabled:YES];
			[gridCell.cell1 addGestureRecognizer:actor2];
		}
		
		if (row*3+2 < benchwarmers)
		{
			Actor* actor3 = [frame.actors objectAtIndex:row*3+2];
			UIImageView* actorView3 = [[UIImageView alloc]initWithImage:actor3.icon];
			[actor3 addTarget:self action:@selector(panGestureMoveAround:)];
			[actor3 setDelegate:self];
			[gridCell.cell1 addSubview:actorView3];
			[gridCell.cell1 setUserInteractionEnabled:YES];
			[gridCell.cell1 addGestureRecognizer:actor3];
		}
		

			
		return gridCell;
	
	
	}
	
	else if ([tableView isEqual:_timeline])
	{
		cell = [[TimeLineViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
		Scene *scene = [_quickProduction.scenes objectAtIndex:0];
		Frame* frame = [scene.frames objectAtIndex:indexPath.row];
		cell.backgroundColor = [UIColor colorWithPatternImage:frame.frameIcon];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		return cell;
	}
	
	else
	{
		return cell;
	}
	return cell;
	
}


- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
	if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
		UIView *piece = gestureRecognizer.view;
		CGPoint locationInView = [gestureRecognizer locationInView:piece];
		CGPoint locationInSuperview = [gestureRecognizer locationInView:[[UIApplication sharedApplication] keyWindow].inputView];
		[[[UIApplication sharedApplication] keyWindow] addSubview:piece];
		[[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:piece];
		piece.transform = CGAffineTransformMakeRotation(M_PI+M_PI_2);
		
		piece.layer.anchorPoint = CGPointMake( locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
		piece.center = locationInSuperview;
	}
}

-(void)panGestureMoveAround:(UIPanGestureRecognizer*) gesture;
{
	
	UIView *piece = [gesture view];
	
	//We pass in the gesture to a method that will help us align our touches so that the pan and pinch will seems to originate between the fingers instead of other points or center point of the UIView
	[self adjustAnchorPointForGestureRecognizer:gesture];
	
	if (/*[gesture state] == UIGestureRecognizerStateBegan || */[gesture state] == UIGestureRecognizerStateChanged) {
		
		CGPoint translation = [gesture translationInView:[piece superview]];
		[piece setCenter:CGPointMake([piece center].x + lroundf(translation.x), [piece center].y+lroundf(translation.y))];
		[gesture setTranslation:CGPointZero inView:[piece superview]];
	}else if( [gesture state] == UIGestureRecognizerStateEnded)
	{
		//Put the code that you may want to execute when the UIView became larger than certain value or just to reset them back to their original transform scale
		
		if([gesture isMemberOfClass:[Actor class]]){
			
			Actor * performer = (Actor*) gesture;


			// Don't think we will need to keep key/value pairs now that positions are encapsulated within Actors...
			
//			NSString* key = [NSString stringWithFormat:@"%d",performer.actorID.intValue];
		//	Scene* scene = [_quickProduction.scenes objectAtIndex:0];
			//Frame* frame = [scene.frames objectAtIndex:0];
			Position* pos =  performer.actorPosition;
			if( pos == nil){
				pos = [[Position alloc] init];
				pos.xCoordinate = [piece center].x;
				pos.yCoordinate = [piece center].y;
				
				/*[frame.actorPositions setValue:pos forKey:key];
				if( ![frame.performersOnStage containsObject:performer])
					[frame.performersOnStage addObject:performer];*/
			}
			else{
				pos.xCoordinate = [piece center].x;
				pos.yCoordinate = [piece center].y;
			}
			
		}
	}
}

@end
