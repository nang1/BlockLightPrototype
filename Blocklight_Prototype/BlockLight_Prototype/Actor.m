//
//  Actor.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "Actor.h"

@implementation Actor

//@synthesize actorID = _actorID;
@synthesize actorName = _actorName;
@synthesize actorPosition = _actorPosition;
@synthesize actorIcon = _actorIcon;

-(id)init{
    self = [super init];
    
    if(self == nil)
        return  nil;
    
    _actorPosition = [[Position alloc] init];
    
    _actorIcon = [UIImage imageNamed:@"actor"];
    
    return self;
}

/* Save feature
 - (void)encodeWithCoder:(NSCoder *)encoder{
 [encoder encodeObject:_actorID forKey:@"actorID"];
 [encoder encodeObject:_actorPosition forKey:@"actorPosition"];
 }
 
 - (id)initWithCoder:(NSCoder *)decoder{
 if(self = [super init]){
 self.actorID = [decoder decodeObjectForKey:@"actorID"];
 self.actorPosition = [decoder decodeObjectForKey:@"actorPosition"];
 }
 return self;
 }
 */

@end
