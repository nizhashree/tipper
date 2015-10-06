//
//  SettingsViewController.m
//  TipCalculatorFinal
//
//  Created by Nizha ; Seenivasan on 9/28/15.
//  Copyright (c) 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "SettingsViewController.h"
#import "DefaultTipViewController.h"
#import "RoundUpViewController.h"

@interface SettingsViewController ()
@property DefaultTipViewController *dtc;
@property RoundUpViewController *ruc;
@property UITableViewCell *utc;
@property UITableViewCell *rtc;
@end

@implementation SettingsViewController
{
    NSArray *tableData;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Settings";
    }
    self.dtc = [[DefaultTipViewController alloc] init];
    self.dtc.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.ruc = [[RoundUpViewController alloc] init];
    self.ruc.edgesForExtendedLayout = UIRectEdgeNone;
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (int) getRoundUpLimit
{
    return [self.ruc getDefaultRoundUpValue];
}

- (int) getDefaultTipIndex
{
    return [self.dtc getDefaultTipIndex];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    tableData = [NSArray arrayWithObjects:@"Default Tip Amount", @"Round Up", nil];
}
- (void) viewDidAppear:(BOOL)animated
{
    self.utc.detailTextLabel.text = [self getSettingDisplayValueForType:0];
    self.rtc.detailTextLabel.text = [self getSettingDisplayValueForType:1];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:self.dtc animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:self.ruc animated:YES];
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
//
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self getSettingDisplayValueForType:indexPath.row];
    [self setCellType:cell :indexPath.row];
    return cell;
}

- (NSString*) getSettingDisplayValueForType:(int) type
{
    NSString* returnValue = nil;
    switch (type) {
        case 0:
            returnValue = [NSString stringWithFormat:@"%2.0d%%", (int)[self.dtc getDefaultTipEnumValue]];
            
            break;
        case 1:
            returnValue = [NSString stringWithFormat:@"%@", [self.ruc getRoundUpDisplayValue]];
            break;
            
        default:
            break;
    }
    return returnValue;
}

-(void) setCellType:(UITableViewCell*) cell :(int) type
{
    switch (type) {
        case 0:
            self.utc = cell;
            break;
        case 1:
            self.rtc = cell;
            break;
            
        default:
            break;
    }
}
@end
