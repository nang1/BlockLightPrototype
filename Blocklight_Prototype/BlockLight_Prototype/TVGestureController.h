//
//  TVGestureController.h
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

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "Production.h"
#import "QuickStageView.h"
#import "Frame.h"
#import "Note.h"
#import "SetPiece.h"
#import "Actor.h"
#import "Undo_Redo.h"

@interface TVGestureController : UIViewController<UIGestureRecognizerDelegate, UIAlertViewDelegate>
{
    Frame* _frame;
    QuickStageView* _quickStageView;
}

@property (strong) Frame* frame;
@property (strong) QuickStageView* quickStageView;

-(id) initWithFrame2:(Frame*)frame withStageView:(QuickStageView*)stageView;
-(void) changeFrame:(Frame*)frame;

-(void)addGestureRecognizersToView:(UIView*)view;

//-(void) adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
-(void)pinchGesture:(UIPinchGestureRecognizer*) gesture;
-(void)rotateGesture:(UIRotationGestureRecognizer*)gesture;
-(void)pressHoldGesture:(UILongPressGestureRecognizer*)gesture;
-(void) panGestureMoveAround:(UIPanGestureRecognizer*) gesture;

//-(NSString*)identifyPiece:(UIView*)view;

-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

-(BOOL) isOnTrashCan:(UIView*)piece;
-(void) removeNoteAtIndex:(int)i;
-(void) removeActorAtIndex:(int)i;
-(void) removeSetPieceAtIndex:(int)i;


@end
