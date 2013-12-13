//
//  Undo_Redo.h
//  Blocklight_Prototype
//
//  A model that information about an action a user performed on some item.
//  The changeType variable indicates which user action it is.
// 
//  Created by Nicole Ang on 11/15/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Undo_Redo : NSObject <NSCopying> {
    NSObject* _obj; // object that was changed
    int _changeType; // indicates what change occured
    int _index; // index where object is
}

@property (strong) NSObject* obj;
@property int changeType;
@property int index;

@end
