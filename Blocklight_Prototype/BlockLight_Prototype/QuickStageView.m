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
@synthesize spikeTapeArray = _spikeTapeArray;
@synthesize makeTrafficTape = _makeTrafficTape;
@synthesize showTrafficTape = _showTrafficTape;
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
    _currentTape = [[Line alloc] init]; // JNN: temporary
    
    // set up traffic pattern variables
    _makeTrafficTape = NO;
    _showTrafficTape = YES;
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
        // create a UIBezierPath which is used to draw the spike tape
        UIBezierPath* spikePath = [[UIBezierPath alloc] init];
        spikePath.lineCapStyle = kCGLineCapRound;
        spikePath.miterLimit = 0;
        spikePath.lineWidth = 4;
        
        // give path points from spikeTapeArray
        for(Line *tape in _spikeTapeArray)
        {
            [spikePath moveToPoint: CGPointMake([tape start].xCoordinate, [tape start].yCoordinate)];
            [spikePath addLineToPoint: CGPointMake([tape end].xCoordinate, [tape end].yCoordinate)];
        }
        
        // actually draw the path
        CGContextStrokePath(context);
        [[UIColor redColor] setStroke];
        [spikePath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
    }
    
    if(_showTrafficTape)
    {
        // create a UIBezierPath which is used to draw the traffic patterns
        UIBezierPath* trafficPath = [[UIBezierPath alloc] init];
        trafficPath.lineCapStyle = kCGLineCapRound;
        trafficPath.miterLimit = 0;
        trafficPath.lineWidth = 4;
        
        // make the traffic pattern path dashed
        float pattern[] = {5, 10}; // { dash_size, gap_size }
        [trafficPath setLineDash:pattern count:2 phase:1];
        
        // create another UIBezierPath to draw the arrowheads
        UIBezierPath* arrowheads = [[UIBezierPath alloc] init];
        arrowheads.lineCapStyle = kCGLineCapRound;
        arrowheads.lineWidth = 4.0f;
        
        // give both paths points from trafficTapeArray
        for(Line *tape in _trafficTapeArray)
        {
            CGPoint startPoint = CGPointMake([tape start].xCoordinate, [tape start].yCoordinate);
            CGPoint endPoint = CGPointMake([tape end].xCoordinate, [tape end].yCoordinate);
            
            // the traffic path just follows the line
            [trafficPath moveToPoint: startPoint];
            [trafficPath addLineToPoint: endPoint];
            
            // to draw the arrow heads, first need to calculate the direction and normal vectors
            // calculate the direction vector towards the tail and normalize it
            float xValue = startPoint.x - endPoint.x;
            float yValue = startPoint.y - endPoint.y;//[tape start].yCoordinate - [tape end].yCoordinate;
            CGPoint direction = CGPointMake(xValue, yValue);
            direction.x = direction.x * 10.0 / sqrtf(xValue * xValue + yValue * yValue);
            direction.y = direction.y * 10.0 / sqrtf(xValue * xValue + yValue * yValue);
            
            // calculate the normal (i.e. the perpendicular) vector based off the direction
            CGPoint normal = CGPointMake(-direction.y * 0.5, direction.x * 0.5);
            
            // the arrow heads are triangles starting at the end of the line
            [arrowheads moveToPoint: endPoint];

            // endpoint + direction * 10.0 + normal * 5.0
            CGPoint tailPoint = CGPointMake(endPoint.x + direction.x + normal.x, endPoint.y + direction.y +normal.y);
            [arrowheads addLineToPoint:tailPoint];
            
            // endpoint + direction * 10.0 - normal * 5.0
            tailPoint = CGPointMake(endPoint.x + direction.x - normal.x, endPoint.y + direction.y - normal.y);
            [arrowheads addLineToPoint:tailPoint];
            
            // don't forget to close the triangle
            [arrowheads addLineToPoint:endPoint];
        }
        
        // actually draw the path
        CGContextStrokePath(context);
        [[UIColor blueColor] setStroke];
        [trafficPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
        [arrowheads strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
    }
    
    // Trash can icon (so user knows where to drag their pieces to remove them from stage)
    UIImage* bg =  [UIImage imageNamed:@"trash.png"]; // 50 x 50
    //UIImage* bg =  [UIImage imageNamed:@"trash1.png"]; // 64 x 64
    // assuming width of 768px: (width-64px)/2-imageW/2 = 768/2-64/2 = 320
    [bg drawInRect:CGRectMake(0,320,50,50) blendMode:kCGBlendModeNormal alpha:1.0];
}

#pragma mark - Touch Methods
// (see: https://developer.apple.com/Library/ios/documentation/UIKit/Reference/UIResponder_Class/Reference/Reference.html )
// touch methods should be done in a separate GlassView with a transparent UIView over the QuickStageView
// this way, the GlassView will detect touchesBegan, touchesMoved, and touchesEnded events in the UIResponder
// and prevent the user from modifying actors, notes, and setpieces while _makeSpikeTape or _makeTrafficTape is on
// the GlassViewController should have a reference to the current Frame of the Scene in order to add
// spike tape and traffic pattern lines to the Frame and further promote the Model-View-Controller architecture
// due to time constrainsts, we compromised and placed it here so the user can at least see something
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_makeSpikeTape)
    {
        UITouch* myTouch = [[touches allObjects] objectAtIndex:0];
        if(_first)
        {
            //[_currentTape setStart:[mytouch locationInView:self]];
            [_currentTape.start updateX:[myTouch locationInView:self].x Y:[myTouch locationInView:self].y];
        }
        else
        {
            //[_currentTape setEnd:[myTouch locationInView:self]];
            [_currentTape.end updateX:[myTouch locationInView:self].x Y:[myTouch locationInView:self].y];
            [_spikeTapeArray addObject:[_currentTape copy]];
            [self setNeedsDisplay];
        }
        _first = !_first;
    }
    
    if(_makeTrafficTape)
    {
        UITouch* myTouch = [[touches allObjects] objectAtIndex:0];
        if(_first)
        {
            //[_currentTape setStart:[mytouch locationInView:self]];
            [_currentTraffic.start updateX:[myTouch locationInView:self].x Y:[myTouch locationInView:self].y];
        }
        else
        {
            //[_currentTraffic setEnd:[myTouch locationInView:self]];
            [_currentTraffic.end updateX:[myTouch locationInView:self].x Y:[myTouch locationInView:self].y];
            [_trafficTapeArray addObject:[_currentTraffic copy]];
            [self setNeedsDisplay];
        }
        _first = !_first;
    }
}
@end
