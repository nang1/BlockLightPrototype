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
                case 0: {
                    cell.textLabel.text = @"Spacing";
                    cell.detailTextLabel.text = @"1";
                }
                    break;
                case 1: {
                    cell.textLabel.text = @"Measurement";
                    cell.detailTextLabel.text = @"Feet";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                    break;
                case 2: {
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
        case 1: // Opacity Slider for grid
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
            minValue.textColor = cell.detailTextLabel.textColor;
            [cell addSubview:minValue];
            
            //Max value label
            UILabel* maxValue = [[UILabel alloc] initWithFrame:CGRectMake(275, 7, 30, 25)];
            maxValue.text=@"1.0";
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

// Set height for table
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 50.0;
    return height;
}

// Determines the number of rows in a section
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    
    if(section == 0)
        rows = 3;
    else if (section == 1)
        rows = 1;
    
    return rows;
}

// Determines the number of sections for the table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sections = 2;
    
    return sections;
}

// How to respond to row that got selected
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    if(section == 0) {
        switch (row) {
            case 0: {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Spacing" message:@"Change the spacing of the grid lines" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                [alert show];
            }
                break;
            case 1: {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Measurement" message:@"Change the measurement type of the grid lines. Can be feet or meters." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                [alert show];
            }
                break;
            case 2: {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Grid Type" message:@"Can choose whether to show or hide vertical and horizontal grid lines." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                [alert show];
            }
                break;
        }
    }
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
