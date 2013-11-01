//
//  Note.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "Note.h"

@implementation Note

@synthesize scaleRotationMatrix = _scaleRotationMatrix;
@synthesize noteStr = _noteStr;
@synthesize notePosition = _notePosition;

-(id)init{
    self = [super init];
    
    if(self ==nil)
        return nil;
    
    _scaleRotationMatrix = CGAffineTransformIdentity;
    _notePosition = [[Position alloc] init];
    
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
	id copy = [[[self class] alloc] init];
	if (copy) {
		[copy setNotePosition:[self.notePosition copyWithZone:zone]];
		[copy setNoteStr:[NSMutableString stringWithString:self.noteStr]];
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
