//
//  Frame.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Frame : NSObject {
    UIImage* _frameIcon;
    UIBezierPath* _spikePath;
    NSMutableArray* _actorsOnStage;
    NSMutableArray* _props;
    NSMutableArray* _notes;
    BOOL _notesPresent; //show or hide notes
}

@property (strong) UIImage* frameIcon;
@property (strong) UIBezierPath* spikePath;
@property (strong) NSMutableArray* actorsOnStage;
@property (strong) NSMutableArray* props;
@property (strong) NSMutableArray* notes;
@property BOOL notesPresent;

@end
