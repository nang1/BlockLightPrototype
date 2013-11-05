//
//  ActorView.h
//  Blocklight_Prototype
//
//  Created by nang1 on 10/16/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVPopoverViewController.h"
#import "Frame.h"
#import "Actor.h"

@class TVPopoverViewController;

@interface ActorView : UIView<UITextFieldDelegate>
{
    UITextField* _nameTextBox;
    Frame* _frame; // where all the actors are stored
    TVPopoverViewController* _popoverCtrl; // to dismiss it after adding an actor
}

@property (nonatomic, strong) UITextField* nameTextBox;
@property (strong) TVPopoverViewController* popoverCtrl;

-(id)initWithFrame:(CGRect)frame withProductionFrame: (Frame*)currentFrame withViewController:(TVPopoverViewController *)viewController;
-(void)addActor;

@end
