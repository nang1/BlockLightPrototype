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
                {
                    cell.textLabel.text = @"Show Grid";
                    UISwitch* switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
                    [switchview addTarget:self action:@selector(gridSwitch) forControlEvents:UIControlEventValueChanged];
                    //[switchview setOn:[self contentView].grid animated:NO];
                    cell.accessoryView = switchview;
                }
                    break;
                case 1: // show ruler switch
                {
                    cell.textLabel.text = @"Show Ruler";
                    UISwitch* switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
                    [switchview addTarget:self action:@selector(rulerSwitch) forControlEvents:UIControlEventValueChanged];
                    //[switchview setOn:[self contentView].grid animated:NO];
                    cell.accessoryView = switchview;
                }
                    break;
                case 2: // measurement switch
                {
                    cell.textLabel.text = @"Use Metric System"; // Feet or Meters
                    UISwitch* switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
                    [switchview addTarget:self action:@selector(metricSwitch) forControlEvents:UIControlEventValueChanged];
                    //[switchview setOn:[self contentView].grid animated:NO];
                    
                    cell.accessoryView = switchview;
                }
                    break;
                case 3: // grid types radio buttons/table
                {
                    cell.textLabel.text = @"Grid Type";
                    cell.detailTextLabel.text = @"Full";
                    /*
                     if ([self contentView].horizontalGrid) {
                     if([self contentView].verticalGrid){
                     cell.detailTextLabel.text = @"Full";
                     }
                     else{
                     cell.detailTextLabel.text = @"Horizontal";
                     }
                     }
                     else{
                     cell.detailTextLabel.text = @"Vertical";
                     }
                     */
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1: // Spacing Slider for grid lines
        {
            cell =   [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
            UISlider* _spacingSlider = [[UISlider alloc] init];
            _spacingSlider.bounds = CGRectMake(0, 0, cell.contentView.bounds.size.width - 95, _spacingSlider.bounds.size.height);
            _spacingSlider.center = CGPointMake(CGRectGetMidX(cell.contentView.bounds), CGRectGetMidY(cell.contentView.bounds));
            //_opacitySlider.value = [self contentView].opacity;
            _spacingSlider.maximumValue = 1.0;
            _spacingSlider.minimumValue = 0.0;
            [cell addSubview: _spacingSlider];
            
            [_spacingSlider addTarget:self action:@selector(spacingChange) forControlEvents:UIControlEventValueChanged];
            
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
        case 2: // Opacity Slider for grid
        {
            cell =   [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
            UISlider* _opacitySlider = [[UISlider alloc] init];
            _opacitySlider.bounds = CGRectMake(0, 0, cell.contentView.bounds.size.width - 95, _opacitySlider.bounds.size.height);
            _opacitySlider.center = CGPointMake(CGRectGetMidX(cell.contentView.bounds), CGRectGetMidY(cell.contentView.bounds));
            //_opacitySlider.value = [self contentView].opacity;
            _opacitySlider.maximumValue = 1.0;
            _opacitySlider.minimumValue = 0.0;
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
            sectionName = @"Spacing";
            break;
        case 2:
            sectionName = @"Opacity";
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
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    if(section == 0 && row == 3)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Grid Type"
                                                        message:@"Can choose whether to show or hide vertical and horizontal grid lines."
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

#pragma mark Switch Functions

// User clicked the switch for showing/hiding grid lines
- (void)gridSwitch
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Show Grid" message:@"Will show or hide the grid." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}

// User clicked the switch for showing/hiding ruler
- (void)rulerSwitch
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ruler" message:@"Will show or hide the ruler dimensions of the stage." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}

// User clicked the switch for changing from feet to meters
- (void)metricSwitch
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Measurement" message:@"Change the measurement type of the grid lines. Can be in feet or meters." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}

#pragma mark Slider Functions

// user changed slider that controls spacing of the grid
- (void)spacingChange
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Spacing" message:@"Change spacing of grid lines according to value on slider." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}

// user changed slider that controls opacity of grid
- (void)opacityChange {
    /*
    [self contentView].opactiry = _opacitySlider.value;
    [[self contentView] setNeedsDisplay];
     */
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Opacity" message:@"Change opacity of grid lines according to value on slider." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
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
