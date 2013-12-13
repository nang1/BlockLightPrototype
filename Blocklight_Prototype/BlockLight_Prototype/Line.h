//
//  Line.h
//  Blocklight_Prototype
//
//  A generic model containing the start and end points of a line.
//  Used for creating spike tape and traffic patterns.
//
//  Created by Jordan Nguyen on 11/22/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Position.h"

@interface Line : NSObject <NSCopying>
{
    /*************
     * NOTE: Planned to use CGPoints to hold the positions of the objects.
     *       But Xcode was giving some bizarre errors, so we create a custom
     *       class, Position, to store it.
     ************/
    //CGPoint* _start;
    //CGPoint* _end;
    Position* _start;
    Position* _end;
}

//@property (nonatomic, strong) CGPoint* start;
//@property (nonatomic, strong) CGPoint* end;
@property (nonatomic, strong) Position* start;
@property (nonatomic, strong) Position* end;

@end
