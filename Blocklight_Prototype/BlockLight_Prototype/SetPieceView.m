//
//  SetPieceView.m
//  Blocklight_Prototype
//
//  Created by nang1 on 9/25/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import "SetPieceView.h"

@implementation SetPieceView

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

- (id)init {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 216) style:UITableViewStyleGrouped];
    
    if(self == nil)
        return nil;
    
    self.dataSource = self;
    self.delegate = self;
    
    return self;
}

// UITableView Datasource for Set Piece Popover
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    UITableViewCell* cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    
    // Options to display in Set Piece Popover
    switch(section){
        case 0:
        {
            cell.textLabel.text = @"Spike Tape";
            UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
            [switchview addTarget:self action:@selector(spikeTape) forControlEvents:UIControlEventValueChanged];
            //[switchview setOn:[self contentView].spikeTape animated:NO];
            
            cell.accessoryView = switchview;
        }
            break;
            
        case 1: // Layout options save certain positions of set pieces
        {
            switch (row) {
                case 0:
                    cell.textLabel.text = @"Save Current Layout";
                    break;
                    
                case 1:
                    cell.textLabel.text = @"Layout Presets";
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 2: // Lists all the set pieces the user can choose
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
                    cell.textLabel.text = @"Risers";
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

// Set height for table
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 50.0;
    return height;
}

// Determines the number of rows in a section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    
    switch (section) {
        case 0:
            rows = 1;
            break;
            
        case 1:
            rows = 2;
            break;
            
        case 2:
            rows = 6;
            break;
            
        default:
            break;
    }
    
    return rows;
}

// Determines the number of sections for a table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger section = 3;
    return section;
}

// How to respond to a row that got selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    switch (section) {
        case 1: // User selected layout options
        {
            switch (row) {
                case 0:
                { // Save current layout and ask for a name
                    UIAlertView* saveAlert =  [[UIAlertView alloc ]initWithTitle:@"Save Layout"
                                                                         message:@"Please enter a name for the layout"
                                                                        delegate:self
                                                               cancelButtonTitle:@"Cancel"
                                                               otherButtonTitles:@"Save (Not done)",nil];
                    saveAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
                    [saveAlert show];
                    saveAlert.delegate = self;
                }
                    break;
                    
                case 1: // Select a layout preset to load to the stage
                {       // This will probably erase all other set pieces currently on the stage
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Select Layout" message:@"May create another view to select a layout" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                    [alert show];
                }
                    break;
            }
        } // end of layout options
            break;
            
        case 2: // User wants to look at some list of set pieces
        {       // Unsure if should create new views to list them
            switch (row) {
                case 0:
                {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"All" message:@"May create another view to list all set pieces" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                    [alert show];
                }
                    break;
                    
                case 1:
                {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Plants" message:@"May create another view to list all plants" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                    [alert show];
                }
                    break;
                    
                case 2:
                {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Stairs" message:@"May create another view to list all stairs" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                    [alert show];
                }
                    break;
                    
                case 3:
                {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Platforms" message:@"May create another view to list all platforms" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                    [alert show];
                }
                    break;
                    
                case 4:
                {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Risers" message:@"May create another view to list all risers" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                    [alert show];
                }
                    break;
                    
                case 5:
                {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Uncategorized" message:@"May create another view to list all uncategorized pieces" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                    [alert show];
                }
                    break;
            }
        } // end of list of set pieces
            break;
            
        default:
            break;
    }
}

- (void)spikeTape {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Spike Tape" message:@"Supposed to show or hide spike tape." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
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
