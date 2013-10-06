//
//  Position.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Position : NSObject {
    NSInteger _xCoordinate;
    NSInteger _yCoordinate;
}

@property NSInteger xCoordinate;
@property NSInteger yCoordinate;

//Compound x and y update function
-(void)updateX:(NSInteger)x Y:(NSInteger)y;

@end
