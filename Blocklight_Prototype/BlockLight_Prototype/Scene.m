//
//  Scene.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "Scene.h"

@implementation Scene

@synthesize name = _name;
@synthesize frames = _frames;
@synthesize curFrame = _curFrame;

/*************************************************
 * @function: init
 * @discussion: initializes a Scene object with a frame
 * @return: id to model instance
 *************************************************/
-(id)init{
    self = [super init];
    
    if(self == nil)
        return nil;
    
    _frames = [[NSMutableArray alloc] init];
    _curFrame = 0;
    
    return self;
}

#pragma mark - Section Header to Group Like Functions -

/*************************************************
 * @function: getCurFrame
 * @discussion: wrapper to get the current frame of the scene
 * @return: Frame*
 * @see: Frame.h
 *************************************************/
-(Frame*)getCurFrame
{
    return [_frames objectAtIndex:_curFrame];
}

/* Save feature
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_name forKey:@"sceneName"];
    [encoder encodeObject:_frames forKey:@"sceneFrames"];
    [encoder encodeObject:_curFrame forKey:@"sceneCurFrame"];
}

- (id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        self.name = [decoder decodeObjectForKey:@"sceneName"];
        self.frames = [decoder decodeObjectForKey:@"sceneFrames"];
        self.curFrame = [decoder decodeObjectForKey:@"sceneCurFrame"];
    }
    return self;
}
*/
@end
