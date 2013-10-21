//
//  SettingsView.m
//  Previously: DimensionsView.m
//  Blocklight_Prototype
//
//  Created by Barrett Ames on 7/30/12.
//  Recreated by Jordan Nguyen on 10/16/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import "SettingsView.h"

@implementation SettingsView

@synthesize popoverCtrl = _popoverCtrl;
/*
@synthesize selectPreset= _selectPreset;
@synthesize stageName=_stageName;
@synthesize stageWidth=_stageWidth;
@synthesize stageHeight=_stageHeight;
//*/


- (id)initWithViewController:(TVPopoverViewController *)viewController{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 216) style:UITableViewStyleGrouped];
    //self = [self initWithFrame:CGRectMake(0, 0, 320, 216)];
    
    if(self == nil)
        return nil;
    
    // else continue with initialization
    
    self.dataSource = self;
    self.delegate = self;
    
    _popoverCtrl = viewController;
    
    /* // JNN: if we ever want to add a header for whatever reason:
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(10,20,300,40)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
    headerLabel.text = @"Header for the table";
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.shadowColor = [UIColor blackColor];
    headerLabel.shadowOffset = CGSizeMake(0, 1);
    headerLabel.font = [UIFont boldSystemFontOfSize:22];
    headerLabel.backgroundColor = [UIColor clearColor];
    [containerView addSubview:headerLabel];
    [self setTableHeaderView:containerView];
    //*/
    
    return self;
}

// JNN: Barrett Ames's prev code:
/*- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg-production.jpg"]];
        
        //[self addSubview: [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"squareStage.png" ]]];
        
        UIColor* _theColor = [UIColor grayColor];
        
        // Edit Stage Label
        UILabel* _editLabel = [[UILabel alloc] initWithFrame:CGRectMake(365, 35, 150, 50)];
        _editLabel.text = @"Edit Stage";
        _editLabel.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:_editLabel];
        
        // This is what it takes to make a round rectangle with a shadow
        UIView* _roundRect = [[UIView alloc] initWithFrame:CGRectMake(0, 0,300, 300)];
        _roundRect.layer.backgroundColor = [UIColor grayColor].CGColor;
        _roundRect.layer.cornerRadius = 10.0;
        _roundRect.layer.masksToBounds = YES;
        
        UIView* _shadowRect = [[UIView alloc] initWithFrame:CGRectMake(362, 75,300, 300)];
        _shadowRect.layer.masksToBounds = YES;
        _shadowRect.layer.cornerRadius =  10;
        _shadowRect.layer.borderColor =  [UIColor blackColor].CGColor;
        _shadowRect.layer.borderWidth = 3.0f;
        _shadowRect.layer.shadowColor = [UIColor grayColor].CGColor;
        _shadowRect.layer.shadowRadius = 10.0;
        _shadowRect.layer.shadowOffset =CGSizeMake(0.0, 0.0);
        _shadowRect.layer.opacity =1.0;
        [_shadowRect addSubview:_roundRect];
        [self addSubview:_shadowRect];
        
        // labels have to go ontop of the rectangle, and thus after in the view hierarchy
        UILabel* _presetLabel = [[UILabel alloc] initWithFrame:CGRectMake(410, 90, 150, 25)];
        _presetLabel.text = @"Preset";
        _presetLabel.font = [UIFont systemFontOfSize:18.0];
        _presetLabel.backgroundColor = _theColor;
        [self addSubview:_presetLabel];
        
        _selectPreset = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _selectPreset.frame = CGRectMake(470, 90, 175, 25);
        [_selectPreset setTitle:@"Select Preset Stage" forState:UIControlStateNormal];
        [self addSubview:_selectPreset];
        
        _stageName = [[UITextField alloc] initWithFrame:CGRectMake(410, 130, 235, 25)];
        //_stageName.textAlignment = UITextAlignmentCenter; // deprecated
        _stageName.text = @"Stage Name";
        _stageName.backgroundColor = [UIColor whiteColor];
        [self addSubview:_stageName];
        
        UILabel* _widthLabel = [[UILabel alloc] initWithFrame:CGRectMake(410, 170, 50, 25)];
        _widthLabel.text = @"Width";
        _widthLabel.backgroundColor = _theColor;
        [self addSubview:_widthLabel];
        
        _stageWidth = [[UITextField alloc] initWithFrame:CGRectMake(470, 170, 100, 25)];
        _stageWidth.backgroundColor = [UIColor whiteColor];
        _stageWidth.text = @"0";
        //_stageWidth.textAlignment = UITextAlignmentCenter; // deprecated
        [self addSubview:_stageWidth];
        
        UILabel* _heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(410, 210, 50, 25)];
        _heightLabel.text = @"Height";
        _heightLabel.backgroundColor = _theColor;
        [self addSubview:_heightLabel];
        
        _stageHeight = [[UITextField alloc] initWithFrame:CGRectMake(470, 210, 100, 25)];
        _stageHeight.backgroundColor = [UIColor whiteColor];
        _stageHeight.text=@"0";
        //_stageHeight.textAlignment=UITextAlignmentCenter; // deprecated
        [self addSubview:_stageHeight];
        
        
        // Edit Apron Label
        UILabel* _apronLabel = [[UILabel alloc] initWithFrame:CGRectMake(365, 375, 150, 50)];
        _apronLabel.text = @"Stage Apron";
        _apronLabel.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:_apronLabel];
        
        UIView* _roundRect2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,300, 50)];
        _roundRect2.layer.backgroundColor = [UIColor grayColor].CGColor;
        _roundRect2.layer.cornerRadius = 10.0;
        _roundRect2.layer.masksToBounds = YES;
        
        UIView* _shadowRect2 = [[UIView alloc] initWithFrame:CGRectMake(362, 415,300, 50)];
        _shadowRect2.layer.masksToBounds = YES;
        _shadowRect2.layer.cornerRadius =  10;
        _shadowRect2.layer.borderColor =  [UIColor blackColor].CGColor;
        _shadowRect2.layer.borderWidth = 3.0f;
        _shadowRect2.layer.shadowColor = [UIColor grayColor].CGColor;
        _shadowRect2.layer.shadowRadius = 10.0;
        _shadowRect2.layer.shadowOffset =CGSizeMake(0.0, 0.0);
        _shadowRect2.layer.opacity =1.0;
        [_shadowRect2 addSubview:_roundRect2];
        [self addSubview:_shadowRect2];
    }
    return self;
} //*/

