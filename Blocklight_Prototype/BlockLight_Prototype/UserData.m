//
//  UserData.m
//  Prototype
//
//  A model that holds information about a user's account.
//
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "UserData.h"

@implementation UserData

@synthesize groups = _groups;
@synthesize uniqueGroupID = _uniqueGroupID;
@synthesize uniquePerformerID = _uniquePerformerID;

/*************************************************************
 * @function: init
 * @discussion: initializes a userData object
 * @return: id to model instance
 ************************************************************/
-(id) init{
    self = [super init];
    
    if(self == nil)
        return nil;
    
    _uniquePerformerID = [NSNumber numberWithInt:0];
    _uniqueGroupID = [NSNumber numberWithInt:0];
    _groups = [[NSMutableArray alloc] initWithCapacity:5];
    
    return self;
}

/*************************************************************
 * @function: nextUniqueGroupID
 * @discussion: Increments uniqueGroupID, so we're ready to give an id
 *              to the next new group that is created. This method
 *              is called after creating a new group.
 * @return: id to model instance
 ************************************************************/
-(NSNumber*)nextUniqueGroupID{
    NSNumber* next = [NSNumber numberWithInt:_uniqueGroupID.intValue +1];
    _uniqueGroupID = next;
    return  next;
}

/*************************************************************
 * @function: nextUniquePerformerID
 * @discussion: Increments uniquePerformerId, so we're ready to give
 *              an id to the next new performer. This method is
 *              called after creating a new performer.
 * @return: id to model instance
 ************************************************************/
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
