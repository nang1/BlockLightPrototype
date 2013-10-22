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
                    [self displayRiserCell:cell inRow:row];
                    break;
                case 4:
                    [self displayFurnitureCell:cell inRow:row];
                    break;
                case 5:
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
        case RISERS:
            [self displayRiserCell:cell inRow:row];
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
                    sectionName = @"Risers";
                    break;
                case 4:
                    sectionName = @"Furniture";
                    break;
                case 5:
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
        case RISERS:
            sectionName = @"Risers";
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
                    rows = 1;
                    break;
                case 1: // stairs
                    rows = 1;
                    break;
                case 2: // platforms
                    rows = 1;
                    break;
                case 3: // risers
                    rows = 1;
                    break;
                case 4: // furniture
                    rows = 1;
                    break;
                case 5: // uncategorized
                    rows = 2;
                    break;
                default:
                    break;
            }
            break;
        case PLANTS:
            rows = 1;
            break;
        case STAIRS:
            rows = 1;
            break;
        case PLATFORMS:
            rows = 1;
            break;
        case RISERS:
            rows = 1;
            break;
        case FURNITURE:
            rows = 1;
            break;
        case UNCATEGORIZED:
            rows = 2;
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
        section = 6;
    }
    
    return section;
}

// How to respond to a row that got selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    switch(listType) {
        case ALL:
            switch(section) {
                case 0:
                    [self selectedPlantItem:row];
                    break;
                case 1:
                    [self selectedStairItem:row];
                    break;
                case 2:
                    [self selectedPlatformItem:row];
                    break;
                case 3:
                    [self selectedRiserItem:row];
                    break;
                case 4:
                    [self selectedFurnitureItem:row];
                    break;
                case 5:
                    [self selectedUncategorizedItem:row];
                    break;
                default:
                    break;
            }
            break;
        case PLANTS:
            [self selectedPlantItem:row];
            break;
        case STAIRS:
            [self selectedStairItem:row];
            break;
        case PLATFORMS:
            [self selectedPlatformItem:row];
            break;
        case RISERS:
            [self selectedRiserItem:row];
            break;
        case FURNITURE:
            [self selectedFurnitureItem:row];
            break;
        case UNCATEGORIZED:
            [self selectedUncategorizedItem:row];
            break;
        default:
            break;
    }
}

// This table row is displaying a plant set piece
- (void) displayPlantCell:(UITableViewCell*)cell inRow:(NSInteger)row {
    switch (row) {
        case 0:
            cell.textLabel.text = @"Tree";
            cell.imageView.image = [UIImage imageNamed:@"Tree"];
            break;
            
        default:
            break;
    }
}

// This table row is displaying a stair set piece
- (void) displayStairCell:(UITableViewCell*)cell inRow:(NSInteger)row {
    switch (row) {
        case 0:
            cell.textLabel.text = @"Some stair";
            cell.imageView.image = [UIImage imageNamed:@"production-settings"];
            break;
            
        default:
            break;
    }
}

// This table row is displaying a platform set piece
- (void) displayPlatformCell:(UITableViewCell*)cell inRow:(NSInteger)row {
    switch (row) {
        case 0:
            cell.textLabel.text = @"Some platform";
            cell.imageView.image = [UIImage imageNamed:@"production-settings"];
            break;
            
        default:
            break;
    }
}

// This table row is displaying a riser set piece
- (void) displayRiserCell:(UITableViewCell*)cell inRow:(NSInteger)row {
    switch (row) {
        case 0:
            cell.textLabel.text = @"Some riser";
            cell.imageView.image = [UIImage imageNamed:@"production-settings"];
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
            
        default:
            break;
    }
}

// User clicked on an item, create it and put on stage
- (void)addNewSetPiece:(NSString*)imageType {
    SetPiece* newProp = [[SetPiece alloc] initWithImage:imageType];
    
    [_frame.props addObject:newProp];
    
    [_popoverCtrl dismissPopoverView];
}

// User selected some plant item to be added to stage
- (void) selectedPlantItem:(NSInteger)row {
    switch (row) {
        case 0:
            [self addNewSetPiece:@"Tree"];
            break;
        default:
            break;
    }
}

// User selected some stair item to be added to stage
- (void) selectedStairItem:(NSInteger)row {
    switch (row) {
        case 0:
            [self addNewSetPiece:@"blank"];
            break;
        default:
            break;
    }
}

// User selected some platform item to be added to stage
- (void) selectedPlatformItem:(NSInteger)row {
    switch (row) {
        case 0:
            [self addNewSetPiece:@"blank"];
            break;
        default:
            break;
    }
}

// User selected some riser item to be added to stage
- (void) selectedRiserItem:(NSInteger)row {
    switch (row) {
        case 0:
            [self addNewSetPiece:@"blank"];
            break;
        default:
            break;
    }
}

// User selected some furniture item to be added to stage
- (void) selectedFurnitureItem:(NSInteger)row {
    switch (row) {
        case 0:
            [self addNewSetPiece:@"Trash"];
            break;
        default:
            break;
    }
}

// User selected some uncategorized item to be added to stage
- (void) selectedUncategorizedItem:(NSInteger)row {
    switch (row) {
        case 0:
            [self addNewSetPiece:@"Door"];
            break;
        case 1:
            [self addNewSetPiece:@"Mannequin"];
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
