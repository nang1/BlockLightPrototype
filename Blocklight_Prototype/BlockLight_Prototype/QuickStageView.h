//
//  QuickStageView.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stage.h"
#import "Line.h"

@interface QuickStageView : UIView {
    Stage* _stage;
    
	BOOL _first; // when drawing lines, this indicates whether this is the starting or ending point of the line
    
    BOOL _makeSpikeTape; // draw spike tape mode
    BOOL _showSpikeTape;
    NSMutableArray* _spikeTapeArray; // array to hold spike tape lines
    Line* _currentTape; // the current spike tape being created
    
    BOOL _makeTrafficTape; // draw traffic tape mode
    BOOL _showTrafficTape;
    NSMutableArray* _trafficTapeArray; // array to hold traffic tape lines
    Line* _currentTraffic; // the current traffic line being created
    
    BOOL _hiddenNotes;
    NSMutableArray* _noteLabels; // array to hold notes on stage
	NSMutableArray* _propsArray; // array to hold props positioned on stage
    NSMutableArray* _actorArray; // array to hold actors on stage
    NSMutableArray* _rulerLabelsArray; // array to hold ruler labels
}

@property (nonatomic, strong) Stage* stage;

@property BOOL first;

@property BOOL makeSpikeTape;
@property BOOL showSpikeTape;
@property (strong) NSMutableArray* spikeTapeArray;

@property BOOL makeTrafficTape;
@property BOOL showTrafficTape;
@property (strong) NSMutableArray* trafficTapeArray;

@property BOOL hiddenNotes;
@property (strong) NSMutableArray* noteLabels;
@property (strong) NSMutableArray* propsArray;
@property (strong) NSMutableArray* actorArray;
@property (strong) NSMutableArray* rulerLabelsArray;

- (id) initWithFrame:(CGRect)frame andViewController:(id)viewController andStage:(Stage*)stage;
@end
