//
//  Frame.m
//  Prototype
//
//  A model that stores all the items that have been set to the stage
//  for a particular frame.
//
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "Frame.h"

@implementation Frame

@synthesize frameIcon = _frameIcon;
@synthesize spikePath = _spikePath;
@synthesize actorsOnStage = _actorsOnStage;
@synthesize props = _props;
@synthesize notes = _notes;
@synthesize notesPresent = _notesPresent;
@synthesize undoArray = _undoArray;
@synthesize redoArray = _redoArray;

/*************************************************************
 * @function: init
 * @discussion: initializes a Frame object
 * @return: id to model instance
 ************************************************************/
-(id)init{
    self = [super init];
    
    if (self == nil)
        return nil;
    
    _actorsOnStage = [[NSMutableArray alloc] initWithCapacity:15];
    _props = [[NSMutableArray alloc] init];
    _notes = [[NSMutableArray alloc] init];
    _notesPresent = FALSE;
    _undoArray = [[NSMutableArray alloc] init];
	_redoArray = [[NSMutableArray alloc] init];
    
    return self;
}

/*************************************************************
 * @function: copyWithZone
 * @discussion: creates a copy of this model instance
 * @param: NSZone* zone
 * @return: id to new model instance copy
 ************************************************************/
-(id)copyWithZone:(NSZone *)zone
{
	id copy = [[[self class] alloc] init];
	if(copy){
		[copy setProps:[self.props copyWithZone:zone]];
		[copy setActorsOnStage:[self.actorsOnStage copyWithZone:zone]];
		[copy setNotes:[self.notes copyWithZone:zone]];
	}
	return copy;
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
