//
//  TVGestureController.m
//  Prototype
//
//  Generic Gesture Controller class which manages
//  the pan, pinch, rotate, and long press gestures
//  used in the BlockLight Application.
//  Does not manage tap, swipe, and screen edge pan gestures.
//  See: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIGestureRecognizer_Class/Reference/Reference.html
//
//  Created by nang1 on 9/24/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "TVGestureController.h"

@implementation TVGestureController

@synthesize frame = _frame;
@synthesize quickStageView = _quickStageView;

/*************************************************
 * @function: initWithFrame2 __ withStageView
 * @discussion: initialize the TVGesureController with a Frame and QuickStageView
 * @param: Frame* frame
 *     - The frame whose data is modified when a gesture is made
 * @param: QuickStageView* stageView
 *     - The QuickStageView which tracks the gestures
 * @return: id to this instance
 * @see: Frame.h
 *************************************************/
-(id) initWithFrame2:(Frame*)frame withStageView:(QuickStageView *)stageView
{
    self = [super init];
    if(self == nil)
    {
        return nil;
    }
    // else
    
    _frame = frame;
    _quickStageView = stageView;
    return self;
}

/*************************************************
 * @function: changeFrame
 * @discussion: swaps the controller's current Frame so it has reference to the data
 * @param: Frame* frame
 *     - The new frame whose data is to be modified
 *************************************************/
-(void) changeFrame:(Frame*)frame
{
    _frame = frame;
}

/*************************************************
 * @function: viewDidLoad
 * @discussion: what should happen after the view loads?
 *     (inherited from: UIViewController*)
 *************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

/*************************************************
 * @function: viewDidLoad
 * @discussion: what should happen when the memory is low?
 *     (inherited from: UIViewController*)
 *************************************************/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*************************************************
 * @function: shouldAutorotateToInterfaceOrientation
 * @discussion: should the application rotate?
 *     (inherited from: UIViewController*)
 * @param: UIInterfaceOrientation interfaceOrientation
 *    - the current UIInterfaceOrientation of the device
 * @return: BOOL, whether or not the app should autorotate
 *************************************************/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

/*************************************************
 * @function: addGestureRecognizersToView
 * @discussion: adds the pan, pinch, rotation, and long press
 *     gesture recognizers to a view in which this controller manages
 * @param: UIView* view
 *     - The UIView to add the recognizers to
 *************************************************/
-(void)addGestureRecognizersToView:(UIView *)view
{
    // create gesture recognizers
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureMoveAround:)];
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    UIRotationGestureRecognizer *rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateGesture:)];
    UILongPressGestureRecognizer *pressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressHoldGesture:)];
    
    // set gesture recognizer delegates
    [panGesture setDelegate:self];
    [pinchGesture setDelegate:self];
    [rotateGesture setDelegate:self];
    [pressGesture setDelegate:self];
    
    // add gesture recognizers to view
    [view addGestureRecognizer:panGesture];
    [view addGestureRecognizer:pinchGesture];
    [view addGestureRecognizer:rotateGesture];
    [view addGestureRecognizer:pressGesture];
    
    // enable user interaction
    [view setUserInteractionEnabled:YES];
}

/* // used to click and drag piece from one view to the next
- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
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
//*/

#pragma mark - Gesture Recognizing Methods -

/*************************************************
 * @function: gestureRecognizer __ shouldRecognizeSimultaneouslyWithGestureRecognizer
 * @discussion: yes, multiple gestures should be recognized
 * @param: UIGestureRecognizer* gestureRecognizer
 * @param: UIGestureRecognizer* otherGestureRecognizer
 *************************************************/
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

/*************************************************
 * @function: pinchGesture
 * @discussion: pinch gestures used for resizing pieces
 * @param: UIPinchGestureRecognizer* gesture
 *************************************************/
