//
//  Group.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject {
    NSString* _name;
    NSMutableArray* _performers;
    NSMutableArray* _productions;
    NSNumber* _uniqueID;
}

@property (strong) NSString* name;
@property (strong) NSNumber* uniqueID;
@property (strong) NSMutableArray* performers;
@property (strong) NSMutableArray* productions;

@end
