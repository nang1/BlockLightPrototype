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
@synthesize stageName = _stageName;
@synthesize stageWidth=_stageWidth;
@synthesize stageHeight=_stageHeight;
/*
@synthesize selectPreset= _selectPreset;
//*/


- (id)initWithViewController:(TVPopoverViewController *)viewController
{
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
    case 0: // Edit Stage
        switch(row)
        {
        case 0: // Stage Name
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"reuse"];
            cell.textLabel.text = @"Name";
            
            // create UITextField
            _stageName = [[UITextField alloc] initWithFrame:CGRectMake(85, 15, 190, 30)];
            _stageName.adjustsFontSizeToFitWidth = YES;
            _stageName.textColor = [UIColor blackColor];
            _stageName.keyboardType = UIKeyboardTypeDefault;
            _stageName.returnKeyType = UIReturnKeyDone;
            _stageName.backgroundColor = [UIColor clearColor];
            _stageName.autocorrectionType = UITextAutocorrectionTypeNo;
            _stageName.autocapitalizationType = UITextAutocorrectionTypeDefault;
            _stageName.clearButtonMode = UITextFieldViewModeNever;
            [_stageName setEnabled:YES];
            
            // set text to whatever the current stage name is
            _stageName.placeholder = @"Untitled";
            [_stageName setText:_popoverCtrl.production.stage.name];
            
            // set delegate to handle text field enter event
            _stageName.tag = 0;
            [_stageName setDelegate:self];
            [cell.contentView addSubview:_stageName];
            break;
        case 1: // Width
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"reuse"];
            cell.textLabel.text = @"Width";
                
            // create UITextField
            _stageWidth = [[UITextField alloc] initWithFrame:CGRectMake(85, 15, 190, 30)];
            _stageWidth.adjustsFontSizeToFitWidth = YES;
            _stageWidth.textColor = [UIColor blackColor];
            _stageWidth.keyboardType = UIKeyboardTypeNumberPad;
            _stageWidth.returnKeyType = UIReturnKeyDone;
            _stageWidth.backgroundColor = [UIColor clearColor];
            _stageWidth.autocorrectionType = UITextAutocorrectionTypeNo;
            _stageWidth.autocapitalizationType = UITextAutocorrectionTypeDefault;
            _stageWidth.clearButtonMode = UITextFieldViewModeNever;
            [_stageWidth setEnabled:YES];
                
            // set text to whatever the current stage width is
            _stageWidth.placeholder = @"Some Width";
            [_stageWidth setText:[_popoverCtrl.production.stage.width stringValue]];

            // label for dimensions
            UILabel* dimension = [[UILabel alloc] initWithFrame:CGRectMake(230,10,70,30)];
            dimension.backgroundColor = [UIColor clearColor];
            if(_popoverCtrl.production.stage.measurementType == METERS)
            {
                [dimension setText:@"Meters"];
            }
            else // feet
            {
                [dimension setText:@"Feet"];
            }
            
            // set delegate to handle text field enter event
            _stageWidth.tag = 1;
            [_stageWidth setDelegate:self];
            [cell.contentView addSubview:_stageWidth];
            [cell.contentView addSubview:dimension];
        }
            break;
        case 2: // Height
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"reuse"];
            cell.textLabel.text = @"Height";
                
            // create UITextField
            _stageHeight = [[UITextField alloc] initWithFrame:CGRectMake(85, 15, 190, 30)];
            _stageHeight.adjustsFontSizeToFitWidth = YES;
            _stageHeight.textColor = [UIColor blackColor];
            _stageHeight.keyboardType = UIKeyboardTypeNumberPad;
            _stageHeight.returnKeyType = UIReturnKeyDone;
            _stageHeight.backgroundColor = [UIColor clearColor];
            _stageHeight.autocorrectionType = UITextAutocorrectionTypeNo;
            _stageHeight.autocapitalizationType = UITextAutocorrectionTypeDefault;
            _stageHeight.clearButtonMode = UITextFieldViewModeNever;
            [_stageHeight setEnabled:YES];
                
            // set text to whatever the current stage height is
            _stageHeight.placeholder = @"Some Height";
            [_stageHeight setText: [_popoverCtrl.production.stage.height stringValue]];
            
            // label for dimensions
            UILabel* dimension = [[UILabel alloc] initWithFrame:CGRectMake(230,10,70,30)];
            dimension.backgroundColor = [UIColor clearColor];
            if(_popoverCtrl.production.stage.measurementType == METERS)
            {
                [dimension setText:@"Meters"];
            }
            else // feet
            {
                [dimension setText:@"Feet"];
            }
            
            // set delegate to handle text field enter event
            _stageHeight.tag = 2;
            [_stageHeight setDelegate:self];
            [cell.contentView addSubview:_stageHeight];
            [cell.contentView addSubview:dimension];
        }
            break;
        default: // something weird happened
            break;
        }
        break;
    case 1: // Layout options save certain positions of set pieces
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
        sectionName = @"Edit Stage";
        break;
    case 1:
        sectionName = @"Save/Change Layout";
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
            rows = 3;
            break;
        case 1:
            rows = 2;
            break;
        default: // something weird happened
            break;
    }
    return rows;
}

