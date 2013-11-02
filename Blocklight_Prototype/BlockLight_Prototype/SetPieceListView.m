//
//  SetPieceListView.m
//  Blocklight_Prototype
//
//  Created by nang1 on 10/21/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//
// Displays a list of set pieces for the user to add to the stage
// Depending on what the user selected in SetPieceView, a different list will show

/* NOTE: When changing number of set pieces availabe, be sure to update the methods:
 *           numberOfRowsInSection
 *           display<ListType>Cell
 *           selected<ListType>Item
 *           and edit SetPiece.m
 *
 *       When changing number of categories, update the methods:
 *           cellForRowAtIndexPath
 *           didSelectRowAtIndexPath
 *           titleForHeaderInSection
 *           numberOfSectionsInTableView
 *           and edit SetPieceView.m and Defaults.h
 */
#import "SetPieceListView.h"

@implementation SetPieceListView

@synthesize popoverCtrl = _popoverCtrl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect) frame withProductionFrame:(Frame*)currentFrame withViewController:(TVPopoverViewController*)viewController{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    
    if(self == nil)
        return nil;
    
    // else continue initialization
    _frame = currentFrame;
    _popoverCtrl = viewController;
    
    self.dataSource = self;
    self.delegate = self;
    
    // Number of props for each category
    _numPlants = 9;
    _numStairs = 3;
    _numPlatforms = 1;
    _numFurniture = 9;
    _numUncategorized = 9;
    
    return self;
}

- (void)setListType:(ListType)lType {
    listType = lType;
}

// UITableView Datasource for Set Pieces List Popover
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    cell.textLabel.textColor = [UIColor blackColor];
    
    // Options to display in Set Pieces List Popover 
    switch (listType){
        case ALL:
            switch (section) {
                case 0:
                    [self displayPlantCell:cell inRow:row];
                    break;
                case 1:
                    [self displayStairCell:cell inRow:row];
                    break;
                case 2:
                    [self displayPlatformCell:cell inRow:row];
                    break;
                case 3:
                    [self displayFurnitureCell:cell inRow:row];
                    break;
                case 4:
                    [self displayUncategorizedCell:cell inRow:row];
                    break;
                default:
                    break;
            }
            break;
        case PLANTS:
            [self displayPlantCell:cell inRow:row];
            break;
        case STAIRS:
            [self displayStairCell:cell inRow:row];
            break;
        case PLATFORMS:
            [self displayPlatformCell:cell inRow:row];
            break;
        case FURNITURE:
            [self displayFurnitureCell:cell inRow:row];
            break;
        case UNCATEGORIZED:
            [self displayUncategorizedCell:cell inRow:row];
            break;
        default:
            break;
    }
    
    return cell;
}

// Set height for table row
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 50.0;
    return height;
}

// Set section headings
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = @"";
    
    switch (listType) {
        case ALL: // Show all categories
            switch (section){
                case 0:
                    sectionName = @"Plants";
                    break;
                case 1:
                    sectionName = @"Stairs";
                    break;
                case 2:
                    sectionName = @"Platforms";
                    break;
                case 3:
                    sectionName = @"Furniture";
                    break;
                case 4:
                    sectionName = @"Uncategorized";
                    break;
                default: // no section name
                    break;
            }
            break;
        case PLANTS:
            sectionName = @"Plants";
            break;
        case STAIRS:
            sectionName = @"Stairs";
            break;
        case PLATFORMS:
            sectionName = @"Platforms";
            break;
        case FURNITURE:
            sectionName = @"Furniture";
            break;
        case UNCATEGORIZED:
            sectionName = @"Uncategorized";
            break;
        default:
            break;
    }
    return sectionName;
}

// Determines the number of rows in a section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 3;
    
    switch (listType){
        case ALL:
            switch(section){
                case 0: // plants
                    rows = _numPlants;
                    break;
                case 1: // stairs
                    rows = _numStairs;
                    break;
                case 2: // platforms
                    rows = _numPlatforms;
                    break;
                case 3: // furniture
                    rows = _numFurniture;
                    break;
                case 4: // uncategorized
                    rows = _numUncategorized;
                    break;
                default:
                    break;
            }
            break;
        case PLANTS:
            rows = _numPlants;
            break;
        case STAIRS:
            rows = _numStairs;
            break;
        case PLATFORMS:
            rows = _numPlatforms;
            break;
        case FURNITURE:
            rows = _numFurniture;
            break;
        case UNCATEGORIZED:
            rows = _numUncategorized;
            break;
        default:
            break;
    }
    return rows;
}

// Determines number of sections for a table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger section = 1;
    
    if (listType == (ListType)ALL) {
        section = 5;
    }
    
    return section;
}

// How to respond to a row that got selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // add new set piece
    SetPiece* newProp = [[SetPiece alloc] initWithImage:[self cellForRowAtIndexPath:indexPath].imageView.image];
    [_frame.props addObject:newProp];
    [_popoverCtrl dismissPopoverView];
}

