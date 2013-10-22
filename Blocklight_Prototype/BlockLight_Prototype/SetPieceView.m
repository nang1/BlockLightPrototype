//
//  SetPieceView.m
//  Blocklight_Prototype
//
//  Created by nang1 on 9/25/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import "SetPieceView.h"

@implementation SetPieceView

@synthesize popoverCtrl = _popoverCtrl;

 - (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

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
            rows = 6;
            break;
            
        default:
            break;
    }
    
    return rows;
}

// Determines the number of sections for a table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger section = 2;
    return section;
}

// How to respond to a row that got selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    // access info of tvpopoverviewcontroller
    QuickStageView* tempView = _popoverCtrl.quickView;
    Production* tempProduction = _popoverCtrl.production;
    
    TVPopoverViewController* newPopViewCtrl;
    switch(section){
        case 0:
            // spike tape
            break;
        case 1: // Go to list of set pieces
            switch (row) {
                case 0:
                {
                    //create a new popover with the same information
                    newPopViewCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)PROPSLIST withStage:tempView withProduction:tempProduction];
                    [newPopViewCtrl setPropListType:(ListType)ALL];
                }
                    break;
                case 1:
                {
                    //create a new popover with the same information
                    newPopViewCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)PROPSLIST withStage:tempView withProduction:tempProduction];
                    [newPopViewCtrl setPropListType:(ListType)PLANTS];
                }
                    break;
                case 2:
                {
                    //create a new popover with the same information
                    newPopViewCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)PROPSLIST withStage:tempView withProduction:tempProduction];
                    [newPopViewCtrl setPropListType:(ListType)STAIRS];
                }
                    break;
                case 3:
                {
                    //create a new popover with the same information
                    newPopViewCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)PROPSLIST withStage:tempView withProduction:tempProduction];
                    [newPopViewCtrl setPropListType:(ListType)PLATFORMS];
                }
                    break;
                case 4:
                {
                    //create a new popover with the same information
                    newPopViewCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)PROPSLIST withStage:tempView withProduction:tempProduction];
                    [newPopViewCtrl setPropListType:(ListType)FURNITURE];
                }
                    break;
                case 5:
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
