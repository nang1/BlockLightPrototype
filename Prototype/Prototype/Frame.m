//
//  Frame.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "Frame.h"

@implementation Frame

@synthesize frameIcon = _frameIcon;
@synthesize spikePath = _spikePath;
@synthesize actorsOnStage = _actorsOnStage;
@synthesize actors = _actors;
@synthesize props = _props;
@synthesize notes = _notes;
@synthesize notesPresent = _notesPresent;

-(id)init{
    self = [super init];
    
    if (self == nil)
        return nil;
    
    _actorsOnStage = [[NSMutableArray alloc] initWithCapacity:15];
	_actors = [[NSMutableArray alloc] initWithCapacity:15];
    _props = [[NSMutableArray alloc] init];
    _notes = [[NSMutableArray alloc] init];
    _notesPresent = FALSE;
    
    return self;
}

/* Save feature
 - (void)encodeWithCoder:(NSCoder *)encoder{
 [encoder encodeObject:_frameIcon forKey:@"frameIcon"];
 [encoder encodeObject:_spikePath forKey:@"frameSpikePath"];
 [encoder encodeObject:_actorsOnStage forKey:@"frameActorsOnStage"];
 [encoder encodeObject:_props forKey:@"frameProps"];
 [encoder encodeObject:_notes forKey:@"frameNotes"];
 [encoder encodeBool:_notesPresent forKey:@"frameNotesPresent"];
 }
 
 - (id)initWithCoder:(NSCoder *)decoder{
 if(self = [super init]){
 self.frameIcon = [decoder decodeObjectForKey:@"frameIcon"];
 self.spikePath = [decoder decodeObjectForKey:@"frameSpikePath"];
 self.actorsOnStage = [decoder decodeObjectForKey:@"frameActorsOnStage"];
 self.props = [decoder decodeObjectForKey:@"frameProps"];
 self.notes = [decoder decodeObjectForKey:@"frameNotes"];
 self.notesPresent = [decoder decodeBoolForKey:@"frameNotesPresent"];
 }
 return self;
 }
 */

@end
