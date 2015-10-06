//
//  RoundUpViewController.m
//  TipCalculatorFinal
//
//  Created by Nizha Shree Seenivasan on 9/29/15.
//  Copyright (c) 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "RoundUpViewController.h"

@interface RoundUpViewController ()
@property int defaultRoundUpIndex;
- (NSString*) getDisplayValueByIndex:(int) index;
@end
@implementation RoundUpViewController
{
    NSArray *tableData;
    NSUserDefaults *defaults;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Rounding Up";
    }
    tableData = [NSArray arrayWithObjects:@"0", @"1", @"2" , @"5",nil];
    defaults = [NSUserDefaults standardUserDefaults];
    self.defaultRoundUpIndex = [defaults integerForKey:@"tipCalculator.roundOffSetting"];
    return self;
}

- (NSString*) getRoundUpDisplayValue
{
    return [self getDisplayValueByIndex:self.defaultRoundUpIndex];
}

- (NSString*) getDisplayValueByIndex:(int) index
{
    if (index == 0)
        return @"None";
    else
        return [NSString stringWithFormat:@"$%@", [tableData objectAtIndex:index]];
}

- (int) getDefaultRoundUpValue {
    return [[tableData objectAtIndex:self.defaultRoundUpIndex] integerValue];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    cell.textLabel.text = [self getDisplayValueByIndex:indexPath.row];
    if (indexPath.row == self.defaultRoundUpIndex)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

// UITableView Delegate Method
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.defaultRoundUpIndex = indexPath.row;
    [defaults setValue:[NSString stringWithFormat:@"%d", indexPath.row] forKey:@"tipCalculator.roundOffSetting"];
    [defaults synchronize];
    [tableView reloadData];
}


@end
