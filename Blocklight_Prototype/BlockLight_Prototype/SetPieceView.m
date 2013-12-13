//
//  SetPieceView.m
//  Blocklight_Prototype
//
//  A view that lets the user pick whether or not to draw
//  spike tape or traffic patterns. Also lets the user see the
//  categories of the set pieces in the aplication.
//
//  Created by Nicole Ang on 9/25/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import "SetPieceView.h"

@implementation SetPieceView

@synthesize popoverCtrl = _popoverCtrl;

/*************************************************
 * @function: initWithFrame
 * @discussion: initializes the view in a s
 * @param: CGRect frame
 * @return: id to this instance
 *************************************************/
 - (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*************************************************
 * @function: initWithFrame __withProductionFrame __withViewController
 * @discussion: initializes the view
 * @param: CGRect frame
 * @param: Frame* currentFrame - saves which frame the user is currently
 *                               looking at
 * @param: TVPopoverViewController* viewController
 * @return: id to this instance
 *************************************************/
- (id)initWithFrame:(CGRect)frame withProductionFrame:(Frame*)currentFrame withViewController:(TVPopoverViewController *)viewController {
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    
    if(self == nil)
        return nil;
    
    // else continue intialization
    _frame = currentFrame;
    _popoverCtrl = viewController;
    
    self.dataSource = self;
    self.delegate = self;
    
    return self;
}

/***************************************************************
 * @function: tableView __ cellForRowAtIndexPath
 * @discussion: UITableView Datasource for Set Piece Popover.
 *              Figures out what should be shown in each cell.
 * @param: UITableView* tableView
 * @param: NSIndexPath* indexPath
 * @return: UITableViewCell* - what the cell should contain
 ***************************************************************/
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    UITableViewCell* cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    
    // Options to display in Set Piece Popover
    switch(section){
        case 0:
        {
            switch(row)
            {
            case 0:
                cell.textLabel.text = @"Draw Spike Tape";
                _spikeTapeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                [_spikeTapeSwitch addTarget:self action:@selector(spikeTape) forControlEvents:UIControlEventValueChanged];
                [_spikeTapeSwitch setOn:_popoverCtrl.quickView.makeSpikeTape animated:NO];
                cell.accessoryView = _spikeTapeSwitch;
                break;
            case 1:
                cell.textLabel.text = @"Draw Traffic Patterns";
                _trafficPatternSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                [_trafficPatternSwitch addTarget:self action:@selector(trafficPatterns) forControlEvents:UIControlEventValueChanged];
                [_trafficPatternSwitch setOn:_popoverCtrl.quickView.makeTrafficTape animated:NO];
                cell.accessoryView = _trafficPatternSwitch;
                break;
            default:
                break;
            }
        }
            break;
        
        /* NOTE: If categories are changed, update the number of rows for switch(section) case 1
         *       in the method, numberOfRowsInSection.
         *    Also make sure to change the method, didSelectRowAtIndexPath, so that the appropriate
         *    response is made when clicking on a row.
         */
        case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.textColor = [UIColor blackColor];
            switch (row) {
                case 0:
                    cell.textLabel.text = @"All";
                    break;
                    
                case 1:
                    cell.textLabel.text = @"Plants";
                    break;
                    
                case 2:
                    cell.textLabel.text = @"Stairs";
                    break;
                    
                case 3:
                    cell.textLabel.text = @"Platforms";
                    break;
                    
                case 4:
                    cell.textLabel.text = @"Furniture";
                    break;
                    
                case 5:
                    cell.textLabel.text = @"Uncategorized";
                    break;
                    
                default:
                    break;
            }
        } // end of list of set pieces
            break;
            
        default:
            break;
    }
    
    return cell;
}

/********************************************************
 * @function: tableView __ heightForRowAtIndexPath
 * @discussion: Set height for table row
 * @param: UITableView* tableView
 * @param: NSIndexPath* indexPath
 * @return: CGFloat
 ********************************************************/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 50.0;
    return height;
}

