//
//  GridOptionsView.m
//  Blocklight_Prototype
//
//  Created by nang1 on 10/16/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//
// This popover adjusts the grid that can be displayed on the stage

#import "GridOptionsView.h"

@implementation GridOptionsView

@synthesize popoverCtrl = _popoverCtrl;
@synthesize gridSwitchView = _gridSwitchView;
@synthesize rulerSwitchView = _rulerSwitchView;
@synthesize metricSwitchView = _metricSwitchView;
@synthesize horizontal = _horizontal;
@synthesize vertical = _vertical;
@synthesize spacingSlider = _spacingSlider;
@synthesize opacitySlider = _opacitySlider;

/* Auto-generated code
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
 */

- (id)initWithViewController:(TVPopoverViewController *)viewController {
    self = [super initWithFrame:CGRectMake(0, 0,320, 216) style:UITableViewStyleGrouped];
    
    if(self == nil)
        return nil;
    
    // else continue with initialization
    self.dataSource = self;
    self.delegate = self;
    
    _popoverCtrl = viewController;
    return self;
}

// UITableView Datasource for grid options view popover
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    UITableViewCell* cell;
    
    // Grid options in popover
    switch(section) {
        case 0: { // adjust grid lines
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
            switch(row) {
                case 0: // show grid switch
                    cell.textLabel.text = @"Show Grid";
                    _gridSwitchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                    [_gridSwitchView addTarget:self action:@selector(gridSwitch) forControlEvents:UIControlEventValueChanged];
                    [_gridSwitchView setOn:_popoverCtrl.production.stage.grid animated: NO];
                    cell.accessoryView = _gridSwitchView;
                    break;
                case 1: // grid types radio buttons/table
                {
                    cell.textLabel.text = @"Grid Type";
                    
                    // horizontal text
                    UILabel* hText = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 50, 30)];
                    [hText setBackgroundColor:[UIColor clearColor]];
                    [hText setAdjustsFontSizeToFitWidth:YES];
                    [hText setText:@"Horizontal"];
                    
                    // horizontal button
                    _horizontal = [UIButton buttonWithType:UIButtonTypeCustom];
                    _horizontal.frame = CGRectMake(160, 10, 30, 30);
                    [_horizontal addTarget:self action:@selector(horzButton) forControlEvents: UIControlEventTouchUpInside];
                    [_horizontal setBackgroundImage:[UIImage imageNamed:@"circle"] forState:UIControlStateSelected];
                    [_horizontal setBackgroundImage:[UIImage imageNamed:@"square"] forState:UIControlStateNormal];
                    //[_horizontal setBackgroundImage:[UIImage imageNamed:@"water"] forState:UIControlStateHighlighted];
                    [_horizontal setSelected:_popoverCtrl.production.stage.horizontalGrid];
                    
                    // vertical text
                    UILabel* vText = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, 50, 30)];
                    [vText setBackgroundColor:[UIColor clearColor]];
                    [vText setAdjustsFontSizeToFitWidth:YES];
                    [vText setText:@"Vertical"];
                    
                    // vertical button
                    _vertical = [UIButton buttonWithType:UIButtonTypeCustom];
                    _vertical.frame = CGRectMake(260, 10, 30, 30);
                    [_vertical addTarget:self action:@selector(vertButton) forControlEvents: UIControlEventTouchUpInside];
                    [_vertical setBackgroundImage:[UIImage imageNamed:@"circle"] forState:UIControlStateSelected];
                    [_vertical setBackgroundImage:[UIImage imageNamed:@"square"] forState:UIControlStateNormal];
                    //[_vertical setBackgroundImage:[UIImage imageNamed:@"water"] forState:UIControlStateHighlighted];
                    [_vertical setSelected:_popoverCtrl.production.stage.verticalGrid];
                    
                    // add everything to the cell
                    [cell addSubview:hText];
                    [cell addSubview:_horizontal];
                    [cell addSubview:vText];
                    [cell addSubview:_vertical];
                }
                    break;
                case 2: // show ruler switch
                    cell.textLabel.text = @"Show Ruler";
                    _rulerSwitchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                    [_rulerSwitchView addTarget:self action:@selector(rulerSwitch) forControlEvents:UIControlEventValueChanged];
                    [_rulerSwitchView setOn:_popoverCtrl.production.stage.ruler animated: NO];
                    cell.accessoryView = _rulerSwitchView;
                    break;
                case 3: // measurement switch
                {
                    cell.textLabel.text = @"Use Metric System"; // Feet or Meters
                    _metricSwitchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                    [_metricSwitchView addTarget:self action:@selector(metricSwitch) forControlEvents:UIControlEventValueChanged];
                    
                    if(_popoverCtrl.production.stage.measurementType == FEET)
                    {
                        [_metricSwitchView setOn:NO animated:NO];
                    }
                    else // meters
                    {
                        [_metricSwitchView setOn:YES animated:NO];
                    }
                    
                    cell.accessoryView = _metricSwitchView;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1: // Spacing Slider for grid lines
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
            _spacingSlider = [[UISlider alloc] init];
            _spacingSlider.bounds = CGRectMake(0, 0, cell.contentView.bounds.size.width - 95, _spacingSlider.bounds.size.height);
            _spacingSlider.center = CGPointMake(CGRectGetMidX(cell.contentView.bounds), CGRectGetMidY(cell.contentView.bounds));
            _spacingSlider.minimumValue = 1.0;
            _spacingSlider.maximumValue = 10.0;
            _spacingSlider.value = [_popoverCtrl.production.stage.gridSpacing floatValue];
            [cell addSubview: _spacingSlider];
            
            [_spacingSlider addTarget:self action:@selector(spacingChange) forControlEvents:UIControlEventValueChanged];
            
            // Min value label
            UILabel* minValue = [[UILabel alloc] initWithFrame:CGRectMake(20, 7,30, 25)];
            minValue.text = @"1.0";
            minValue.backgroundColor = [UIColor clearColor];
            minValue.textColor = cell.detailTextLabel.textColor;
            [cell addSubview:minValue];
            
            //Max value label
            UILabel* maxValue = [[UILabel alloc] initWithFrame:CGRectMake(275, 7, 30, 25)];
            maxValue.text = @"10."; // because the UILabel rect is small
            maxValue.backgroundColor = [UIColor clearColor];
            maxValue.textColor = cell.detailTextLabel.textColor;
            [cell addSubview:maxValue];
        }
            break;            
        case 2: // Opacity Slider for grid
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
            _opacitySlider = [[UISlider alloc] init];
            _opacitySlider.bounds = CGRectMake(0, 0, cell.contentView.bounds.size.width - 95, _opacitySlider.bounds.size.height);
            _opacitySlider.center = CGPointMake(CGRectGetMidX(cell.contentView.bounds), CGRectGetMidY(cell.contentView.bounds));
            _opacitySlider.minimumValue = 0.0;
            _opacitySlider.maximumValue = 1.0;
            _opacitySlider.value = [_popoverCtrl.production.stage.gridOpacity floatValue];
            [cell addSubview: _opacitySlider];
            
            [_opacitySlider addTarget:self action:@selector(opacityChange) forControlEvents:UIControlEventValueChanged];
            
            // Min value label
            UILabel* minValue = [[UILabel alloc] initWithFrame:CGRectMake(20, 7,30, 25)];
            minValue.text = @"0.0";
            minValue.backgroundColor = [UIColor clearColor];
            minValue.textColor = cell.detailTextLabel.textColor;
            [cell addSubview:minValue];
            
            //Max value label
            UILabel* maxValue = [[UILabel alloc] initWithFrame:CGRectMake(275, 7, 30, 25)];
            maxValue.text = @"1.0";
            maxValue.backgroundColor = [UIColor clearColor];
            maxValue.textColor = cell.detailTextLabel.textColor;
            [cell addSubview:maxValue];
        }
            break;
        default: {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
            cell.textLabel.text = @"default";
        }
            break;
    }
    
    return cell;
}

