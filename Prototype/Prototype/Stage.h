//
//  Stage.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stage : NSObject {
    //Stage Attributes
    NSString* _name;
    NSNumber* _width;
    NSNumber* _height;
    NSNumber* _gridOpacity;
    NSNumber* _gridSpacing;
    
    NSString* _measurementType;
    /* This is a typedef in Defaults.h in the old BlockLight
     MeasurementType _measurementType;
     */
}

@property (strong) NSString* name;
@property (strong) NSNumber* width;
@property (strong) NSNumber* height;
@property (strong) NSNumber* gridOpacity;
@property (strong) NSNumber* gridSpacing;
@property (strong) NSString* measurementType;
// @property (nonatomic) MeasurementType measurementType;

@end