-(void)pinchGesture:(UIPinchGestureRecognizer*) gesture
{
    // grab the view and the scale
    UIView *piece = [gesture view];
    CGFloat newScale = [gesture scale]; // TODO: set scaling min and maximum values

    // calculate the new transformation matrix
    CGAffineTransform matrix = CGAffineTransformScale(piece.transform, newScale, newScale);
    [piece setTransform:matrix];

    // so the next pinch gesture doesn't become skewed
    [gesture setScale:1];

    // Used to save size of piece before it is changed
    Undo_Redo* newChange = [[Undo_Redo alloc] init];

    // save the matrix to the piece
    if([piece isMemberOfClass:[UILabel class]])
    {
        int index = [_quickStageView.noteLabels indexOfObject:(UILabel*)piece];
        Note* tempNote = [_frame.notes objectAtIndex:index];
        // Save current size in undoArray before changing it
        if([gesture state] == UIGestureRecognizerStateEnded){
            Note* noteCopy = [[_frame.notes objectAtIndex:index] copy];
            newChange.changeType = -10;
            newChange.obj = noteCopy;
            newChange.index = index;
            [_frame.undoArray addObject:newChange];
            NSLog(@"a piece was pinched");
        }
        // set new matrix
        tempNote.scaleRotationMatrix = matrix;
    }
    else if([piece isMemberOfClass:[UIImageView class]])
    {
        if(piece.tag == 10) // actor tag
        {
            int index = [_quickStageView.actorArray indexOfObject:(UIImageView*)piece];
            Actor* tempActor = [_frame.actorsOnStage objectAtIndex:index];
            // Save current size in undoArray before changing it
            if([gesture state] == UIGestureRecognizerStateEnded){
                Actor* actorCopy = [[_frame.actorsOnStage objectAtIndex:index] copy];
                newChange.changeType = -10;
                newChange.obj = actorCopy;
                newChange.index = index;
                [_frame.undoArray addObject:newChange];
                    NSLog(@"a piece was pinched");
            }
            // Set new size
            tempActor.scaleRotationMatrix = matrix;
        }
        else // set piece
        {
            int index = [_quickStageView.propsArray indexOfObject:(UIImageView*)piece];
            SetPiece* tempPiece = [_frame.props objectAtIndex:index];
            // Save current size in undoArray before changing it
            if([gesture state] == UIGestureRecognizerStateEnded){
                SetPiece* pieceCopy = [[_frame.props objectAtIndex:index] copy];
                newChange.changeType = -10;
                newChange.obj = pieceCopy;
                newChange.index = index;
                [_frame.undoArray addObject:newChange];
                    NSLog(@"a piece was pinched");
            }
            // Set new size
            tempPiece.scaleRotationMatrix = matrix;
        }
    }
}

/*************************************************
 * @function: rotateGesture
 * @discussion: rotate gestures for rotating pieces
 * @param: UIRotationGestureRecognizer* gesture
 *************************************************/
-(void)rotateGesture:(UIRotationGestureRecognizer*)gesture
{
    // grab the view and rotation
    UIView *piece = [gesture view];
    CGFloat newRotation = [gesture rotation];
    
    // calculate the new transformation matrix
    CGAffineTransform matrix = CGAffineTransformRotate(piece.transform, newRotation);
    [piece setTransform:matrix];
    
    // so the next rotation gesture doesn't become skewed
    [gesture setRotation:0];
    
    // Used to save rotation of piece before it is changed
    Undo_Redo* newChange = [[Undo_Redo alloc] init];
    
    if([piece isMemberOfClass:[UILabel class]])
    {
        int index = [_quickStageView.noteLabels indexOfObject:(UILabel*)piece];
        Note* tempNote = [_frame.notes objectAtIndex:index];
        
        // Save current rotation in undoArray before changing it
        if([gesture state] == UIGestureRecognizerStateEnded){
            Note* noteCopy = [[_frame.notes objectAtIndex:index] copy];
            newChange.changeType = -10;
            newChange.obj = noteCopy;
            newChange.index = index;
            [_frame.undoArray addObject:newChange];
            NSLog(@"a piece was rotated");
        }
        // Set new rotation
        tempNote.scaleRotationMatrix = matrix;
    }
    else if([piece isMemberOfClass:[UIImageView class]])
    {
        if(piece.tag == 10) // actor tag
        {
            int index = [_quickStageView.actorArray indexOfObject:(UIImageView*)piece];
            Actor* tempActor = [_frame.actorsOnStage objectAtIndex:index];
            
            // Save current rotation in undoArray before changing it
            if([gesture state] == UIGestureRecognizerStateEnded){
                Actor* actorCopy = [[_frame.actorsOnStage objectAtIndex:index] copy];
                newChange.changeType = -10;
                newChange.obj = actorCopy;
                newChange.index = index;
                [_frame.undoArray addObject:newChange];
                NSLog(@"a piece was rotated");
            }
            // Set new rotation
            tempActor.scaleRotationMatrix = matrix;
        }
        else // set piece
        {
            int index = [_quickStageView.propsArray indexOfObject:(UIImageView*)piece];
            SetPiece* tempPiece = [_frame.props objectAtIndex:index];
            
            // Save current rotation in undoArray before changing it
            if([gesture state] == UIGestureRecognizerStateEnded){
                SetPiece* pieceCopy = [[_frame.props objectAtIndex:index] copy];
                newChange.changeType = -10;
                newChange.obj = pieceCopy;
                newChange.index = index;
                [_frame.undoArray addObject:newChange];
                NSLog(@"a piece was rotated");
            }
            // Set new rotation
            tempPiece.scaleRotationMatrix = matrix;
        }
    }
}

