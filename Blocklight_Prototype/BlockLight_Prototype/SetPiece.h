//
//  SetPiece.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetPiece : NSObject {
    // set piece attributes
    NSString* _name;
    NSNumber* _uniqueID;
    UIImage * _icon;
}

@property (strong) NSString* name;
@property (strong) NSNumber* uniqueID;
@property (strong) UIImage * icon;

@end
