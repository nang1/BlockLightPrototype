//
//  Production.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Scene.h"
#import "Stage.h"

@interface Production : NSObject {
    NSString* _name;
    Stage* _stage;
    NSMutableArray* _scenes; //To find # of objects in array, can use [_scenes count]
    NSInteger  _curScene; // indicates current scene user is looking at
    NSString* _date;
    NSString* _location;
    NSString* _stageManager;
    //NSMutableDictionary* _layouts; //** not implemented
}

@property (strong) NSString* name;
@property (strong) Stage* stage;
@property (strong) NSMutableArray* scenes;
@property  NSInteger curScene;
@property (strong) NSString* date;
@property (strong) NSString* location;
@property (strong) NSString* stageManager;
// @property (strong) NSMutableDictionary* layouts;

-(void)addScene;

@end
