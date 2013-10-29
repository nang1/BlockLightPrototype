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

-(id)init{
    self = [super init];
    
    if(self == nil)
        return nil;
    
    _frames = [[NSMutableArray alloc] init];
    _curFrame = 0;
    
    return self;
}

// JNN: added, gets current frame
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