// Set section headings
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = @"";
    switch (section)
    {
        case 0:
            //sectionName = @"Basic Settings";
            break;
        case 1:
            sectionName = [NSString stringWithFormat: @"Spacing: %f x %f", _spacingSlider.value, _spacingSlider.value];
            break;
        case 2:
            sectionName = [NSString stringWithFormat:@"Opacity: %f", _opacitySlider.value];
            break;
        default: // no section name
            break;
    }
    return sectionName;
}

// Set height for table
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 50.0;
    return height;
}

// Determines the number of rows in a section
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    
    if(section == 0)
        rows = 4;
    else if (section == 1)
        rows = 1;
    else if (section == 2)
        rows = 1;
    
    return rows;
}

// Determines the number of sections for the table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sections = 3;
    
    return sections;
}

// How to respond to row that got selected
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSInteger section = [indexPath section];
    //NSInteger row = [indexPath row];
    [self deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Switch Functions

// User clicked the switch for showing/hiding grid lines
- (void)gridSwitch
{
    if([_gridSwitchView isOn])
    {
        _popoverCtrl.production.stage.grid = YES;
    }
    else // switched grid off
    {
        _popoverCtrl.production.stage.grid = NO;
    }
    [_popoverCtrl.quickView setNeedsDisplay];
}

// User clicked the switch for showing/hiding ruler
- (void)rulerSwitch
{
    if([_rulerSwitchView isOn])
    {
        _popoverCtrl.production.stage.ruler = YES;
    }
    else // switched ruler off
    {
        _popoverCtrl.production.stage.ruler = NO;
    }
    [_popoverCtrl.quickView setNeedsDisplay];
}

// User clicked the switch for changing from feet to meters
- (void)metricSwitch
{
    if([_metricSwitchView isOn]) // meters
    {
        _popoverCtrl.production.stage.measurementType = METERS;
    }
    else // feet
    {
        _popoverCtrl.production.stage.measurementType = FEET;
    }
    [_popoverCtrl.quickView setNeedsDisplay];
}

#pragma mark Button Press
// user pressed the horizontal check box
-(void)horzButton
{
    if(_horizontal.selected)
    {
        [_horizontal setSelected:NO];
        _popoverCtrl.production.stage.horizontalGrid = NO;
    }
    else
    {
        [_horizontal setSelected:YES];
        _popoverCtrl.production.stage.horizontalGrid = YES;
    }
    [_popoverCtrl.quickView setNeedsDisplay];
}

// user pressed the vertical check box
-(void)vertButton
{
    if(_vertical.selected)
    {
        [_vertical setSelected:NO];
        _popoverCtrl.production.stage.verticalGrid = NO;
    }
    else
    {
        [_vertical setSelected:YES];
        _popoverCtrl.production.stage.verticalGrid = YES;
    }
    [_popoverCtrl.quickView setNeedsDisplay];
}

#pragma mark Slider Functions

// user changed slider that controls spacing of the grid
- (void)spacingChange
{
    _popoverCtrl.production.stage.gridSpacing = [NSNumber numberWithFloat:_spacingSlider.value];
    [[self headerViewForSection:1].textLabel setText:[NSString stringWithFormat: @"Spacing: %f x %f", _spacingSlider.value, _spacingSlider.value]];
    [_popoverCtrl.quickView setNeedsDisplay];
}

// user changed slider that controls opacity of grid
- (void)opacityChange
{
    _popoverCtrl.production.stage.gridOpacity = [NSNumber numberWithFloat:_opacitySlider.value];
    [[self headerViewForSection:2].textLabel setText:[NSString stringWithFormat: @"Opacity: %f", _opacitySlider.value]];
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
