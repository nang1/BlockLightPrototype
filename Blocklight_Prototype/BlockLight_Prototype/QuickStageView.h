//
//  QuickStageView.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickStageView : UIView {
    BOOL _horizontalGrid;
	BOOL _verticalGrid;
	BOOL _grid; // default minimum: 16 lines height x 24 lines width
	BOOL _spikeTape;
	UIBezierPath *_myPath;
    float _spacing; // should be in Stage?
    float _opacity; // should be in Stage?
	//CGFloat _opacity;
    UIColor *brushPattern; // color of lines when user draws
    NSMutableArray* _noteLabels;
    BOOL _hiddenNotes;
	BOOL first; // when drawing lines, this indicates whether this is the starting or ending point of the line
    
    NSMutableArray* _propsArray; // array to hold props positioned on stage
    NSMutableArray* _actorArray; // array to hold actors on stage
}

@property BOOL horizontalGrid;
@property BOOL verticalGrid;
@property BOOL grid;
@property BOOL spikeTape;
@property (strong) UIBezierPath* myPath;
@property float spacing;
@property float opacity; // float uses less memory than CGFloat which is a wrapper
//@property CGFloat opacity; // for both floats(32-bit) and doubles(64-bit)
@property (strong) UIColor* brushPattern;
@property (strong) NSMutableArray* noteLabels;
@property BOOL hiddenNotes;
@property BOOL first;

@property (strong) NSMutableArray* propsArray;
@property (strong) NSMutableArray* actorArray;

- (id) initWithFrame:(CGRect)frame andViewController:(id)viewController;
// - (void)drawStage;
@end
