//
//  Undo_Redo.m
//  Blocklight_Prototype
//
//  A model that information about an action a user performed on some item.
//  The changeType variable indicates which user action it is.
//
//  Created by nang1 on 11/15/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import "Undo_Redo.h"

@implementation Undo_Redo

@synthesize obj = _obj;
@synthesize changeType = _changeType;
@synthesize index = _index;

/*************************************************************
 * @function: init
 * @discussion: initializes an Undo_Redo object
 * @return: id to model instance
 ************************************************************/
- (id)init {
    self = [super init];
    
    if (self == nil)
        return nil;
    
    _obj = [[NSObject alloc] init];
    _changeType = 0;
    _index = 0;
    
    return self;
}

/*************************************************************
 * @function: copyWithZone
 * @discussion: creates a copy of this model instance
 * @param: NSZone* zone
 * @return: id to new model instance copy
 ************************************************************/
-(id)copyWithZone:(NSZone *)zone{
    id copy = [[[self class] alloc] init];
    if(copy){
        [copy setObj:_obj];
        [copy setChangeType:_changeType];
        [copy setIndex:_index];
    }
    return copy;
}

@end
