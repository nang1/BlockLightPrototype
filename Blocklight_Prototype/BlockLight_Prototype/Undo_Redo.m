//
//  Undo_Redo.m
//  Blocklight_Prototype
//
//  Created by nang1 on 11/15/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import "Undo_Redo.h"

@implementation Undo_Redo

@synthesize obj = _obj;
@synthesize changeType = _changeType;
@synthesize index = _index;

- (id)init {
    self = [super init];
    
    if (self == nil)
        return nil;
    
    _obj = [[NSObject alloc] init];
    _changeType = 0;
    _index = 0;
    
    return self;
}

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
