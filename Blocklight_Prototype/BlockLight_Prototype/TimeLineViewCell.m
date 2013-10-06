//
//  TimeLineViewCell.m
//  Prototype
//
//  Created by Kyle St. Leger-Barter on 9/10/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import "TimeLineViewCell.h"

@implementation TimeLineViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	
	
	// Configure the view for the selected state
	if(selected)
		self.backgroundColor =[self.backgroundColor colorWithAlphaComponent:1.0f];
	else
		self.backgroundColor =[self.backgroundColor colorWithAlphaComponent:0.4f];
	
}

@end