// Determines the number of sections for a table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger section = 2;
    return section;
}

// How to respond to a row that got selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    switch(section)
    {
    case 0: // Edit Stage
        switch (row)
        {
        case 0: // Stage Name
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [_stageName becomeFirstResponder];
            break;
        case 1: // Stage Width
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [_stageWidth becomeFirstResponder];
            break;
        case 2: // Stage Height
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [_stageHeight becomeFirstResponder];
            break;
        default: // something weird happened
            break;
        }
        break;
    case 1: // User selected layout options
        switch (row)
        {
        case 0: // Save current layout and ask for a name
            {
                UIAlertView* saveAlert = [[UIAlertView alloc]initWithTitle:@"Save Layout"
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


#pragma mark UITextFieldDelegate Code

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    // it should NOT enter a new line/return carriage/whatever "return" key returns
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag == 0) // stage name tag
    {
        [_popoverCtrl.production.stage setName:textField.text];
        // TODO: need to somehow set: QuickStageViewController's
        // navigationItem.title = _quickProduction.stage.name;
        //[_popoverCtrl dismissPopoverView]; // <- don't want to do this
    }
    else if(textField.tag == 1) // stage width tag
    {
        [_popoverCtrl.production.stage setWidth:[NSNumber numberWithInteger:[textField.text integerValue]]];
    }
    else if(textField.tag == 2) // stage height tag
    {
        [_popoverCtrl.production.stage setHeight:[NSNumber numberWithInteger:[textField.text integerValue]]];
    }
    
    // so stage width/height will update the ruler labels
    [_popoverCtrl.quickView setNeedsDisplay];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@""])
    {
        // backspace, don't care
        return YES;
    }
    
    if([textField.text length] >= 25)
    {
        // stage name
        // maximum 25 characters, before text starts to shrink within view
        return NO;
    }
    else if(textField.tag != 0 && [textField.text length] >= 15)
    {
        // stage width or height
        // maximum fifteen characters, before text starts to shrink within view
        return NO;
    }
    
    // JNN: not quite regex, but good enough
    if(textField.tag == 1 || textField.tag == 2) // stage width or stage height tag
    {
        // have to check if replacementString contains nondigit character
        
        // get the invalid character set
        NSCharacterSet *nonDecimalNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        
        // check the string if it has any invalid characters
        NSRange invalidRange = [string rangeOfCharacterFromSet:nonDecimalNumbers];
        if(invalidRange.location == NSNotFound) // || invalidRange.length > 0);
        {
            // invalid characters not found
            return YES;
        }
        else
        {
            // invalid characters found, should not add new characters
            return NO;
        }
    }
    else // default, any textfield should be modifiable
    {
        return YES;
    }
}

@end
