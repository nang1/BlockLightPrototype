//
//  Position.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "Position.h"

@implementation Position

@synthesize xCoordinate = _xCoordinate;
@synthesize yCoordinate = _yCoordinate;

-(id)init{
    self = [super self];
    
    if(self == nil)
        return nil;
    
    self.xCoordinate = 0;
    self.yCoordinate = 0;
    
    return self;
}

// not sure if this is correct
-(void) updateX:(NSInteger)x Y:(NSInteger)y{
    self.xCoordinate = x;
    self.yCoordinate = y;
}

/* Save feature
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_xCoordinate forKey:@"PositionXCoor"];
    [encoder encodeObject:_yCoordinate forKey:@"PositionYCoor"];
}

- (id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        self.xCoordinate = [decoder decodeObjectForKey:@"PositionXCoor"];
        self.yCoordinate = [decoder decodeObjectForKey:@"PositionYCoor"];
    }
    return self;
}
*/

@end
