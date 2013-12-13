//
//  Group.m
//  Prototype
//
//  A model holding all the information about a theater group.
//
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "Group.h"

@implementation Group

@synthesize name = _name;
@synthesize uniqueID = _uniqueID;
@synthesize performers = _performers;
@synthesize productions = _productions;

/*************************************************************
 * @function: init
 * @discussion: initializes a Group object
 * @return: id to model instance
 ************************************************************/
-(id)init{
    self =[super init];
    
    if(self == nil)
        return nil;
    
    _performers = [[NSMutableArray alloc] initWithCapacity:15];
    _productions = [[NSMutableArray alloc] initWithCapacity:5];
    
    return self;
}

/* Save feature
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_name forKey:@"groupName"];
    [encoder encodeObject:_uniqueID forKey:@"groupID"];
    [encoder encodeObject:_performers forKey:@"groupPerformers"];
    [encoder encodeObject:_productions forKey:@"groupProductions"];
}

- (id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        self.name = [decoder decodeObjectForKey:@"groupName"];
        self.uniqueID = [decoder decodeObjectForKey:@"groupID"];
        self.performers = [decoder decodeObjectForKey:@"groupPerformers"];
        self.productions = [decoder decodeObjectForKey:@"groupProductions"];
    }
    return self;
}
*/
@end
