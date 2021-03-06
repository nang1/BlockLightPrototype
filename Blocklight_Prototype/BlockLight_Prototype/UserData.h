//
//  UserData.h
//  Prototype
//
//  A model that holds all the information about a user's account.
// 
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject {
    NSMutableArray* _groups;
    NSNumber* _uniqueGroupID; // holds id for next new group created
    NSNumber* _uniquePerformerID; // holds id for next new performer created
}

@property (strong) NSMutableArray* groups;
@property (strong) NSNumber* uniqueGroupID;
@property (strong) NSNumber* uniquePerformerID;

-(NSNumber*)nextUniquePerformerID;
-(NSNumber*)nextUniqueGroupID;

@end
