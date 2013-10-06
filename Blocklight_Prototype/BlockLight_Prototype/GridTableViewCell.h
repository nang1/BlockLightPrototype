//
//  GridTableViewCell.h
//  Prototype
//
//  Created by Kyle St. Leger-Barter on 9/9/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridTableViewCell : UITableViewCell {
	//UIColor *lineColor;
	//BOOL topCell;
	UIView *cell1;
	UIView *cell2;
	UIView *cell3;
}
//@property (nonatomic, retain) UIColor* lineColor;
//@property (nonatomic) BOOL topCell;
@property (strong) UIView* cell1;
@property (strong) UIView* cell2;
@property (strong) UIView* cell3;

@end