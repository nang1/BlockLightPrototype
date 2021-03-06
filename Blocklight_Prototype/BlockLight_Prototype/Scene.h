//
//  Scene.h
//  Prototype
//
//  A model that holds information about a scene.
//
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Frame.h"

@interface Scene : NSObject
{
    //scene attributes
    NSString* _name;
    NSMutableArray* _frames;
    // was changed from NSNumber to work with 'objectAtIndex' method
    NSInteger _curFrame; // indicates current frame user is looking at
}

@property (strong) NSString* name;
@property (strong) NSMutableArray* frames;
@property NSInteger curFrame;

-(Frame*)getCurFrame;

@end
