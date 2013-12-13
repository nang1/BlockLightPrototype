//
//  Position.m
//  Prototype
//
//  A model that holds the x and y position of an object.
// 
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "Position.h"

@implementation Position

@synthesize xCoordinate = _xCoordinate;
@synthesize yCoordinate = _yCoordinate;

/*************************************************************
 * @function: init
 * @discussion: initializes a Position object
 * @return: id to model instance
 ************************************************************/
-(id)init{
    self = [super self];
    
    if(self == nil)
        return nil;
    
    self.xCoordinate = 100;
    self.yCoordinate = 100;
    
    return self;
}

// not sure if this is correct
/*************************************************************
 * @function: updateX() updateY
 * @discussion: changes the x and y coordinate. Not sure if this
 *              is correct.
 * @param: NSInteger x - new x coordinate
 *         NSInteger y - new y coordinate
 * @return: id to model instance
 ************************************************************/
-(void) updateX:(NSInteger)x Y:(NSInteger)y{
    self.xCoordinate = x;
    self.yCoordinate = y;
}

/*************************************************************
  * @function: copyWithZone
  * @discussion: creates a copy of this model instance
  * @param: NSZone* zone
  * @return: id to new model instance copy
  ************************************************************/
-(id)copyWithZone:(NSZone *)zone
{
	id copy = [[[self class]alloc]init];
	if (copy){
		[copy setXCoordinate:self.xCoordinate];
		[copy setYCoordinate:self.yCoordinate];
	}
	return copy;
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
