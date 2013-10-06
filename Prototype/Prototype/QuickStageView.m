//
//  QuickStageView.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "QuickStageView.h"

@implementation QuickStageView

@synthesize horizontalGrid = _horizontalGrid;
@synthesize verticalGrid = _verticalGrid;
@synthesize grid = _grid;
@synthesize spikeTape = _spikeTape;
@synthesize myPath = _myPath;
@synthesize opacity = _opacity;
@synthesize brushPattern = _brushPattern;
@synthesize note = _note;
@synthesize first = _first;

#pragma mark Constructors
- (id)initWithFrame:(CGRect)frame andViewController:(id)viewController {
    self = [super initWithFrame:frame];
    if (self == nil)
        return nil;
    
    self.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg-production.jpg"]];
    
    _note = [[UILabel alloc] initWithFrame:CGRectMake(600, 30, 100, 300)];
    _note.lineBreakMode = NSLineBreakByWordWrapping;
    _note.numberOfLines = 0;
    _note.textColor = [UIColor blackColor];
    [self addSubview:_note];
    _note.backgroundColor = [UIColor clearColor];
    
    _horizontalGrid = YES;
    _verticalGrid = YES;
    _grid = NO;
    _opacity = 1.0;
    _myPath = [[UIBezierPath alloc] init];
    _myPath.lineCapStyle = kCGLineCapRound;
    _myPath.miterLimit = 0;
    _myPath.lineWidth = 4;
    _brushPattern = [UIColor redColor];
    _first = YES;
    //_spikeTape = YES; // had just put this line to make sure drawing lines worked
    
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Draw Stage
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 10, [UIColor blackColor].CGColor);
    
    // Stage border
    CGContextMoveToPoint(context, 50, 25);
    CGContextAddLineToPoint(context,974,25);
    CGContextAddLineToPoint(context, 974, 550);
    CGContextAddArcToPoint(context, 512, 700, 50, 550, 1500);
    CGContextAddLineToPoint(context, 50, 550);
    
    // Make stage white
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
    
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 10, [UIColor clearColor].CGColor);
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetAlpha(context, _opacity);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    // user enables grid view
    if(_grid){
        if(_horizontalGrid){
            // display horizatonal grid lines
            for(int i = 0; i < 764; i+=40){
                CGContextMoveToPoint(context, 0, i);
                CGContextAddLineToPoint(context, 1024, i);
            }
        }
        
        if(_verticalGrid){
            // display vertical grid lines
            for(int i = 0; i < 1024; i+=40){
                CGContextMoveToPoint(context, i, 0);
                CGContextAddLineToPoint(context, i, 768);
            }
        }
    }
    
    CGContextStrokePath(context);
    
    [brushPattern setStroke];
    [_myPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
}

#pragma mark - Touch Methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(_spikeTape) {
        if(first){
            first = NO;
            UITouch* mytouch = [[touches allObjects] objectAtIndex:0];
            [_myPath moveToPoint:[mytouch locationInView:self]];
        }
        else {
            first = YES;
            UITouch* myTouch = [[touches allObjects] objectAtIndex:0];
            [_myPath addLineToPoint:[myTouch locationInView:self]];
            [self setNeedsDisplay];
        }
    }
}



@end
