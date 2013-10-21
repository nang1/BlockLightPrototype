//
//  UserData.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "UserData.h"

@implementation UserData

@synthesize groups = _groups;
@synthesize uniqueGroupID = _uniqueGroupID;
@synthesize uniquePerformerID = _uniquePerformerID;

-(id) init{
    self = [super init];
    
    if(self == nil)
        return nil;
    
    _uniquePerformerID = [NSNumber numberWithInt:0];
    _uniqueGroupID = [NSNumber numberWithInt:0];
    _groups = [[NSMutableArray alloc] initWithCapacity:5];
    
    return self;
}

// increments uniqueGroupID so we're ready to give an id to the new group
// this function is called after creating a new group
-(NSNumber*)nextUniqueGroupID{
    NSNumber* next = [NSNumber numberWithInt:_uniqueGroupID.intValue +1];
    _uniqueGroupID = next;
    return  next;
}

// increments uniquePerformerId so we're ready to give an id to the new peformer
// this function is called after creating a new performer
-(NSNumber*)nextUniquePerformerID{
    NSNumber* next = [NSNumber numberWithInt:_uniquePerformerID.intValue +1];
    _uniquePerformerID = next;
    return  next;
}

/* Save feature
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_groups forKey:@"groups"];
    [encoder encodeObject:_uniqueGroupID forKey:@"groupID"];
    [encoder encodeObject:_uniquePerformerID forKey:@"performerID"];
}

- (id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        self.groups = [decoder decodeObjectForKey:@"groups"];
        self.uniqueGroupID = [decoder decodeObjectForKey:@"groupID"];
        self.uniquePerformerID = [decoder decodeObjectForKey:@"performerID"];
    }
    return self;
}
*/
@end
