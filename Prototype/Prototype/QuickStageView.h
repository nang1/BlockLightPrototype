//
//  QuickStageView.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridTableViewCell.h"

@interface QuickStageView : UIView {
    BOOL _horizontalGrid ;
	BOOL _verticalGrid;
	BOOL _grid;
	BOOL _spikeTape;
	UIBezierPath *_myPath;
	CGFloat _opacity;
    UIColor *brushPattern; // color of lines when user draws
	UILabel* _note;
	BOOL first; // ??
}

@property BOOL horizontalGrid;
@property BOOL verticalGrid;
@property BOOL grid;
@property BOOL spikeTape;
@property (strong) UIBezierPath* myPath;
@property CGFloat opacity;
@property (strong) UIColor* brushPattern;
@property (strong) UILabel* note;
@property BOOL first;

- (id) initWithFrame:(CGRect)frame andViewController:(id)viewController;

// - (void)drawStage;
@end
