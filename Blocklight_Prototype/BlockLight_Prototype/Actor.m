//
//  Actor.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "Actor.h"

@implementation Actor

//@synthesize actorID = _actorID;
@synthesize actorName = _actorName;
@synthesize actorPosition = _actorPosition;
@synthesize actorIcon = _actorIcon;

-(id)init{
    self = [super init];
    
    if(self == nil)
        return  nil;
    
    _actorPosition = [[Position alloc] init];
    
    _actorIcon = [UIImage imageNamed:@"actor"];
    
    return self;
}
-(id)copyWithZone:(NSZone *)zone
{
	id copy = [[[self class]alloc]init];
	if (copy){
		[copy setActorName:[self deepLabelCopy:self.actorName] ];
		[copy setActorPosition:[self.actorPosition copyWithZone:zone]];
		[copy setActorIcon:[UIImage imageWithCGImage:self.actorIcon.CGImage]];
	}
	return copy;
}

- (UILabel*) deepLabelCopy:(UILabel*) label {
	UILabel *dup = [[UILabel alloc]initWithFrame:label.frame];
	dup.text = label.text;
	return dup;
}

/* Save feature
 - (void)encodeWithCoder:(NSCoder *)encoder{
 [encoder encodeObject:_actorID forKey:@"actorID"];
 [encoder encodeObject:_actorPosition forKey:@"actorPosition"];
 }
 
 - (id)initWithCoder:(NSCoder *)decoder{
 if(self = [super init]){
 self.actorID = [decoder decodeObjectForKey:@"actorID"];
 self.actorPosition = [decoder decodeObjectForKey:@"actorPosition"];
 }
 return self;
 }
 */

@end
