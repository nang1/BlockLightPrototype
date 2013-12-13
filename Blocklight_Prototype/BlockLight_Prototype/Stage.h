//
//  Stage.h
//  Prototype
//
//  A model that holds information about a stage.
// 
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Defaults.h"

@interface Stage : NSObject {
    //Stage Attributes
    NSString* _name;
    NSNumber* _width;
    NSNumber* _height;
    NSNumber* _gridOpacity;
    NSNumber* _gridSpacing;
    
    // This is a typedef in Defaults.h in the old BlockLight
    MeasurementType _measurementType; // Feet or Meters

    // whether or not grid/ruler shown on stage
	BOOL _grid;
    BOOL _ruler;
    BOOL _apron;
    BOOL _horizontalGrid;
	BOOL _verticalGrid;
}

@property (strong) NSString* name;
@property (strong) NSNumber* width;
@property (strong) NSNumber* height;
@property (strong) NSNumber* gridOpacity;
@property (strong) NSNumber* gridSpacing;
@property (nonatomic) MeasurementType measurementType;
@property BOOL grid;
@property BOOL ruler;
@property BOOL apron;
@property BOOL horizontalGrid;
@property BOOL verticalGrid;

@end
