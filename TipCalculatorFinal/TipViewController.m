//
//  TipViewController.m
//  TipCalculatorFinal
//
//  Created by Nizha Shree Seenivasan on 9/27/15.
//  Copyright (c) 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"
#import "SharingPreferenceViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *BillTextField;
@property (weak, nonatomic) IBOutlet UILabel *TipTextField;
@property (weak, nonatomic) IBOutlet UILabel *TotalTextField;
@property (weak, nonatomic) IBOutlet UILabel *RoundedValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *RoundOffSettingLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *TipPercentageArray;
@property (weak, nonatomic) IBOutlet UILabel *RoundedValueTextField;
@property (weak, nonatomic) IBOutlet UILabel *TotalAmountPerPersonText;
@property (weak, nonatomic) IBOutlet UILabel *ActualAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *TipPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *TotalAmountPerPersonLabel;
- (IBAction)BillAmountEdited:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SharingButton;
@property SettingsViewController *svc;
@property int RoundUpLimit;
@property int SharingPreferenceValue;
@property int SharingPreferenceIndex;
- (void) constructSharingButtonText;
- (IBAction)tipControl:(id)sender;
- (IBAction)AmountTextEditingBegan:(id)sender;
- (IBAction)SharingPreferenceInitiated:(id)sender;
- (NSString*)ParseAmountToFloat;
- (void) displayPerPersonLabels:(float)a;
-(void) setRoundOffFields:(float)a;
- (float)calculateTotalAmountAfterRounding:(float) amount;
@end

@implementation TipViewController
{
    NSUserDefaults *defaults;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tipper";
    }
    defaults = [NSUserDefaults standardUserDefaults];
    self.svc = [[SettingsViewController alloc] init];
    self.svc.edgesForExtendedLayout = UIRectEdgeNone;
    self.SharingPreferenceIndex = 0;
    self.SharingPreferenceValue = 1;
    self.RoundUpLimit = 0;
    return self;
}
- (int) gettingSharingPreferenceIndex
{
    return self.SharingPreferenceIndex;
}
- (void)settingSharingPreferenceValue:(int) preferenceValue
{
    self.SharingPreferenceValue = preferenceValue;
}

- (void)settingSharingPreferenceIndex:(int) preferenceIndex
{
    self.SharingPreferenceIndex = preferenceIndex;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self set_initial_bill_amount];
    [self updateTip];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self  action: @selector(goToSettingsController)];
    [self.BillTextField becomeFirstResponder];
}

