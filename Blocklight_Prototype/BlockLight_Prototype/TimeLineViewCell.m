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

/*************************************************
 * @function: - (void)setSelected:(BOOL)selected animated:(BOOL)animated
 * @discussion: Sets selected frame in production
 * @param: bool selected
 * @param: bool animated
 * @return: void
 *************************************************/
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

	
    if(selected){
        
    }
    else {
        self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:0.4f];
        self.imageView.image = NULL;
    }
}

@end
