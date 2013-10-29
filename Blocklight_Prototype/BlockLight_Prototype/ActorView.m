//
//  ActorView.m
//  Blocklight_Prototype
//
//  Created by nang1 on 10/16/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import "ActorView.h"

@implementation ActorView

@synthesize nameTextBox = _nameTextBox;
@synthesize popoverCtrl = _popoverCtrl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

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
    //_nameTextBox = [[UITextView alloc] initWithFrame:CGRectMake(10, 25, 300, 200)];
    _nameTextBox = [[UITextField alloc] initWithFrame:CGRectMake(10, 40, 300, 50)];
    _nameTextBox.backgroundColor = [UIColor whiteColor];
    [_nameTextBox setFont:[UIFont systemFontOfSize:15]];
    //[_nameTextBox.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    //[_nameTextBox.layer setBorderWidth:2.0];
    _nameTextBox.layer.cornerRadius = 5;
    _nameTextBox.clipsToBounds = YES;
    
    //* // JNN: extra stuff for text field that's not really needed
    _nameTextBox.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextBox.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nameTextBox.adjustsFontSizeToFitWidth = YES;
    _nameTextBox.keyboardType = UIKeyboardTypeDefault;
    _nameTextBox.returnKeyType = UIReturnKeyDone;
    _nameTextBox.autocorrectionType = UITextAutocorrectionTypeNo;
    _nameTextBox.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _nameTextBox.placeholder = @"Insert Name";
    [_nameTextBox setDelegate:self];
    //*/
    
    // label
    UILabel* textLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 10, 100, 15)];
    textLabel.text = @"Enter Name";
    textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    textLabel.backgroundColor = [UIColor clearColor];
    
    // button to add note
    UIButton *add = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //add.frame = CGRectMake(10,240,300,50);
    add.frame = CGRectMake(10,100,300,50);
    add.titleLabel.textColor = [UIColor blackColor];
    [add setTitle:@"Add Performer" forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addActor) forControlEvents: UIControlEventTouchUpInside];
    
    // set background, add textbox and button
    self.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:textLabel];
    [self addSubview:_nameTextBox];
    [self addSubview:add];
    
    return self;
}

// User clicks "Add Performer" button
// Save the name entered in the textbox
- (void)addActor {
    if([_nameTextBox.text length] == 0)
    {
        return; // nothing in text box
    }
    
    // make a new note as a Note object and add to current frame
    Actor* newActor = [[Actor alloc] init];
    newActor.actorName = [[UILabel alloc] initWithFrame:CGRectMake(-10, 70, 95, 20)];
    newActor.actorName.text = _nameTextBox.text;
    newActor.actorName.backgroundColor = [UIColor clearColor];
    [_frame.actorsOnStage addObject:newActor];
    
    // just to check if note has been added to current frame
    // NSLog(@"Added new note, Number of notes: %d\n",[tempFrame.notes count]);
    
    [_popoverCtrl dismissPopoverView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark UITextFieldDelegate Code

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self addActor];
    // it should NOT enter a new line/return carriage/whatever "return" key returns
    return NO;
}

@end
