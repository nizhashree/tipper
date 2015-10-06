//
//  SettingsViewController.h
//  TipCalculatorFinal
//
//  Created by Nizha Shree Seenivasan on 9/28/15.
//  Copyright (c) 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
- (int) getDefaultTipIndex;
- (int) getRoundUpLimit;
@end
