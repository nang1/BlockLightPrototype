//
//  Performer.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Performer : NSObject {
    // Attributes of a performer
    NSString* _name;
    NSString* _phoneNumber;
    NSString* _email;
    
    NSString* _voice;
    NSString* _gender;
    /* These are typedefs located in Defaults.h in the old Blocklight
     *     not sure why they were kept as strings
     * Voice _voice;
     * Gender _gender;
    */
    NSString* _height;
    NSNumber* _uniqueID;
    
    // Display data
    UIImage* _icon;
}

@property (strong) NSString* name;
@property (strong) NSString* phoneNumber;
@property (strong) NSString* email;
@property (strong) NSString* voice;
@property (strong) NSString* gender;
@property (strong) NSString* height;
@property (strong) NSNumber* uniqueID;
@property (nonatomic, strong) UIImage* icon;

@end
