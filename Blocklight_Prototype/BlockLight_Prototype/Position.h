//
//  Position.h
//  Prototype
//
//  A model that holds the x and y position of an object.
//  Planned to use CGPoint to hold the coordinates, but Xcode
//  was giving some bizarre errors, so we decided to create
//  this class to hold the position.
// 
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Position : NSObject <NSCopying> {
    NSInteger _xCoordinate;
    NSInteger _yCoordinate;
}

@property NSInteger xCoordinate;
@property NSInteger yCoordinate;


//Compound x and y update function
-(void)updateX:(NSInteger)x Y:(NSInteger)y;

@end
