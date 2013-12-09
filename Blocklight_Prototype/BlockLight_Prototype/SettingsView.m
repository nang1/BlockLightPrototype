//
//  SettingsView.m
//  Previously: DimensionsView.m
//  Blocklight_Prototype
//
//  Originally Created by Barrett Ames on 7/30/12.
//  Recreated by Jordan Nguyen on 10/16/13.
//  Copyright (c) 2013 BlockLight. All rights reserved.
//

#import "SettingsView.h"

@implementation SettingsView

@synthesize popoverCtrl = _popoverCtrl;
@synthesize stageName = _stageName;
@synthesize stageWidth=_stageWidth;
@synthesize stageHeight=_stageHeight;

/*************************************************
 * @function: initWithViewController
 * @discussion: initializes the view with a popover view controller
 * @param: TVPopoverViewController* viewController
 * @return: id to this instance
 *************************************************/
- (id)initWithViewController:(TVPopoverViewController *)viewController
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 216) style:UITableViewStyleGrouped];
    if(self == nil)
    {
        return nil;
    }
    // else continue with initialization
    
    self.dataSource = self;
    self.delegate = self;
    
    _popoverCtrl = viewController;
    
    return self;
}

/*************************************************
 * @function: tableView __ cellForRowAtIndexPath
 * @discussion: UITableView Datasource for Settings View Popover
 * @param: UITableView* tableView
 * @param: NSIndexPath* indexPath
 * @return: UITableViewCell*
 *************************************************/
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            break;
        case 1:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
            cell.textLabel.text = @"Select Layout Preset";
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

/*************************************************
 * @function: tableView __ titleForHeaderInSection
 * @discussion: Set section headings
 * @param: UITableView* tableView
 * @param: NSInteger section
 * @return: NSString
 *************************************************/
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

/*************************************************
 * @function: tableView __ heightForRowAtIndexPath
 * @discussion: Set height for table
 * @param: UITableView* tableView
 * @param: NSIndexPath* indexPath
 * @return: CGFloat
 *************************************************/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 50.0;
    return height;
}

/*************************************************
 * @function: tableView __ numberOfRowsInSection
 * @discussion: Determines the number of rows in a section
 * @param: UITableView* tableView
 * @param: NSIndexPath* indexPath
 * @return: NSInteger
 *************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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

/*************************************************
 * @function: numberOfSectionsInTableView
 * @discussion: Determines the number of sections for a table
 * @param: UITableView* tableView
 * @return: NSInteger
 *************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger section = 2;
    return section;
}

/*************************************************
 * @function: tableView __ didSelectRowAtIndexPath
 * @discussion: How to respond to a row that got selected
 * @param: UITableView* tableView
 * @param: NSIndexPath* indexPath
 *************************************************/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
            // TODO: save the current stage layout
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
            // TODO: bring up menu of currently saved layouts(probably in a separate view)
            // TODO: load new stage layout based on user's selection
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - UITextFieldDelegate Code -

/*************************************************
 * @function: textFieldShouldReturn
 * @discussion: Determines what happens when user presses return.
 *     Gets called before textFieldDidEndEditing
 * @param: UITextField* textField
 * @return: BOOL
 *************************************************/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    // it should NOT enter a new line/return carriage/whatever "return" key returns
    return NO;
}

/*************************************************
 * @function: textFieldDidEndEditing
 * @discussion: Determines what happens when user finishes editing the text field.
 *     Gets called when text fields resignFirstResponder
 * @param: UITextField* textField
 *************************************************/
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag == 0) // stage name tag
    {
        [_popoverCtrl.production.stage setName:textField.text];
        // TODO: need to somehow set: QuickStageViewController's
        // navigationItem.title = _quickProduction.stage.name;
        //[_popoverCtrl dismissPopoverView]; // <- not ideal doing this
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

/*************************************************
 * @function: textField __ shouldChangeCharactersInRange __ replacementString
 * @discussion: Determines whether or not the user can enter in a character
 *     not quite regex, but good enough (lazily implemented)
 * @param: UITextField* textField
 * @param: NSRange range
 * @param: NSString* string
 * @return: BOOL
 *************************************************/
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@""])
    {
        // backspace, don't care
        return YES;
    }
    
    switch (textField.tag)
    {
        case 0: // stage name
            if([textField.text length] >= 25)
            {
                // maximum 25 characters, before text starts to shrink within view
                return NO;
            }
            break;
        case 1: case 2: // stage width or stage height
        {
            if([textField.text length] >= 15)
            {
                // maximum fifteen characters, before text starts to shrink within view
                return NO;
            }
            
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
            // break;
        }
        default:
            break;
    }
    return YES;
}

@end
