//
//  Position.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Position : NSObject {
    //NSNumber* _xCoordinate;
    //NSNumber* _yCoordinate;
    NSInteger _xCoordinate;
    NSInteger _yCoordinate;
}

//@property (strong) NSNumber* xCoordinate;
//@property (strong) NSNumber* yCoordinate;
@property NSInteger xCoordinate;
@property NSInteger yCoordinate;


//Compound x and y update function
//-(void)updateX:(NSNumber*)x Y:(NSNumber*)y;
-(void)updateX:(NSInteger)x Y:(NSInteger)y;

@end
