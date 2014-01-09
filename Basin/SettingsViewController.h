//
//  SettingsViewController.h
//  Basin
//
//  Created by Luke Constable on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) NSString *lastSyncTime;

@property (strong, nonatomic) IBOutlet UILabel *settingsTitleLabel;
@property (strong, nonatomic) IBOutlet UITableView *settingsTable;

-(void)syncNow;

@end
