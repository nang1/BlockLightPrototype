//
//  QuickStageView.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stage.h"

@interface QuickStageView : UIView {
    Stage* _stage;
    
    BOOL _spikeTape;
	BOOL first; // when drawing lines, this indicates whether this is the starting or ending point of the line
    
    UIBezierPath *_myPath;
    UIColor *brushPattern; // color of lines when user draws
    
    BOOL _hiddenNotes;
    NSMutableArray* _noteLabels;
	NSMutableArray* _propsArray; // array to hold props positioned on stage
    NSMutableArray* _actorArray; // array to hold actors on stage
    NSMutableArray* _rulerLabelsArray; // array to hold ruler labels
}

@property (nonatomic, strong) Stage* stage;

@property BOOL spikeTape;
@property BOOL first;
@property (strong) UIBezierPath* myPath;
@property (strong) UIColor* brushPattern;
@property BOOL hiddenNotes;
@property (strong) NSMutableArray* noteLabels;
@property (strong) NSMutableArray* propsArray;
@property (strong) NSMutableArray* actorArray;
@property (strong) NSMutableArray* rulerLabelsArray;

- (id) initWithFrame:(CGRect)frame andViewController:(id)viewController andStage:(Stage*)stage;
@end
