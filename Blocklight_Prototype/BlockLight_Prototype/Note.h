//
//  Note.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Position.h"

@interface Note : UIPanGestureRecognizer <NSCopying>{
    CGAffineTransform _scaleRotationMatrix;
    NSString* _noteStr;
    Position* _notePosition;
}

@property CGAffineTransform scaleRotationMatrix;
@property (strong) NSString* noteStr;
@property (strong) Position* notePosition;

@end
