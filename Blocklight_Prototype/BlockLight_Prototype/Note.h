//
//  Note.h
//  Prototype
//
//  A model that holds information about a Note object.
// 
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Position.h"

@interface Note : UIPanGestureRecognizer <NSCopying>{
    CGAffineTransform _scaleRotationMatrix; // Defines scale(size) and rotation of note.
    NSString* _noteStr;
    Position* _notePosition;
}

@property CGAffineTransform scaleRotationMatrix;
@property (strong) NSString* noteStr;
@property (strong) Position* notePosition;

@end
