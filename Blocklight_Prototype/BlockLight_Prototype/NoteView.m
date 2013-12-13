//
//  NoteView.m
//  Prototype
//
//  Popover view that allows the user to add a note.
//
//  Created by Nicole Ang on 9/9/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "NoteView.h"

@implementation NoteView

@synthesize noteTextBox = _noteTextBox;
//@synthesize frame = _frame; // JNN: ???
@synthesize popoverCtrl = _popoverCtrl;

/*************************************************
 * @function: initWithFrame
 * @discussion: Auto-generated code to initialize view
 * @param: CGRect frame
 * @return: id to this instance
 *************************************************/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

/*************************************************
 * @function: initWithFrame __ withProductionFrame __ withViewController
 * @discussion: initializes the view with a frame and popover view controller
 * @param: CGRect frame
 * @param: Frame* currentFrame
 * @param: TVPopoverViewController* viewController
 * @return: id to this instance
 *************************************************/
-(id)initWithFrame:(CGRect)frame withProductionFrame: (Frame*)currentFrame withViewController:(TVPopoverViewController *)viewController
{
    self = [super initWithFrame:frame];
    if(self == nil)
    {
        return nil;
    }
    
    // else continue initialization
    _frame = currentFrame;
    _popoverCtrl = viewController;
    
    // text view field to enter text for note
    _noteTextBox = [[UITextView alloc] initWithFrame:CGRectMake(10, 25, 300, 200)];
    _noteTextBox.backgroundColor = [UIColor whiteColor];
    [_noteTextBox setFont:[UIFont systemFontOfSize:15]];
    [_noteTextBox.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [_noteTextBox.layer setBorderWidth:2.0];
    _noteTextBox.layer.cornerRadius = 5;
    _noteTextBox.clipsToBounds = YES;
    [_noteTextBox becomeFirstResponder];
    
    // label
    UILabel* textLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 10, 100, 15)];
    textLabel.text = @"Enter Note";
    textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    textLabel.backgroundColor = [UIColor clearColor];
    
    // button to add note
    UIButton *add = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    add.frame = CGRectMake(10,240,300,50);
    add.titleLabel.textColor = [UIColor blackColor];
    [add setTitle:@"Add Note" forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addNewNote) forControlEvents: UIControlEventTouchUpInside];
    
    // set background, add textbox and button
    self.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:textLabel];
    [self addSubview:_noteTextBox];
    [self addSubview:add];

    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

/*************************************************
 * @function: addNewNote
 * @discussion: User clicks "Add Note" button
 *     Save text that was entered in the textbox in a new Note
 *************************************************/
-(void)addNewNote
{
    if([_noteTextBox.text length] == 0)
    {
        return; // nothing in text box
    }
    
    // make a new note as a Note object and add to current frame
    Note* newNote = [[Note alloc] init];
    newNote.noteStr = _noteTextBox.text;
    //newNote.notePosition = [[Position alloc] init];
    [_frame.notes addObject:newNote];
    
    if(_popoverCtrl.quickView.hiddenNotes)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Notes Hidden" message:@"Your current settings have Notes hidden. To change this, go to View." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

    
    // just to check if note has been added to current frame
    // NSLog(@"Added new note, Number of notes: %d\n",[tempFrame.notes count]);
    
    // Close the popover and return to stage editor
    [_popoverCtrl dismissPopoverView];
}

@end
