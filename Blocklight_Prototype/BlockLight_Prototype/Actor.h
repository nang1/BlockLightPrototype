//
//  Actor.h
//  Prototype
//
//  A model that stores the name, postion, and image of an actor.
//
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Position.h"

@interface Actor : UIPanGestureRecognizer <NSCopying>{
    //NSNumber* _actorID; // holds ID of performer in this role
                        //planned to use when having production groups
    UILabel* _actorName;
    Position* _actorPosition;
    CGAffineTransform _scaleRotationMatrix; // Defines scale and rotation of actor
    UIImage* _actorIcon;
}

//@property (strong) NSNumber* actorID;
@property CGAffineTransform scaleRotationMatrix;
@property (strong) UILabel* actorName;
@property (strong) Position* actorPosition;
@property (strong) UIImage* actorIcon;

@end
