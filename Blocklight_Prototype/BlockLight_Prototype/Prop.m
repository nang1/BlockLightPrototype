//
//  Prop.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "Prop.h"

@implementation Prop

@synthesize propID = _propID;
@synthesize propPosition = _propPosition;

-(id)init{
    self = [super init];
    
    if(self == nil)
        return  nil;
    
    _propPosition = [[Position alloc] init];
    
    return self;
}

/* Save feature
 - (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_propID forKey:@"propID"];
    [encoder encodeObject:_propPosition forKey:@"propPosition"];
 }
 
 - (id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        self.propID = [decoder decodeObjectForKey:@"propID"];
        self.propPosition = [decoder decodeObjectForKey:@"propPosition"];
    }
    return self;
 }
 */
@end