/*************************************************
 * @function: pressHoldGesture
 * @discussion: press and hold gestures for bringing up menu with additional actions
 *     TODO: create popover with options to edit/delete currently selected piece
 * @param: UILongPressGestureRecognizer* gesture
 *************************************************/
-(void)pressHoldGesture:(UILongPressGestureRecognizer*)gesture
{
    if([gesture state] == UIGestureRecognizerStateBegan)
    {
        // TODO: add popup menu options for press and hold gesture
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Don't Touch Me!" message:@"Will provide popup menu with options to delete/modify pieces." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

/*************************************************
 * @function: pressHoldGesture
 * @discussion: pan gestures for moving pieces around
 * @param: UIPanGestureRecognizer* gesture
 *************************************************/
-(void)panGestureMoveAround:(UIPanGestureRecognizer*) gesture
{
    // grab the view and bring it into the front
    UIView *piece = [gesture view];
    [_quickStageView bringSubviewToFront:piece]; // TODO: Manage ordering of pieces in view
    
    //We pass in the gesture to a method that will help us align our touches so that the pan and pinch will seem to originate between the fingers instead of other points or center point of the UIView
    //[self adjustAnchorPointForGestureRecognizer:gesture];
    
    if ([gesture state] == UIGestureRecognizerStateChanged)
    {
        // grab the translation
        CGPoint translation = [gesture translationInView:[piece superview]];
        
        // x should be between ?? and ???
        //float newX = MAX([piece center].x + lroundf(translation.x), ??);
        //newX = MIN(newX, ???);
        
        // y should be between 25, and 600
        float newY = MAX([piece center].y + lroundf(translation.y), 25);
        newY = MIN(newY, 600);
        
        // so the next translation doesn't become skewed
        [gesture setTranslation:CGPointZero inView:[piece superview]];
    
        // translate the view by moving the center of the piece
        [piece setCenter:CGPointMake([piece center].x + lroundf(translation.x), newY)];
    }
    else if([gesture state] == UIGestureRecognizerStateEnded)
    {
        //Put the code that you may want to execute when the UIView became larger than certain value or just to reset them back to their original transform scale
        
        // Used to save position of piece before it was moved
        Undo_Redo* newChange = [[Undo_Redo alloc] init];

        // variables used to indicate type of piece and index of object in the array in case piece gets deleted
        NSString* pieceType = @"";
        int index = 0;
        
        // A note was moved
        if([piece isMemberOfClass:[UILabel class]])
        {            
            pieceType = @"Note";
            index = [_quickStageView.noteLabels indexOfObject:(UILabel*)piece];
            Note *tempNote = [_frame.notes objectAtIndex:index];
            Note* noteCopy = [[_frame.notes objectAtIndex:index] copy];
            
            // Save current position in undoArray before changing it
            newChange.changeType = -10;
            newChange.obj = noteCopy;
            newChange.index = index;
            [_frame.undoArray addObject:newChange];
            //NSLog(@"Prev position %i, %i", tempNote.notePosition.xCoordinate, tempNote.notePosition.yCoordinate);
            [tempNote.notePosition updateX:[piece center].x Y:[piece center].y];
            NSLog(@"New position %i, %i", tempNote.notePosition.xCoordinate, tempNote.notePosition.yCoordinate);
            
            /*
            // JNN: if we use CGPoint, we could get rid of Position.h and Position.m
            // JNN: TODO: move piece to end of array, or else figure out some way to keep ordering from back to front in tact
            while(index != [_frame.notes count] - 1)
            {
                [_frame.notes exchangeObjectAtIndex:index withObjectAtIndex:index++];
            }
            // JNN: move piece to end of array method 2
            for (UILabel* lbl in [[_quickStageView.noteLabels copy] autorelease])
            {
                if ([lbl isEqual:(UILabel*)piece])
                {
                    Note* tmp = [lbl retain];
                    [_quickStageView.noteLabels removeObject:tmp];
                    [_quickStageView.noteLabels addObject:tmp];
                    break;
                }
            }
             // JNN: ...I failed to figure out the best way to do this...
            //*/
        }
        // An actor or set piece was moved
        else if([piece isMemberOfClass:[UIImageView class]])
        {
            if(piece.tag == 10) // actor tag
            {
                pieceType = @"Actor";
                index = [_quickStageView.actorArray indexOfObject:(UIImageView*)piece];
                Actor* tempActor = [_frame.actorsOnStage objectAtIndex:index];
                Actor* actorCopy = [[_frame.actorsOnStage objectAtIndex:index] copy];
                
                // Save current position in undoArray before changing it
                newChange.changeType = -10;
                newChange.obj = actorCopy;
                newChange.index = index;
                [_frame.undoArray addObject:newChange];
                //NSLog(@"Prev position %i, %i", tempActor.actorPosition.xCoordinate, tempActor.actorPosition.yCoordinate);
                [tempActor.actorPosition updateX:[piece center].x Y:[piece center].y];
                NSLog(@"New position %i, %i", tempActor.actorPosition.xCoordinate, tempActor.actorPosition.yCoordinate);
            }
            else // non-actor tag, must be a set piece
            {
                pieceType = @"Set Piece";
                index = [_quickStageView.propsArray indexOfObject:(UIImageView*)piece];
                SetPiece* tempPiece = [_frame.props objectAtIndex:index];
                SetPiece* pieceCopy = [[_frame.props objectAtIndex:index] copy];
                
                // Save current position in undoArray before changing it
                newChange.changeType = -10;
                newChange.obj = pieceCopy;
                newChange.index = index;
                [_frame.undoArray addObject:newChange];
                //NSLog(@"Prev position %i, %i", tempPiece.piecePosition.xCoordinate, tempPiece.piecePosition.yCoordinate);
                [tempPiece.piecePosition updateX:[piece center].x Y:[piece center].y];
                NSLog(@"New position %i, %i", tempPiece.piecePosition.xCoordinate, tempPiece.piecePosition.yCoordinate);
            }
        }
        
        // if piece is on trash can
        if ([self isOnTrashCan:piece]) // user wants to delete icon
        {
            NSString *text = @"Warning: You are throwing away something. Are you sure you want to continue?";
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Trash Can" message:text delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            alert.tag = index;
            alert.title  = pieceType;
            [alert show];
        }
    }
}

/* // was supposed to be used to make identifying pieces easier, but never really got around to implementing it
-(NSString*)identifyPiece:(UIView*)view
{
    NSString* toReturn = @"";
    if([view isMemberOfClass:[UILabel class]])
    {
        toReturn = @"Note";
    }
    else if([view isMemberOfClass:[UIImageView class]])
    {
        if([view tag] == 10) // actor tag
        {
            toReturn = @"Actor";
        }
        else // non-actor tag, must be a set piece
        {
            toReturn = @"Set Piece";
        }
    }
    return toReturn;
}
 //*/

#pragma mark - Trash Can methods -

/*************************************************
 * @function: alertView __ didDismissWithButtonIndex
 * @discussion: manages the alert sent out when a piece is dragged to the trash can
 * @param: UIAlertView* alertView
 * @param: NSInteger buttonIndex
 *************************************************/
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) // pressed Ok, buttonIndex == 0 if user pressed cancel, do nothing
    {
        // Alter last change in undoArray to say it is a piece deletion, instead of moving a piece
        Undo_Redo* tempAction = [_frame.undoArray lastObject];
        tempAction.changeType = -5;
        
        //NSLog(@"Throw in trash can");
        if([alertView.title isEqual:@"Note"]){
            [self removeNoteAtIndex:alertView.tag];
        }
        else if([alertView.title isEqual:@"Set Piece"]){
            [self removeSetPieceAtIndex:alertView.tag];
        }
        else if([alertView.title isEqualToString:@"Actor"]){
            [self removeActorAtIndex:alertView.tag];
        }
    }
}