// This table row is displaying a plant set piece
- (void) displayPlantCell:(UITableViewCell*)cell inRow:(NSInteger)row {
    switch (row) {
        case 0:
            cell.textLabel.text = @"Tree";
            cell.imageView.image = [UIImage imageNamed:@"Tree"];
            break;
        case 1:
            cell.textLabel.text = @"Cactus";
            cell.imageView.image = [UIImage imageNamed:@"cactus"];
            break;
        case 2:
            cell.textLabel.text = @"Flower";
            cell.imageView.image = [UIImage imageNamed:@"flower"];
            break;
        case 3:
            cell.textLabel.text = @"Bush";
            cell.imageView.image = [UIImage imageNamed:@"bush1"];
            break;
        case 4:
            cell.textLabel.text = @"Flower Pot";
            cell.imageView.image = [UIImage imageNamed:@"flowerpot1"];
            break;
        case 5:
            cell.textLabel.text = @"Log";
            cell.imageView.image = [UIImage imageNamed:@"log"];
            break;
        case 6:
            cell.textLabel.text = @"Rock";
            cell.imageView.image = [UIImage imageNamed:@"rock1"];
            break;
        case 7:
            cell.textLabel.text = @"Sand";
            cell.imageView.image = [UIImage imageNamed:@"Sand"];
            break;
        case 8:
            cell.textLabel.text = @"Stump";
            cell.imageView.image = [UIImage imageNamed:@"stump"];
            break;
        default:
            break;
    }
}

// This table row is displaying a stair set piece
- (void) displayStairCell:(UITableViewCell*)cell inRow:(NSInteger)row {
    switch (row) {
        case 0:
            cell.textLabel.text = @"Black Stairs";
            cell.imageView.image = [UIImage imageNamed:@"stairs"];
            break;
        case 1:
            cell.textLabel.text = @"Spiral Stairs";
            cell.imageView.image = [UIImage imageNamed:@"Spiral_Staircase"];
            break;
        case 2:
            cell.textLabel.text = @"Ladder";
            cell.imageView.image = [UIImage imageNamed:@"ladder"];
            break;
        default:
            break;
    }
}

// This table row is displaying a platform set piece
- (void) displayPlatformCell:(UITableViewCell*)cell inRow:(NSInteger)row {
    switch (row) {
        case 0:
            cell.textLabel.text = @"Podium";
            cell.imageView.image = [UIImage imageNamed:@"Podium"];
            break;
            
        default:
            break;
    }
}

// This table row is displaying a furniture set piece
- (void) displayFurnitureCell:(UITableViewCell*)cell inRow:(NSInteger)row {
    switch (row) {
        case 0:
            cell.textLabel.text = @"Recycle Bin";
            cell.imageView.image = [UIImage imageNamed:@"trash"];
            break;
        case 1:
            cell.textLabel.text = @"Couch";
            cell.imageView.image = [UIImage imageNamed:@"couch"];
            break;
        case 2:
            cell.textLabel.text = @"Chair";
            cell.imageView.image = [UIImage imageNamed:@"chair"];
            break;
        case 3:
            cell.textLabel.text = @"Wood Chair";
            cell.imageView.image = [UIImage imageNamed:@"chair1"];
            break;
        case 4:
            cell.textLabel.text = @"Red Chair";
            cell.imageView.image = [UIImage imageNamed:@"chair2"];
            break;
        case 5:
            cell.textLabel.text = @"Steel Chair";
            cell.imageView.image = [UIImage imageNamed:@"chair3"];
            break;
        case 6:
            cell.textLabel.text = @"Nightstand";
            cell.imageView.image = [UIImage imageNamed:@"nightstand"];
            break;
        case 7:
            cell.textLabel.text = @"Table";
            cell.imageView.image = [UIImage imageNamed:@"table1"];
            break;
        case 8:
            cell.textLabel.text = @"Round Table";
            cell.imageView.image = [UIImage imageNamed:@"table2"];
            break;
        default:
            break;
    }
}

// This table row is displaying an uncategorized set piece
- (void) displayUncategorizedCell:(UITableViewCell*)cell inRow:(NSInteger)row {
    switch (row) {
        case 0:
            cell.textLabel.text = @"Door";
            cell.imageView.image = [UIImage imageNamed:@"Door"];
            break;
        case 1:
            cell.textLabel.text = @"Mannequin";
            cell.imageView.image = [UIImage imageNamed:@"mannequin"];
            break;
        case 2:
            cell.textLabel.text = @"Bridge";
            cell.imageView.image = [UIImage imageNamed:@"bridge"];
            break;
        case 3:
            cell.textLabel.text = @"Circle";
            cell.imageView.image = [UIImage imageNamed:@"circle"];
            break;
        case 4:
            cell.textLabel.text = @"Square";
            cell.imageView.image = [UIImage imageNamed:@"square"];
            break;
        case 5:
            cell.textLabel.text = @"Water";
            cell.imageView.image = [UIImage imageNamed:@"water"];
            break;
        case 6:
            cell.textLabel.text = @"Brick Wall";
            cell.imageView.image = [UIImage imageNamed:@"brickWall"];
            break;
        case 7:
            cell.textLabel.text = @"Fence";
            cell.imageView.image = [UIImage imageNamed:@"fence"];
            break;
        case 8:
            cell.textLabel.text = @"Gate";
            cell.imageView.image = [UIImage imageNamed:@"gate"];
            break;
            
        default:
            break;
    }
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
