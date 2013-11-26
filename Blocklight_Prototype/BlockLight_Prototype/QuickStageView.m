//
//  QuickStageView.m
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "QuickStageView.h"

@implementation QuickStageView

@synthesize stage = _stage;
@synthesize first = _first;
@synthesize makeSpikeTape = _makeSpikeTape;
@synthesize showSpikeTape = _showSpikeTape;
@synthesize spikePath = _spikePath;
@synthesize spikeBrushColor = _spikeBrushColor;
@synthesize spikeTapeArray = _spikeTapeArray;
@synthesize makeTrafficTape = _makeTrafficTape;
@synthesize showTrafficTape = _showTrafficTape;
@synthesize trafficPath = _trafficPath;
@synthesize trafficBrushColor = _trafficBrushColor;
@synthesize trafficTapeArray = _trafficTapeArray;
@synthesize hiddenNotes = _hiddenNotes;
@synthesize noteLabels = _noteLabels;
@synthesize propsArray = _propsArray;
@synthesize actorArray = _actorArray;
@synthesize rulerLabelsArray = _rulerLabelsArray;

#pragma mark Constructors
- (id)initWithFrame:(CGRect)frame andViewController:(id)viewController andStage:(Stage *)stage
{
    self = [super initWithFrame:frame];
    if (self == nil)
        return nil;
    
    //self.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg-production.jpg"]];
    self.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"startScreen2"]];
        
    _stage = stage;
    
    _first = YES;
    _hiddenNotes = NO;

    // create array to hold pieces that will be shown in view
    _noteLabels = [[NSMutableArray alloc] init]; // notes
    _propsArray = [[NSMutableArray alloc] init]; // set pieces
    _actorArray = [[NSMutableArray alloc] init]; // actors
    _rulerLabelsArray = [[NSMutableArray alloc] init]; // ruler labels
    _spikeTapeArray = [[NSMutableArray alloc] init]; // spike tape
    _trafficTapeArray = [[NSMutableArray alloc] init]; // traffic patterns

    // set up spike tape variables
    _makeSpikeTape = NO;
    _showSpikeTape = YES;
    _spikePath = [[UIBezierPath alloc] init];
    _spikePath.lineCapStyle = kCGLineCapRound;
    _spikePath.miterLimit = 0;
    _spikePath.lineWidth = 4;
    _spikeBrushColor = [UIColor redColor];
    _currentTape = [[Line alloc] init]; // JNN: temporary
    
    // set up traffic pattern variables
    _makeTrafficTape = NO;
    _showTrafficTape = YES;
    _trafficPath = [[UIBezierPath alloc] init];
    _trafficPath.lineCapStyle = kCGLineCapRound;
    _trafficPath.miterLimit = 0;
    _trafficPath.lineWidth = 4;
    _trafficBrushColor = [UIColor blueColor];
    _currentTraffic = [[Line alloc] init]; // JNN: temporary
    
    // set up traffic pattern variables
    _currentTraffic = [[Line alloc] init]; // JNN: temporary
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// gets called everytime [self setNeedsDisplay]
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {    
    // Draw Stage
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 10, [UIColor blackColor].CGColor);
    
    // Stage border
    CGContextMoveToPoint(context, 50, 25);
    CGContextAddLineToPoint(context,974,25);
    if(_stage.apron) // w/ Stage Apron
    {
        CGContextAddLineToPoint(context, 974, 550);
        CGContextAddArcToPoint(context, 512, 700, 50, 550, 1500); // x1, y1, x2, y2, radius
        CGContextAddLineToPoint(context, 50, 550);
    }
    else // w/o Stage Apron
    {
        CGContextAddLineToPoint(context, 974, 625);
        CGContextAddLineToPoint(context, 50, 625);
    }
    
    // Make stage white
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
    
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 10, [UIColor clearColor].CGColor);
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetAlpha(context, [_stage.gridOpacity floatValue]);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    // remove all ruler labels if there is any
    for(int i = 0; i < [_rulerLabelsArray count]; i++)
    {
        [[_rulerLabelsArray objectAtIndex:i] removeFromSuperview];
    }
    [_rulerLabelsArray removeAllObjects];
    
    // user enables grid view
    if(_stage.grid)
    {
        if(_stage.horizontalGrid)
        {
            for(float i = 25; i <= 625; i+=600/[_stage.gridSpacing floatValue])
            {
                // draw horizontal line
                CGContextMoveToPoint(context, 50, i);
                CGContextAddLineToPoint(context, 974, i);

                if(_stage.ruler)
                {
                    UILabel* temp = [[UILabel alloc] initWithFrame:CGRectMake(50,i,90,20)];
                    [temp setBackgroundColor:[UIColor lightTextColor]];
                    int value = (int)([_stage.height floatValue]*(i-25)/600);
                    if(_stage.measurementType == METERS) // meters
                    {
                        [temp setText: [NSString stringWithFormat:@" %d m", value]];
                    }
                    else // feet
                    {
                        [temp setText: [NSString stringWithFormat:@" %d ft", value]];
                    }
                    [_rulerLabelsArray addObject:temp];
                    [self addSubview:[_rulerLabelsArray lastObject]];
                }
            }
        }
        
        if(_stage.verticalGrid)
        {
            for(float i = 50; i <= 975; i+=925/[_stage.gridSpacing floatValue])
            {
                // draw vertical line
                CGContextMoveToPoint(context, i, 25);
                CGContextAddLineToPoint(context, i, 625);

                if(_stage.ruler)
                {
                    UILabel* temp = [[UILabel alloc] initWithFrame:CGRectMake(i,25,90,20)];
                    [temp setBackgroundColor:[UIColor lightTextColor]];
                    int value = (int)([_stage.width floatValue]*(i-50)/925);
                    if(_stage.measurementType == METERS)
                    {
                        [temp setText: [NSString stringWithFormat:@" %d m", value]];
                    }
                    else // feet
                    {
                        [temp setText: [NSString stringWithFormat:@" %d ft", value]];
                    }
                    [_rulerLabelsArray addObject:temp];
                    [self addSubview:[_rulerLabelsArray lastObject]];
                }
            }
        }
    }
    
    if(_showSpikeTape)
    {
        // give path new points from spikeTapeArray
        [_spikePath removeAllPoints];
        for(Line *tape in _spikeTapeArray)
        {
            [_spikePath moveToPoint: CGPointMake([tape start].xCoordinate, [tape start].yCoordinate)];
            [_spikePath addLineToPoint: CGPointMake([tape end].xCoordinate, [tape end].yCoordinate)];
        }
        
        // actually draw the path
        CGContextStrokePath(context);
        [_spikeBrushColor setStroke];
        [_spikePath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
    }
    
    if(_showTrafficTape)
    {
        // give path new points from trafficTapeArray
        [_trafficPath removeAllPoints];
        for(Line *tape in _trafficTapeArray)
        {
            [_trafficPath moveToPoint: CGPointMake([tape start].xCoordinate, [tape start].yCoordinate)];
            [_trafficPath addLineToPoint: CGPointMake([tape end].xCoordinate, [tape end].yCoordinate)];
        }
        
        // make the path dashed
        float pattern[] = {5, 10}; // { dash_size, gap }
        [_trafficPath setLineDash:pattern count:2 phase:1];

        // Psuedo code, do not touch or JNN gets angry
        // Draw Arrow Head (triangle)
        // vec2 direction = new vec2(startpoint - endpoint).normalize();
        // vec2 perpendicular = new vec2(-direction.y, direction.x).normalize();
        // point1 = direction*distance + perpendicular * distance;
        // point2 = direction*distance - perpendicular * distance;
        // point3 = endpoint
        //[_spikePath addLineToPoint: CGPointMake([tape end].xCoordinate, [tape end].yCoordinate)];
        //[_spikePath addLineToPoint: CGPointMake([tape end].xCoordinate, [tape end].yCoordinate)];
        //[_spikePath addLineToPoint: CGPointMake([tape end].xCoordinate, [tape end].yCoordinate)];

        // actually draw the path
        CGContextStrokePath(context);
        [_trafficBrushColor setStroke];
        [_trafficPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
    }
    
    // Trash can
    UIImage* bg =  [UIImage imageNamed:@"trash.png"]; // 50 x 50
    //UIImage* bg =  [UIImage imageNamed:@"trash1.png"]; // 64 x 64
    // assuming width of 768px: (width-64px)/2-imageW/2 = 768/2-64/2 = 320
    [bg drawInRect:CGRectMake(0,320,50,50) blendMode:kCGBlendModeNormal alpha:1.0];
}

#pragma mark - Touch Methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_makeSpikeTape)
    {
        UITouch* myTouch = [[touches allObjects] objectAtIndex:0];
        if(_first)
        {
            [_currentTape.start updateX:[myTouch locationInView:self].x Y:[myTouch locationInView:self].y];
            //[_currentTape setStart:[mytouch locationInView:self]];
        }
        else
        {
            [_currentTape.end updateX:[myTouch locationInView:self].x Y:[myTouch locationInView:self].y];
            [_spikeTapeArray addObject:[_currentTape copy]];
            //[_currentTape setEnd:[myTouch locationInView:self]];
            [self setNeedsDisplay];
        }
        _first = !_first;
    }
    
    if(_makeTrafficTape)
    {
        UITouch* myTouch = [[touches allObjects] objectAtIndex:0];
        if(_first)
        {
            [_currentTraffic.start updateX:[myTouch locationInView:self].x Y:[myTouch locationInView:self].y];
            //[_currentTape setStart:[mytouch locationInView:self]];
        }
        else
        {
            [_currentTraffic.end updateX:[myTouch locationInView:self].x Y:[myTouch locationInView:self].y];
            [_trafficTapeArray addObject:[_currentTraffic copy]];
            //[_currentTraffic setEnd:[myTouch locationInView:self]];
            [self setNeedsDisplay];
        }
        _first = !_first;
    }
}
@end