/*************************************************
 * @function: isOnTrashCan
 * @discussion: checks the location of the UIView if is within the bounding area of the trash can
 * @param: UIView* piece
 * @return: BOOL - whether or not the UIView is on the trash can
 *************************************************/
-(BOOL)isOnTrashCan:(UIView*)piece
{
    // trash can is drawn at location (0,320,64,64), see QuickStageView.m
    if((0 < [piece center].x) && ([piece center].x < 64)
       &&(320 < [piece center].y) && ([piece center].y < 384))
    {
        return true;
    }
    else
    {
        return false;
    }
}

#pragma mark - Remove Piece Methods -

/*************************************************
 * @function: removeNoteAtIndex
 * @discussion: removes a note when user drags it to the trash can
 * @param: int i
 *      - the index of the note in the Frame and QuickStageView arrays
 *************************************************/
-(void) removeNoteAtIndex:(int)i
{
    if((i < 0) || (i >= [_frame.notes count]))
    {
        // [_frame.notes count] == [_quickStageView.noteLabels count] // should always apply
        NSLog(@"Out of bounds error while removing note");
        return;
    }
    [[_quickStageView.noteLabels objectAtIndex:i] removeFromSuperview];
    [_quickStageView.noteLabels removeObjectAtIndex:i];
    [_frame.notes removeObjectAtIndex:i];
    [_quickStageView setNeedsDisplay];
}

