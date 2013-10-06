//
//  GridTableViewCell.m
//  Prototype
//
//  Created by Kyle St. Leger-Barter on 9/9/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "GridTableViewCell.h"

#define cellWidth 80
#define cellHeight 80

@implementation GridTableViewCell

- (id)initWithStyle:(UITableViewCellStyle) style reuseIdentifier:(NSString*) ID
{
    self = [super initWithStyle:style reuseIdentifier:ID];
    if (self) {
		cell1 = [[UIView alloc] initWithFrame:CGRectMake(10, 5, cellWidth, cellHeight)];
		cell2 = [[UIView alloc] initWithFrame:CGRectMake(20+cellWidth, 5, cellWidth, cellHeight)];
		cell3 = [[UIView alloc] initWithFrame:CGRectMake(2*cellWidth+30, 5, cellWidth, cellHeight)];
		
		[self addSubview:cell1];
		[self addSubview:cell2];
		[self addSubview:cell3];
    }
    return self;
}

@synthesize cell1;
@synthesize cell2;
@synthesize cell3;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
