//
//  Frame.h
//  Prototype
//
//  A model that stores all the items that have been set to the stage
//  for a particular frame.
//
//  Created by Nicole Ang on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Frame : NSObject <NSCopying>{
    UIImage* _frameIcon;
    UIBezierPath* _spikePath;
    NSMutableArray* _actorsOnStage;
    NSMutableArray* _props;
    NSMutableArray* _notes;
    BOOL _notesPresent; //show or hide notes
    
    /* Plans right now: Add arrays to hold spike path and traffic patterns so that
     * each frame can have it own. Right now the spike path and traffic patterns
     * persist through all frames.
     * Also, plan to add a BOOL to hide and show the spike path and traffic patterns. 
     */
    
    NSMutableArray* _undoArray;
	NSMutableArray* _redoArray;
}

@property (strong) UIImage* frameIcon;
@property (strong) UIBezierPath* spikePath;
@property (strong) NSMutableArray* actorsOnStage;
@property (strong) NSMutableArray* props;
@property (strong) NSMutableArray* notes;
@property BOOL notesPresent;
@property (strong) NSMutableArray* undoArray;
@property (strong) NSMutableArray* redoArray;

@end
