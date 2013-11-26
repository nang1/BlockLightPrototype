//
//  SetPiece.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Position.h"

@interface SetPiece : UIPanGestureRecognizer <NSCopying> {
    // set piece attributes
    CGAffineTransform _scaleRotationMatrix;
    UIImage * _icon;
    Position* _piecePosition;
    CGPoint* whatever;
}

@property CGAffineTransform scaleRotationMatrix;
@property (strong) UIImage* icon;
@property (strong) Position* piecePosition;

-(id) initWithImage:(UIImage*)icon;

@end
