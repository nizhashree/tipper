//
//  DefaultTipViewController.m
//  TipCalculatorFinal
//
//  Created by Nizha Shree Seenivasan on 9/28/15.
//  Copyright (c) 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "DefaultTipViewController.h"

@interface DefaultTipViewController ()
    @property NSArray *tipEnum;
    @property int defaultTipIndex;
    @property UITableViewCell *DefaultTipTableCell;
@end

@implementation DefaultTipViewController
{
    NSArray *tableData;
    NSUserDefaults *defaults;
}

- (int) getDefaultTipIndex
{
    return self.defaultTipIndex;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"Default Tip Value";
    }
    self.tipEnum = @[@(10), @(15), @(20)];
    defaults = [NSUserDefaults standardUserDefaults];
    self.defaultTipIndex = [defaults integerForKey:@"tipCalculator.defaulttipSetting"];;
    return self;
}
- (float) getDefaultTipEnumValue {
    return [self.tipEnum[self.defaultTipIndex] floatValue];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    tableData = [NSArray arrayWithObjects:@"10%", @"15%", @"20%" ,nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem2";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    if (indexPath.row == self.defaultTipIndex)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

// UITableView Delegate Method
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.defaultTipIndex = indexPath.row;
    [defaults setValue:[NSString stringWithFormat:@"%d", indexPath.row] forKey:@"tipCalculator.defaulttipSetting"];
    [defaults synchronize];
    [tableView reloadData];
}
@end
