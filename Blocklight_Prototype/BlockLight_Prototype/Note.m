//
//  Note.m
//  Prototype
//
//  A model that holds information about a note object.
//
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "Note.h"

@implementation Note

@synthesize scaleRotationMatrix = _scaleRotationMatrix;
@synthesize noteStr = _noteStr;
@synthesize notePosition = _notePosition;

/*************************************************************
 * @function: init
 * @discussion: initializes a Note object
 * @return: id to model instance
 ************************************************************/
-(id)init{
    self = [super init];
    
    if(self ==nil)
        return nil;
    
    _scaleRotationMatrix = CGAffineTransformIdentity;
    _notePosition = [[Position alloc] init];
    
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
	if (copy) {
		[copy setNotePosition:[self.notePosition copyWithZone:zone]];
		[copy setNoteStr:[NSMutableString stringWithString:self.noteStr]];
        [copy setScaleRotationMatrix:_scaleRotationMatrix];
	}
	return copy;
}

/* Save feature
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_noteStr forKey:@"noteStr"];
    [encoder encodeObject:_notePosition forKey:@"notePosition"];
}

- (id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        self.noteStr = [decoder decodeObjectForKey:@"noteStr"];
        self.notePosition = [decoder decodeObjectForKey:@"notePosition"];
    }
    return self;
}
*/
@end
