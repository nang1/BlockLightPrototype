//
//  Actor.m
//  Prototype
//
//  A model that stores the name, postion, and image of an actor.
// 
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "Actor.h"

@implementation Actor

//@synthesize actorID = _actorID;
@synthesize scaleRotationMatrix = _scaleRotationMatrix;
@synthesize actorName = _actorName;
@synthesize actorPosition = _actorPosition;
@synthesize actorIcon = _actorIcon;

/*************************************************************
 * @function: init
 * @discussion: initializes an Actor object
 * @return: id to model instance
 ************************************************************/
-(id)init{
    self = [super init];
    
    if(self == nil)
        return  nil;
    
    _scaleRotationMatrix = CGAffineTransformIdentity;
    
    _actorPosition = [[Position alloc] init];
    
    _actorIcon = [UIImage imageNamed:@"actor"];
    
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
	id copy = [[[self class]alloc]init];
	if (copy){
		[copy setActorName:[self deepLabelCopy:self.actorName] ];
		[copy setActorPosition:[self.actorPosition copyWithZone:zone]];
		[copy setActorIcon:[UIImage imageWithCGImage:self.actorIcon.CGImage]];
        [copy setScaleRotationMatrix:_scaleRotationMatrix];
	}
	return copy;
}

- (UILabel*) deepLabelCopy:(UILabel*) label {
	UILabel *dup = [[UILabel alloc]initWithFrame:label.frame];
	dup.text = label.text;
	return dup;
}

/* Used for Save feature - hasn't been adjusted for new architecture
 // Save the object
 - (void)encodeWithCoder:(NSCoder *)encoder{
 [encoder encodeObject:_actorID forKey:@"actorID"];
 [encoder encodeObject:_actorPosition forKey:@"actorPosition"];
 }
 
 // load the object from wherever it was saved
 - (id)initWithCoder:(NSCoder *)decoder{
 if(self = [super init]){
 	self.actorID = [decoder decodeObjectForKey:@"actorID"];
 	self.actorPosition = [decoder decodeObjectForKey:@"actorPosition"];
 }
 return self;
 }
 */

@end
