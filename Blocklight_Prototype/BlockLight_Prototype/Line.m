//
//  Line.m
//  Blocklight_Prototype
//
//  A generic model containing the start and end points of a line.
//  Used for creating spike tape and traffic patterns.
//
//  Created by Jordan Nguyen on 11/22/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import "Line.h"

@implementation Line

@synthesize start = _start;
@synthesize end = _end;

/*************************************************
 * @function: init
 * @discussion: initializes a Line object with a start and end point
 * @return: id to model instance
 *************************************************/
-(id) init{
    self = [super init];
    
    if(self == nil)
        return nil;
    
    //_start = CGPointZero;
    //_end = CGPointZero;
    _start = [[Position alloc] init];
    _end = [[Position alloc] init];
    
    return self;
}

/*************************************************
 * @function: copyWithZone
 * @discussion: creates a copy of this model instance
 * @param: NSZone* zone
 * @return: id to new model instance copy
 *************************************************/
-(id)copyWithZone:(NSZone *)zone
{
	id copy = [[[self class]alloc]init];
	if (copy)
    {
        [copy setStart:[self.start copyWithZone:zone]];
        [copy setEnd:[self.end copyWithZone:zone]];
	}
	return copy;
}

/* TODO: Save feature
 - (void)encodeWithCoder:(NSCoder *)encoder{
 }
 
 - (id)initWithCoder:(NSCoder *)decoder{
 }
 */
@end
