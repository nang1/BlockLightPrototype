//
//  ViewView.h
//  Blocklight_Prototype
//
//  Created by nang1 on 9/25/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewView : UITableView <UITableViewDataSource, UITableViewDelegate> {
}

// These methods may need to be modified as we add the implementation
- (id)init;
- (void)gridSwitch;

@end