// UITableView Datasource for Settings View Popover
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    UITableViewCell* cell;
    
    // Settings options for display in Settings View popover
    switch(section)
    {
    case 0: // Layout options save certain positions of set pieces
        switch (row)
        {
        case 0:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
            cell.textLabel.text = @"Save Current Layout";
            //cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            break;
        case 1:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
            cell.textLabel.text = @"Select Layout Preset";
            //cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            break;
        default: // something weird happened
            break;
        }
        break;
    case 1: // Edit Stage
        switch(row)
        {
        case 0: // Stage Name
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"reuse"];
            cell.textLabel.text = @"Name";
            cell.detailTextLabel.text = @"Name of Stage";
            //cell.textLabel.textColor = [UIColor grayColor];
            //cell.textLabel.textAlignment = NSTextAlignmentCenter;
            break;
        case 1: // Width
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"reuse"];
            cell.textLabel.text = @"Width";
            cell.detailTextLabel.text = @"Some Number";
            //cell.textLabel.textColor = [UIColor grayColor];
            //cell.textLabel.textAlignment = NSTextAlignmentCenter;
            break;
        case 2: // Height
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"reuse"];
            cell.textLabel.text = @"Height";
            cell.detailTextLabel.text = @"Some Number";
            //cell.textLabel.textColor = [UIColor grayColor];
            //cell.textLabel.textAlignment = NSTextAlignmentCenter;
            break;
        default: // something weird happened
            break;
        }
        break;
    case 2: // Stage Apron
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
        cell.textLabel.text = @"Stage Apron";
        //cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        break;
    default:
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
        break;
    }
    return cell;
}

// Set section headings
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = @"";
    switch (section)
    {
    case 0:
        sectionName = @"Save/Change Layout";
        break;
    case 1:
        sectionName = @"Edit Stage";
        break;
    case 2:
        sectionName = @"Other Settings";
        break;
    default: // no section name
        break;
    }
    return sectionName;
}

// Set height for table
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 50.0;
    return height;
}

// Determines the number of rows in a section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 1;
    switch (section)
    {
        case 0:
            rows = 2;
            break;
        case 1:
            rows = 3;
            break;
        case 2:
            rows = 1;
            break;
        default: // something weird happened
            break;
    }
    return rows;
}

// Determines the number of sections for a table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger section = 3;
    return section;
}

// How to respond to a row that got selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    switch(section)
    {
    case 0: // User selected layout options
        switch (row)
        {
        case 0: // Save current layout and ask for a name
            {
                UIAlertView* saveAlert =  [[UIAlertView alloc]initWithTitle:@"Save Layout"
                                                                    message:@"Please enter a name for the layout"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:@"Save (Not done)",nil];
                saveAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
                [saveAlert show];
                saveAlert.delegate = self;
            }
            break;
        case 1: // Select a layout preset to load to the stage
            {
                // This will probably erase all other set pieces currently on the stage
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Select Layout"
                                                                message:@"May create another view to select a layout"
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Ok", nil];
                [alert show];
            }
            break;
        default: // something weird happened
            break;
        }
        // end of layout options
        break;
    case 1: // Edit Stage
        switch (row)
        {
        case 0: // Stage Name
            {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Stage Name"
                                                                message:@"To name your stage before saving. Needs text field."
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Ok", nil];
                [alert show];
            }
            break;
        case 1: // Stage Width
            {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Width"
                                                                message:@"To set your stage width. Needs text field."
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Ok", nil];
                [alert show];
            }
            break;
        case 2: // Stage Height
            {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Height"
                                                                message:@"To set your stage height. Needs text field."
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Ok", nil];
                [alert show];
            }
            break;
        default: // something weird happened
            break;
        }
        break;
    case 2: // Stage Apron
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Stage Apron"
                                                            message:@"To modify somehow the stage apron, probably in a separate window."
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Ok", nil];
            [alert show];
        }
        break;
    default: // something weird happened
        break;
    }
}

// JNN: Barrett Ames's prev code:
/* // Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 10, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, 50,25);
    CGContextAddLineToPoint(context, 974, 25);
    CGContextAddLineToPoint(context, 974, 550);
    CGContextAddArcToPoint(context, 512,700, 50,550, 1500);
    CGContextAddLineToPoint(context, 50, 550);
 
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
}
//*/

@end
