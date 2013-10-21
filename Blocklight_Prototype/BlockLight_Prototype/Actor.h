//
//  Actor.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Position.h"

@interface Actor : UIPanGestureRecognizer {
    //NSNumber* _actorID; // holds ID of performer in this role
    UILabel* _actorName;
    Position* _actorPosition;
    UIImage* _actorIcon;
}

//@property (strong) NSNumber* actorID;
@property (strong) UILabel* actorName;
@property (strong) Position* actorPosition;
@property (strong) UIImage* actorIcon;

@end
