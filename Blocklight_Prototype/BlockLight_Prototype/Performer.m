//
//  Performer.m
//  Prototype
//
//  A model that holds information about a performer.
// 
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "Performer.h"

@implementation Performer

@synthesize name = _name;
@synthesize phoneNumber = _phoneNumber;
@synthesize email = _email;
@synthesize voice = _voice;
@synthesize gender = _gender;
@synthesize height = _height;
@synthesize uniqueID = _uniqueID;
@synthesize icon = _icon;

/*************************************************************
 * @function: init
 * @discussion: initializes a Performer object
 * @return: id to model instance
 ************************************************************/
-(id) init{
    self = [super init];
    if(self == nil)
        return nil;
    
    // will need to implement a way to get different images for each performer
    _icon = [UIImage imageNamed:@"performer.png"];
    
    return self;
}

/* Save feature
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_name forKey:@"performerName"];
    [encoder encodeObject:_phoneNumber forKey:@"performerPhone"];
    [encoder encodeObject:_email forKey:@"performerEmail"];
    [encoder encodeObject:_voice forKey:@"performerVoice"];
    [encoder encodeObject:_gender forKey:@"performerGender"];
    [encoder encodeObject:_height forKey:@"performerHeight"];
    [encoder encodeObject:_uniqueID forKey:@"performerID"];
    [encoder encodeObject:UIImagePNGRepresentation(_icon) forKey:@"performerIcon"];
}

- (id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        self.name = [decoder decodeObjectForKey:@"performerName"];
        self.phoneNumber = [decoder decodeObjectForKey:@"performerPhone"];
        self.email = [decoder decodeObjectForKey:@"performerEmail"];
        self.voice = [decoder decodeObjectForKey:@"performerVoice"];
        self.gender = [decoder decodeObjectForKey:@"performerGender"];
        self.height = [decoder decodeObjectForKey:@"performerHeight"];
        self.uniqueID = [decoder decodeObjectForKey:@"performerID"];
        self.icon = [UIImage imageWithData:[decoder decodeObjectForKey:@"performerIcon"]];
    }
    return self;
}
*/
@end
