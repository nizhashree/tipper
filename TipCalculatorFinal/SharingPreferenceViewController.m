//
//  SharingPreferenceViewController.m
//  TipCalculatorFinal
//
//  Created by Nizha Shree Seenivasan on 9/29/15.
//  Copyright (c) 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "SharingPreferenceViewController.h"
#import "TipViewController.h"

@interface SharingPreferenceViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *SharingPreferencePicker;
@property TipViewController *tvc;
@property int selectedIndex;
@property  int selectedValue;
@end

@implementation SharingPreferenceViewController
{
    NSArray *pickerData;
    UITextField * alertTextField;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Sharing Preference";
    }
    return self;
}

- (void) setParentView:(TipViewController*)TipController
{
    self.tvc = TipController;
    [self.tvc settingSharingPreferenceValue:1];
    [self.tvc settingSharingPreferenceIndex:0 ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    pickerData = [NSArray arrayWithObjects:@"1", @"2", @"3", @"5" , @"other",nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(row == 4){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Dividing among more friends!" message:@"Please enter the number of persons to share with" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alertTextField = [alert textFieldAtIndex:0];
        alertTextField.keyboardType = UIKeyboardTypeDefault;
        [alert show];
    }
    else
    {
        [self.tvc settingSharingPreferenceValue:[[pickerData objectAtIndex:row] integerValue]];
        [self.tvc settingSharingPreferenceIndex:row ];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString* detailString = alertTextField.text;
    NSLog(@"String is: %@", detailString); //Put it on the debugger
    if ([alertTextField.text length] <= 0 ){
        return; //If cancel or 0 length string the string doesn't matter
    }
    [self.tvc settingSharingPreferenceValue:[detailString integerValue]];
    [self.tvc settingSharingPreferenceIndex:3 ];
}
@end
