//
//  Production.m
//  Prototype
//
//  A model that holds information about a theater production.
//
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "Production.h"

@implementation Production

@synthesize name = _name;
@synthesize stage = _stage;
@synthesize scenes = _scenes;
@synthesize curScene = _curScene;
@synthesize date = _date;
@synthesize location = _location;
@synthesize stageManager = _stageManager;
// @synthesize layouts = _layouts;

/*************************************************
 * @function: init
 * @discussion: initializes a Production object with a stage and a scene
 * @return: id to model instance
 *************************************************/
-(id) init{
    self = [super init];
    
    if(self == nil)
        return nil;
    
    self.scenes = [[NSMutableArray alloc] initWithCapacity:5];
    self.stage = [[Stage alloc] init];
    // _layouts = [[NSMutableDictionary alloc] init];
    _curScene = 0;
    
    return self;
}

/*************************************************
 * @function: addScene
 * @discussion: Adds a new scene to the production
 * @return: void
 * @see: Scene.h
 *************************************************/
-(void)addScene{
    Scene* newScene = [[Scene alloc] init];
    [_scenes addObject: newScene];
    
    // move user to newly created scene
    // thus change current scene indicator
    _curScene = [_scenes count];
}

/*************************************************
 * @function: getCurScene
 * @discussion: wrapper to get the current scene of the production
 * @return: Scene*
 * @see: Scene.h
 *************************************************/
-(Scene*)getCurScene
{
    return [_scenes objectAtIndex: _curScene];
}

/*************************************************
 * @function: getCurScene
 * @discussion: wrapper to get the current frame from the current scene
 * @return: Frame*
 * @see: Frame.h
 *************************************************/
-(Frame*)getCurFrameFromScene
{
    return [[self getCurScene] getCurFrame];
}

/* Save feature
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_name forKey:@"productionName"];
    [encoder encodeObject:_stage forKey:@"productionStage"];
    [encoder encodeObject:_scenes forKey:@"productionScenes"];
    [encoder encodeInt:_curScene forKey:@"productionCurScene"];
    [encoder encodeObject:_date forKey:@"productionDate"];
    [encoder encodeObject:_location forKey:@"productionLocation"];
    [encoder encodeObject:_stageManager forKey:@"productionStageManager"];
    // [encoder encodeObject:_layouts forKey:@"productionLayouts"];
    
}

- (id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        self.name = [decoder decodeObjectForKey:@"productionName"];
        self.stage = [decoder decodeObjectForKey:@"productionStage"];
        self.scenes = [decoder decodeObjectForKey:@"productionScenes"];
        self.curScene = [decoder decodeIntForKey:@"productionCurScene"];
        self.date = [decoder decodeObjectForKey:@"productionDate"];
        self.location = [decoder decodeObjectForKey:@"productionLocation"];
        self.stageManager = [decoder decodeObjectForKey:@"productionStageManager"];
        // self.layouts = [decoder decodeObjectForKey:@"productionLayouts"];
    }
    return self;
}
*/
@end
