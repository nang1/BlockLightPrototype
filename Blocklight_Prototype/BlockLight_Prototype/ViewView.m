//
//  ViewView.m
//  Blocklight_Prototype
//
//  Created by nang1 on 9/25/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import "ViewView.h"

@implementation ViewView

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

- (id)initWithViewController:(TVPopoverViewController *)viewController{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 216) style:UITableViewStyleGrouped];
    
    if(self == nil)
        return nil;
    
    // else continue with initialization
    
    self.dataSource = self;
    self.delegate = self;
    
    _popoverCtrl = viewController;
    
    return self;
}

// UITableView Datasource for view Popover
// NOTE: took out some of the rows in the old Blocklight code
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    UITableViewCell* cell;
    
    // View options for display in View popover
    switch(section) {
        case 0: // Grid Options
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
            switch(row){
                case 0: // Switch for grid on stage
                {
                    cell.textLabel.text = @"Grid View";
                    UISwitch* switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
                    [switchview addTarget:self action:@selector(gridSwitch) forControlEvents:UIControlEventValueChanged];
                    //[switchview setOn:[self contentView].grid animated:NO];
                    
                    cell.accessoryView = switchview;
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"Grid Options";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                    break;
                    
                default:
                    break;
            }
            break; // end of rows for Grid Options
            
        case 1: // Traffic Patterns, probably referring to spike tape
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
            cell.textLabel.text = @"Traffic Patterns";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
            
        case 2: // Make notes visible or not
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
            cell.textLabel.text = @"Notes";
            cell.textLabel.textColor=[UIColor grayColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
            
        case 3: // lines w/ numbers that indicate the length of something
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
            cell.textLabel.text = @"Ruler";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
            
        case 4: // Something to do with the audience
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
            cell.textLabel.text = @"Audience View";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
            
        default:
            cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
            break;
    }
    return cell;
}

// Set height for table
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 50.0;
    return height;
}

// Determines the number of rows in a section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    if(section == 0)
        rows = 2;
    else if(section < 6)
        rows = 1;
    
    return rows;
}

// Determines the number of sections for a table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger section = 5;
    return section;
}

// How to respond to a row that got selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    if(section == 0 && row == 1) { // Grid Options
        // Push grid options view onto nav controller to allow user to change grid appearance
        
        // access info of tvpopoverviewcontroller
        QuickStageView* tempView = _popoverCtrl.quickView;
        Production* tempProduction = _popoverCtrl.production;
        
        //create a new one with the same information
        TVPopoverViewController* newPopViewCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)GRID withStage:tempView withProduction:tempProduction];
        
        // push to navigation controller
        [_popoverCtrl.popoverNav pushViewController:newPopViewCtrl animated:YES];
    }
    else if(section == 1){ // Traffic Patterns
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Traffic Patterns" message:@"Will show or hide the traffic patterns." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else if(section == 2){ // Notes
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Notes" message:@"Will show or hide the notes." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else if(section == 3){ // Ruler
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ruler" message:@"Will show or hide a ruler that display the dimensions of the stage." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else if(section == 4){ // Audience View
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Audience View" message:@"Will show or hide something that interacts with the audience." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

// User clicked the switch for showing/hiding grid lines
- (void)gridSwitch {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Grid Switch" message:@"Will show or hide the grid lines." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
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
