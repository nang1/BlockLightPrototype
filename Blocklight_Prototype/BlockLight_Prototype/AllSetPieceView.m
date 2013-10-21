//
//  AllSetPieceView.m
//  Blocklight_Prototype
//
//  Created by game on 10/7/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import "AllSetPieceView.h"

@implementation AllSetPieceView

@synthesize popoverCtrl = _popoverCtrl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithFrame:(CGRect) frame withProductionFrame:(Frame*)currentFrame withViewController:(TVPopoverViewController*)viewController {
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

// UITableView Datasource for All Set Pieces Popover
// NOTE: Be sure to change numberOfRowsInSection() when adding/deleting
//       cases in switch statement
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    //NSInteger section = [indexPath section];
    
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    
    // Options to display in All Set Pieces Popover
    switch(row){
        case 0:
        {
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.text = @"Tree";
        }
            break;
        case 1:
        {
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.text = @"Door";
        }
            break;
        case 2:
        {
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.text = @"Recycle Bin";
        }
            break;
        default:
            break;
    }
    
    return cell;
}

// Set height for table
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 50.0;
    return height;
}

// Determines the number of rows in a section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 3;
    return rows;
}

// Determines number of sections for a table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger section = 1;
    return section;
}

// How to respond to a row that got selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    
    switch (row) {
        case 0:
        {
            [self addNewSetPiece:@"tree"];
        }
            break;
        case 1:
            [self addNewSetPiece:@"Door"];
            break;
        case 2:
            [self addNewSetPiece:@"trash"];
            break;
            
        default:
            break;
    }
}

- (void)addNewSetPiece:(NSString*)imageType {
    SetPiece* newProp = [[SetPiece alloc] initWithImage:imageType];
    
    [_frame.props addObject:newProp];
    
    [_popoverCtrl dismissPopoverView];
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