/*********************************************************
 * @function: tableView __ numberOfRowsInSection
 * @discussion: Determines the number of rows in a section
 * @param: UITableView* tableView
 * @param: NSIndexPath* indexPath
 * @return: NSInteger
 *********************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    
    switch (section) {
        case 0:
            rows = 2;
            break;
            
        case 1:
            rows = 6;
            break;
            
        default:
            break;
    }
    
    return rows;
}

/*************************************************************
 * @function: numberOfSectionsInTableView
 * @discussion: Determines the number of sections for a table
 * @param: UITableView* tableView
 * @return: NSInteger
 *************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger section = 2;
    return section;
}

/*************************************************************
 * @function: tableView __ didSelectRowAtIndexPath
 * @discussion: How to respond to a row that got selected
 * @param: UITableView* tableView
 * @param: NSIndexPath* indexPath
 *************************************************************/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    // access info of tvpopoverviewcontroller
    QuickStageView* tempView = _popoverCtrl.quickView;
    Production* tempProduction = _popoverCtrl.production;
    
    TVPopoverViewController* newPopViewCtrl;
    switch(section){
        case 0: // Spike tape and traffic patterns section
            // These are handled by the action listeners. Methods are down below.
            break;
        case 1: // Go to a specific list of set pieces
            switch (row) {
                case 0: // ALL props
                {
                    //create a new popover with the same production information
                    newPopViewCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)PROPSLIST withStage:tempView withProduction:tempProduction];
                    [newPopViewCtrl setPropListType:(ListType)ALL];
                }
                    break;
                case 1: // PLANTS props
                {
                    //create a new popover with the same production information
                    newPopViewCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)PROPSLIST withStage:tempView withProduction:tempProduction];
                    [newPopViewCtrl setPropListType:(ListType)PLANTS];
                }
                    break;
                case 2: // STAIRS props
                {
                    //create a new popover with the same information
                    newPopViewCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)PROPSLIST withStage:tempView withProduction:tempProduction];
                    [newPopViewCtrl setPropListType:(ListType)STAIRS];
                }
                    break;
                case 3: // PLATFORMS props
                {
                    //create a new popover with the same information
                    newPopViewCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)PROPSLIST withStage:tempView withProduction:tempProduction];
                    [newPopViewCtrl setPropListType:(ListType)PLATFORMS];
                }
                    break;
                case 4: // FURNITURE props
                {
                    //create a new popover with the same information
                    newPopViewCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)PROPSLIST withStage:tempView withProduction:tempProduction];
                    [newPopViewCtrl setPropListType:(ListType)FURNITURE];
                }
                    break;
                case 5: // UNCATEGORIZED props
                {
                    //create a new popover with the same information
                    newPopViewCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)PROPSLIST withStage:tempView withProduction:tempProduction];
                   [newPopViewCtrl setPropListType:(ListType)UNCATEGORIZED];
                }
                    break;
                default:
                    break;
            }// got correct view of list
            
            newPopViewCtrl.popover = _popoverCtrl.popover;
            
            // push to navigation controller
            [_popoverCtrl.popoverNav pushViewController:newPopViewCtrl animated:YES];
            
            break; //end of list of set pieces
            
        default:
            break;
    }
}

/**********************************************************
 * @function: spikeTape
 * @discussion: The user clicked on the 'Draw Spike Tape' switch
 *              This either enables or disables the draw feature.
 *********************************************************/
- (void)spikeTape
{
    if([_spikeTapeSwitch isOn])
    {
        _popoverCtrl.quickView.makeSpikeTape = YES;
        _popoverCtrl.quickView.makeTrafficTape = NO;
        _popoverCtrl.quickView.first = YES;
        [_trafficPatternSwitch setOn:NO animated:YES];
    }
    else // switched spike tape off
    {
        _popoverCtrl.quickView.makeSpikeTape = NO;
    }
    [_popoverCtrl.quickView setNeedsDisplay];
}

/**********************************************************
 * @function: trafficPatterns
 * @discussion: The user clicked on the 'Draw Traffic Pattern' switch
 *              This either enables or disables the draw feature.
 *********************************************************/
-(void)trafficPatterns
{
    if([_trafficPatternSwitch isOn])
    {
        _popoverCtrl.quickView.makeTrafficTape = YES;
        _popoverCtrl.quickView.makeSpikeTape = NO;
        _popoverCtrl.quickView.first = YES;
        [_spikeTapeSwitch setOn:NO animated:YES];
    }
    else // switched spike tape off
    {
        _popoverCtrl.quickView.makeTrafficTape = NO;
    }
    [_popoverCtrl.quickView setNeedsDisplay];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
