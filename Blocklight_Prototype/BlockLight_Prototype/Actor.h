//
//  Actor.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Position.h"

@interface Actor : NSObject {
    NSNumber* _actorID; // holds ID of performer in this role
    Position* _actorPosition;
}

@property (strong) NSNumber* actorID;
@property (strong) Position* actorPosition;

@end
