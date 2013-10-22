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

-(void)panGestureMoveAround:(UIPanGestureRecognizer*) gesture
{
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if (orientation==UIInterfaceOrientationLandscapeLeft) // rightside up
    {
        NSLog(@"left");
    }
    else if(orientation == UIInterfaceOrientationLandscapeRight) // upside down
    {
        NSLog(@"right");
    }
    
    UIView *piece = [gesture view];
    
    //We pass in the gesture to a method that will help us align our touches so that the pan and pinch will seem to originate between the fingers instead of other points or center point of the UIView
    [self adjustAnchorPointForGestureRecognizer:gesture];
    
    if ([gesture state] == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [gesture translationInView:[piece superview]];
        
        // x should be between 100 and 650
        float newX = MAX([piece center].x + lroundf(translation.x), 100);
        newX = MIN(newX, 650);
        
        // y should be between 100 and 950
        //float newY = MAX([piece center].y + lroundf(translation.y), 100);
        //newY = MIN(newY, 950);
        
        [piece setCenter:CGPointMake(newX, [piece center].y + lroundf(translation.y))];
        [gesture setTranslation:CGPointZero inView:[piece superview]];
        //NSLog(@"Piece center: %d, %d\n",(int)[piece center].x, (int)[piece center].y);
    }
    else if([gesture state] == UIGestureRecognizerStateEnded)
    {
        //Put the code that you may want to execute when the UIView became larger than certain value or just to reset them back to their original transform scale
        
        NSString* pieceType = @""; // used to indicate type of piece to be deleted
        int index = 0; // used to indicate index of object to be deleted in array
        Position* pos;
        
        // A note was moved
        if([piece isMemberOfClass:[UILabel class]])
        {            
            Note* tempNote = [[Note alloc] init];
            pieceType = @"Note";
            
            // find index of piece that was moved
            for(UILabel *lbl in _quickStageView.noteLabels)
            {
                if([lbl isEqual:(UILabel*)piece])
                {
                    tempNote = [_frame.notes objectAtIndex:index];
                    break;
                }
                else
                {
                    index++;
                }
            }
            
            pos = tempNote.notePosition;
        }
        // A set piece was moved
        else if([piece isMemberOfClass:[UIImageView class]]){
            if(piece.tag == 10)
            {
                Actor* tempActor = [[Actor alloc] init];
                pieceType = @"Actor";
                
                //find index of piece that was moved
                for(UIImageView *tempView in _quickStageView.actorArray)
                {
                    if([tempView isEqual:(UIImageView*)piece])
                    {
                        tempActor = [_frame.actorsOnStage objectAtIndex:index];
                        break;
                    }
                    else
                    {
                        index++;
                    }
                }
                
                pos = tempActor.actorPosition;
            }
            else
            {
                SetPiece* tempPiece = [[SetPiece alloc] init];
                pieceType = @"Set Piece";

                //find index of piece that was moved
                for(UIImageView *tempView in _quickStageView.propsArray)
                {
                    if([tempView isEqual:(UIImageView*)piece])
                    {
                        tempPiece = [_frame.props objectAtIndex:index];
                        break;
                    }
                    else
                    {
                        index++;
                    }
                }
                
                pos = tempPiece.piecePosition;
            }
            
        }
        
        if(pos == nil) // should have been set when created
        {
            // update set piece with new position
            pos = [[Position alloc] init];
            pos.xCoordinate = [piece center].x;
            pos.yCoordinate = [piece center].y;
        }
        else if ([self isOnTrashCan:piece]) // user wants to delete icon
        {
            NSString *text = [[NSString alloc] initWithFormat:@"Warning: You are throwing away something. Are you sure you want to continue?"];
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Trash Can" message:text delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            alert.tag = index;
            alert.title  = pieceType;
            [alert show];
        }
        else {
            CGFloat height = [UIScreen mainScreen].currentMode.size.height; // 1024px
            //CGFloat width = [UIScreen mainScreen].currentMode.size.width; // 768px
            
            // 64px because: 20px for the status bar, and 44px for the navigation bar
            [pos updateX:(int)(height - [piece center].y) Y:(int)[piece center].x-64];
            /*
            pos.xCoordinate = [piece center].x;
            pos.yCoordinate = [piece center].y;
            
            NSLog(@"Moved %@\n",tempNote.noteStr);
            NSLog(@"Moved note to: %d, %d\n",tempNote.notePosition.xCoordinate, tempNote.notePosition.yCoordinate);
            //*/
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) // pressed Ok, buttonIndex == 0 if user pressed cancel, do nothing
    {
        //NSLog(@"Throw in trash can");
        if([alertView.title isEqual:@"Note"])
            [self removeNoteAtIndex:alertView.tag];
        else if([alertView.title isEqual:@"Set Piece"])
            [self removeSetPieceAtIndex:alertView.tag];
        else if([alertView.title isEqualToString:@"Actor"])
            [self removeActorAtIndex:alertView.tag];
    }
}

-(BOOL)isOnTrashCan:(UIView*)piece
{
    // trash can created at (0,320,64,64)
    if((384 < [piece center].x) && ([piece center].x < 448)
            &&(960 < [piece center].y) && ([piece center].y < 1024))
    {
        return true;
    }
    else
    {
        return false;
    }
}

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
