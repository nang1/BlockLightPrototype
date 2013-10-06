//
//  Prop.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Position.h"

@interface Prop : NSObject {
    NSNumber* _propID; // holds ID of set piece this is
    Position* _propPosition;
}

@property (strong) NSNumber* propID;
@property (strong) Position* propPosition;

@end