/*************************************************
 * @function: removeActorAtIndex
 * @discussion: removes an actor when user drags it to the trash can
 * @param: int i
 *      - the index of the actor in the Frame and QuickStageView arrays
 *************************************************/
-(void) removeActorAtIndex:(int)i
{
    if((i < 0) || (i >= [_frame.actorsOnStage count]))
    {
        // [_frame.actorsOnStage count] == [_quickStageView.actorIcons count] // should always apply
        NSLog(@"Out of bounds error while removing actor");
        return;
    }
    [[_quickStageView.actorArray objectAtIndex:i] removeFromSuperview];
    [_quickStageView.actorArray removeObjectAtIndex:i];
    [_frame.actorsOnStage removeObjectAtIndex:i];
    [_quickStageView setNeedsDisplay];
}

/*************************************************
 * @function: removeSetPieceAtIndex
 * @discussion: removes a set piece when user drags it to the trash can
 * @param: int i
 *      - the index of the set piece in the Frame and QuickStageView arrays
 *************************************************/
-(void) removeSetPieceAtIndex:(int)i
{
    if((i < 0) || (i >= [_frame.props count]))
    {
        // [_frame.props count] == [_quickStageView.propIcons count] // should always apply
        NSLog(@"Out of bounds error while removing set piece");
        return;
    }
    [[_quickStageView.propsArray objectAtIndex:i] removeFromSuperview];
    [_quickStageView.propsArray removeObjectAtIndex:i];
    [_frame.props removeObjectAtIndex:i];
    [_quickStageView setNeedsDisplay];
}

@end
