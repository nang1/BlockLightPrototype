//
//  SetPiece.h
//  Prototype
//
//  A model that holds information about a set piece.
//
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Position.h"

@interface SetPiece : UIPanGestureRecognizer <NSCopying> {
    // set piece attributes
    CGAffineTransform _scaleRotationMatrix; // scale and rotation of set piece
    UIImage * _icon;
    Position* _piecePosition;
}

@property CGAffineTransform scaleRotationMatrix;
@property (strong) UIImage* icon;
@property (strong) Position* piecePosition;

-(id) initWithImage:(UIImage*)icon;

@end
