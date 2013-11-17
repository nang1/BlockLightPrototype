//
//  Undo_Redo.h
//  Blocklight_Prototype
//
//  Created by nang1 on 11/15/13.
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
