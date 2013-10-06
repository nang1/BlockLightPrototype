//
//  QuickStageViewController.h
//  Prototype
//
//  Created by nang1 on 9/8/13.
//  Copyright (c) 2013 nang1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Production.h"
#import "Frame.h"
#import "QuickStageView.h"
#import "TimeLineViewCell.h"


@interface QuickStageViewController : UIViewController <UITableViewDelegate, UIGestureRecognizerDelegate,UITableViewDataSource>{
    Production* _quickProduction;
    //UIBarButtonItem* _viewButton; // this is pulled out so it can be used by the method it calls
	
	//Performers button
	UINavigationController* _performerNav;
	UITableView* _performerTable;
	UIPopoverController* _performerPopover;
	UIBarButtonItem* _performers;
	
	//Timeline
	UITableView* _timeline;
}

@property (strong) Production* quickProduction;
@property (strong) UIPopoverController* performerPopover;
//@property (strong) UIBarButtonItem* viewButton;

@end
