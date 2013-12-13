//
//  Group.h
//  Prototype
//
//  A model to holding information about a theater group.
//  
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject {
    NSString* _name;
    NSMutableArray* _performers; // All the performers in this group
    NSMutableArray* _productions; // All the productions created by/for this group
    NSNumber* _uniqueID;
}

@property (strong) NSString* name;
@property (strong) NSNumber* uniqueID;
@property (strong) NSMutableArray* performers;
@property (strong) NSMutableArray* productions;

@end
