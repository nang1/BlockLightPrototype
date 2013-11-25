//
//  TVGestureController.m
//  Prototype
//
//  Created by nang1 on 9/24/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "TVGestureController.h"

@implementation TVGestureController

@synthesize frame = _frame;
@synthesize quickStageView = _quickStageView;

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

-(void) changeFrame:(Frame*)frame
{
    _frame = frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

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

/*
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

#pragma mark Gesture Recognizing Methods

// so multiple gestures can be recognized
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

// for resizing pieces
-(void)pinchGesture:(UIPinchGestureRecognizer*) gesture
{
    // grab the view and the scale
    UIView *piece = [gesture view];
    CGFloat newScale = [gesture scale];
    
    // calculate the new transformation matrix
    // JNN: TODO: set scaling min and maximum values
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

// for rotating pieces
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

// for bringing up menu with additional actions
-(void)pressHoldGesture:(UILongPressGestureRecognizer*)gesture
{
    if([gesture state] == UIGestureRecognizerStateBegan)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Don't Touch Me!" message:@"Will provide popup menu with options to delete/modify pieces." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

// for moving pieces around
-(void)panGestureMoveAround:(UIPanGestureRecognizer*) gesture
{
    /* // JNN reference: please do not delete
    CGFloat height = [UIScreen mainScreen].currentMode.size.height; // 1024px
    CGFloat width = [UIScreen mainScreen].currentMode.size.width; // 768px
    // 20px for the status bar, and 44px for the navigation bar
     
    // all stage pieces gets placed on view in following order:
    // notes, set pieces, actors, from first to last
     
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if (orientation==UIInterfaceOrientationLandscapeLeft) // rightside up
    {
        NSLog(@"left");
    }
    else if(orientation == UIInterfaceOrientationLandscapeRight) // upside down
    {
        NSLog(@"right");
    }
    //*/
    
    UIView *piece = [gesture view];
    [_quickStageView bringSubviewToFront:piece];
    
    //We pass in the gesture to a method that will help us align our touches so that the pan and pinch will seem to originate between the fingers instead of other points or center point of the UIView
    //[self adjustAnchorPointForGestureRecognizer:gesture];
    
    if ([gesture state] == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [gesture translationInView:[piece superview]];
        
        // x should be between ?? and ???
        //float newX = MAX([piece center].x + lroundf(translation.x), ??);
        //newX = MIN(newX, ???);
        
        // y should be between 25, and 600
        float newY = MAX([piece center].y + lroundf(translation.y), 25);
        newY = MIN(newY, 600);
        
        [piece setCenter:CGPointMake([piece center].x + lroundf(translation.x), newY)];
        [gesture setTranslation:CGPointZero inView:[piece superview]];
    }
    else if([gesture state] == UIGestureRecognizerStateEnded)
    {
        //Put the code that you may want to execute when the UIView became larger than certain value or just to reset them back to their original transform scale
        
        // Used to save position of piece before it was moved
        Undo_Redo* newChange = [[Undo_Redo alloc] init];
        
        NSString* pieceType = @""; // used to indicate type of piece to be deleted
        int index = 0; // used to indicate index of object to be deleted in array
        
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
             // JNN: ...I'll figure something out
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

/*
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

#pragma mark Trash Can methods
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

-(BOOL)isOnTrashCan:(UIView*)piece
{
    // trash can drawn at (0,320,64,64)
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

#pragma mark Remove Piece Functions
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
