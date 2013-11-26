//
//  ViewView.m
//  Blocklight_Prototype
//
//  Created by nang1 on 9/25/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import "ViewView.h"

@implementation ViewView

@synthesize popoverCtrl = _popoverCtrl;
@synthesize noteSwitchView = _noteSwitchView;

/* Auto-generated code
 - (id)initWithFrame:(CGRect)frame
 {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
 }
 */

- (id)initWithViewController:(TVPopoverViewController *)viewController{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 216) style:UITableViewStyleGrouped];
    
    if(self == nil)
        return nil;
    
    // else continue with initialization
    
    self.dataSource = self;
    self.delegate = self;
    
    _popoverCtrl = viewController;
    
    return self;
}

// UITableView Datasource for view Popover
// NOTE: took out some of the rows in the old Blocklight code
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    UITableViewCell* cell;
    
    // View options for display in View popover
    switch(section) {
        case 0: // General Options
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
            switch(row){
                case 0:
                    cell.textLabel.text = @"Grid Options";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 1:
                    cell.textLabel.text = @"Show Notes";
                    _noteSwitchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                    [_noteSwitchView addTarget:self action:@selector(noteSwitch) forControlEvents:UIControlEventValueChanged];
                    [_noteSwitchView setOn: !_popoverCtrl.quickView.hiddenNotes animated:NO];                    
                    cell.accessoryView = _noteSwitchView;
                    break;
                case 2: // Switch for Spike Tape
                {
                    cell.textLabel.text = @"Show Spike Tape";
                    _spikeTapeSwitchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                    [_spikeTapeSwitchView addTarget:self action:@selector(spikeTapeSwitch) forControlEvents:UIControlEventValueChanged];
                    [_spikeTapeSwitchView setOn:_popoverCtrl.quickView.showSpikeTape animated:NO];
                    cell.accessoryView = _spikeTapeSwitchView;
                }
                    break;
                case 3: // Switch for Traffic Patterns
                {
                    cell.textLabel.text = @"Show Traffic Patterns";
                    _trafficPatternSwitchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                    [_trafficPatternSwitchView addTarget:self action:@selector(trafficPatternSwitch) forControlEvents:UIControlEventValueChanged];
                    [_trafficPatternSwitchView setOn:_popoverCtrl.quickView.showTrafficTape animated:NO];
                    cell.accessoryView = _trafficPatternSwitchView;
                }
                    break;
                case 4:
                    //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
                    cell.textLabel.text = @"Show Stage Apron";
                    _apronSwitchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                    [_apronSwitchView addTarget:self action:@selector(apronSwitch) forControlEvents:UIControlEventValueChanged];
                    [_apronSwitchView setOn: _popoverCtrl.production.stage.apron animated:NO];
                    cell.accessoryView = _apronSwitchView;
                    break;
                default:
                    break;
            }
            break; // end of rows for General Options
        case 1: // Traffic Patterns, probably referring to animation step arrows
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
            cell.textLabel.text = @"Traffic Patterns";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            break;
        case 2: // Something to do with the audience
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
            cell.textLabel.text = @"Audience View";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            break;
        default:
            cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
            break;
    }
    return cell;
}

// Set height for table
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 50.0;
    return height;
}

// Determines the number of rows in a section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    if(section == 0)
    {
        rows = 4;
    }
    else if(section < 6)
    {
        rows = 1;
    }
    
    return rows;
}

// Determines the number of sections for a table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger section = 1;//3;
    return section;
}

// How to respond to a row that got selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    if(section == 0 && row == 0) { // Grid Options
        // Push grid options view onto nav controller to allow user to change grid appearance
        
        // access info of tvpopoverviewcontroller
        QuickStageView* tempView = _popoverCtrl.quickView;
        Production* tempProduction = _popoverCtrl.production;
        
        //create a new one with the same information
        TVPopoverViewController* newPopViewCtrl = [[TVPopoverViewController alloc] initPopoverView:(EditTools)GRID withStage:tempView withProduction:tempProduction];
        newPopViewCtrl.popover = _popoverCtrl.popover;
        
        // push to navigation controller
        [_popoverCtrl.popoverNav pushViewController:newPopViewCtrl animated:YES];
    }
    else if(section == 1){ // Traffic Patterns
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Traffic Patterns" message:@"Will show or hide the traffic patterns." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else if(section == 2){ // Audience View
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Audience View" message:@"Will show or hide something that interacts with the audience." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

#pragma mark Switches
// User clicked the switch for showing/hiding stage apron
-(void)apronSwitch
{
    if([_apronSwitchView isOn])
    {
        _popoverCtrl.production.stage.apron = YES;
    }
    else
    {
        _popoverCtrl.production.stage.apron = NO;
    }
    [_popoverCtrl.quickView setNeedsDisplay];
}

// User clicked the switch for showing/hiding notes
- (void)noteSwitch
{
    if([_noteSwitchView isOn])
    {
        _popoverCtrl.quickView.hiddenNotes = NO;
		for (UILabel *lbl in _popoverCtrl.quickView.noteLabels)
		{
            lbl.hidden = false;
		}
    }
    else // switched notes off
    {
        _popoverCtrl.quickView.hiddenNotes = YES;
        for (UILabel *lbl in _popoverCtrl.quickView.noteLabels)
		{
            lbl.hidden = true;
		}
    }
}

// User clicked the switch for showing/hiding spike tape
- (void)spikeTapeSwitch
{
    if([_spikeTapeSwitchView isOn])
    {
        _popoverCtrl.quickView.showSpikeTape = YES;
    }
    else // switched spike tape off
    {
        _popoverCtrl.quickView.showSpikeTape = NO;
    }
    [_popoverCtrl.quickView setNeedsDisplay];
}

-(void)trafficPatternSwitch
{
    if([_trafficPatternSwitchView isOn])
    {
        _popoverCtrl.quickView.showTrafficTape = YES;
    }
    else // switched spike tape off
    {
        _popoverCtrl.quickView.showTrafficTape = NO;
    }
    [_popoverCtrl.quickView setNeedsDisplay];
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
