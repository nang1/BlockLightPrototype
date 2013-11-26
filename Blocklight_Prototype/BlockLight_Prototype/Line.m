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

-(id)copyWithZone:(NSZone *)zone
{
	id copy = [[[self class]alloc]init];
	if (copy)
    {
        // TODO: copy properties
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
