//
//  NoteView.h
//  Prototype
//
//  Popover view to let the user add a note.
// 
//  Created by Nicole Ang on 9/9/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TVPopoverViewController.h"
#import "Frame.h"
#import "Note.h"

@class NoteView;
@class TVPopoverViewController;

@interface NoteView : UIView
{
    UITextView* _noteTextBox;
    Frame* _frame; // where all the notes are stored
    TVPopoverViewController* _popoverCtrl; // to dismiss it after adding a note
}

@property (nonatomic, strong) UITextView* noteTextBox;
//@property (strong) Frame* frame; // keeping this commented b/c of an error
@property (strong) TVPopoverViewController* popoverCtrl;

-(id)initWithFrame:(CGRect)frame withProductionFrame: (Frame*)currentFrame withViewController:(TVPopoverViewController *)viewController;

-(void)addNewNote;

@end