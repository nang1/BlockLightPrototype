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
    UIImage * _icon;
    Position* _piecePosition;
}

@property (strong) UIImage* icon;
@property (strong) Position* piecePosition;

- (id)initWithImage:(NSString*)type;

@end