- (void) set_initial_bill_amount
{
   float initial_bill_amount = [defaults floatForKey:@"tipCalculator.initial_bill_amount"];
    NSDate * initial_bill_amount_date = (NSDate *)[defaults objectForKey:@"tipCalculator.initial_bill_amount_timestamp"];
     float timeDiff = [[NSDate date] timeIntervalSinceDate:initial_bill_amount_date];
    if (timeDiff > 600)
    {
        self.BillTextField.text = @"0.00";
        [defaults setFloat:0.00 forKey:@"tipCalculator.initial_bill_amount"];
    }
    else if (initial_bill_amount > 0)
        self.BillTextField.text = [NSString stringWithFormat:@"$%0.2f", initial_bill_amount];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewDidAppear:(BOOL)animated
{
     int tempRoundUpLimit = [self.svc getRoundUpLimit];
     if (self.TipPercentageArray.selectedSegmentIndex != [self.svc getDefaultTipIndex] || (self.RoundUpLimit - tempRoundUpLimit) != 0)
     {
         self.RoundUpLimit = [self.svc getRoundUpLimit];
         self.TipPercentageArray.selectedSegmentIndex = [self.svc getDefaultTipIndex];
     }
    [self updateTip];
}

- (IBAction)SharingPreferenceInitiated:(id)sender {
    SharingPreferenceViewController* spc = [[SharingPreferenceViewController alloc]init];
    [spc setParentView:self];
    [self.navigationController pushViewController:spc animated:YES];
}

- (IBAction)tipControl:(id)sender {
    [self.view endEditing:YES];
    self.BillTextField.text = [NSString stringWithFormat:@"$%0.2f", [[self ParseAmountToFloat] floatValue]];
    [self updateTip];
}

- (IBAction)AmountTextEditingBegan:(id)sender {
    if ([self.BillTextField.text  isEqual: @"$"]){
        self.BillTextField.text = @ "$";
    }
}


- (void) goToSettingsController{
    [self.navigationController pushViewController:self.svc animated:YES];
}

- (NSString*)ParseAmountToFloat {
   return [self.BillTextField.text stringByReplacingOccurrencesOfString:@"$" withString:@""];
}

- (void) updateTip {
    float billAmount = [[self ParseAmountToFloat] floatValue];
    NSArray *tipEnum = @[@(0.10), @(0.15), @(0.2)];
    float tipPercentage = [tipEnum[self.TipPercentageArray.selectedSegmentIndex] floatValue] * 100;
    float tipAmount = billAmount * [tipEnum[self.TipPercentageArray.selectedSegmentIndex] floatValue];
    float totalAmount = billAmount + tipAmount;
    self.TipTextField.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    totalAmount = [self calculateTotalAmountAfterRounding:totalAmount];
    self.TotalTextField.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    [self setRoundOffFields:(totalAmount - (tipAmount + billAmount))];
    self.TipPercentageLabel.text = [NSString stringWithFormat:@"(%d%%)", (int)tipPercentage];
    [self constructSharingButtonText];
    [self displayPerPersonLabels:totalAmount ];
}

- (void) setRoundOffFields:(float) amount
{
    if(self.RoundUpLimit != 0){
        [self.RoundedValueTextField setHidden:NO];
        [self.RoundOffSettingLabel setHidden:NO];
        [self.RoundedValueLabel setHidden:NO];
        self.RoundOffSettingLabel.text = [NSString stringWithFormat:@"($%d)", self.RoundUpLimit];
        self.RoundedValueTextField.text = [NSString stringWithFormat:@"$%0.2f", amount];
    }
    else{
        [self.RoundedValueTextField setHidden:YES];
        [self.RoundOffSettingLabel setHidden:YES];
        [self.RoundedValueLabel setHidden:YES];
    }
}
- (void) displayPerPersonLabels:(float) totalAmount
{
    if (self.SharingPreferenceValue != 1){
        [self.TotalAmountPerPersonText setHidden:NO];
        [self.TotalAmountPerPersonLabel setHidden:NO];
        self.TotalAmountPerPersonLabel.text = @" Per person:";
        self.TotalAmountPerPersonText.text = [NSString stringWithFormat:@"$%0.2f", totalAmount/self.SharingPreferenceValue];
    }
    else{
        [self.TotalAmountPerPersonText setHidden:YES];
        [self.TotalAmountPerPersonLabel setHidden:YES];
    }
}
- (void) constructSharingButtonText
{
    if (self.SharingPreferenceValue != 1)
        [self.SharingButton setTitle:[NSString stringWithFormat:@"%d", self.SharingPreferenceValue] forState:UIControlStateNormal];
    else
        [self.SharingButton setTitle:@"none" forState:UIControlStateNormal];
}
- (float) calculateTotalAmountAfterRounding:(float) totalAmount
{
    if (self.RoundUpLimit == 0)
        return totalAmount;
    else if (ceil(totalAmount) == totalAmount)
        return totalAmount;
    else
    {
        return ceil(totalAmount) + self.RoundUpLimit - 1;
    }
}
- (IBAction)BillAmountEdited:(id)sender {
    float billAmount = [[self ParseAmountToFloat] floatValue];
    if (billAmount > 0)
    {
        [defaults setFloat:billAmount forKey:@"tipCalculator.initial_bill_amount"];
        [defaults setObject:[[NSDate alloc] init] forKey:@"tipCalculator.initial_bill_amount_timestamp"];
        [defaults synchronize];
    }
}

@end
