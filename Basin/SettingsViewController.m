//
//  SettingsViewController.m
//  Basin
//
//  Created by Luke Constable on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ChooseCardViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize lastSyncTime;

@synthesize settingsTitleLabel;
@synthesize settingsTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // get last sync
    [self syncNow];
    
    // set fonts
    settingsTitleLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:20.0];
    
    // add drop shadow to top
    CAGradientLayer *topGradient = [CAGradientLayer layer];
    [topGradient setFrame:CGRectMake(0, 0, 320, 4)];
    topGradient.colors = [NSArray arrayWithObjects:
                          (id)[[[UIColor darkGrayColor] colorWithAlphaComponent:0.6f] CGColor],
                          (id)[[[UIColor grayColor] colorWithAlphaComponent:0.3f] CGColor],
                          (id)[[[UIColor grayColor] colorWithAlphaComponent:0.1f] CGColor],
                          (id)[[UIColor clearColor] CGColor],
                          nil];
    [self.view.layer addSublayer:topGradient];
    
}

- (void)viewDidUnload
{
    [self setLastSyncTime:nil];
    
    [self setSettingsTitleLabel:nil];
    [self setSettingsTable:nil];
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)syncNow
{
    // get current date (for functional app, get last synced date)
    NSDate *currentDate = [NSDate date];
    
    // set date format
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"M/d/yy h:mm:ss a"];
    
    NSString *dateString = [dateFormatter stringFromDate:currentDate];

    lastSyncTime = dateString;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2 | section == 3)
    {
        return 2;
    }
    else
        return 1;    
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = nil;
    
    if (section == 0) {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
        [headerView setBackgroundColor:[UIColor clearColor]];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, tableView.bounds.size.width - 10, 15)];
        NSString *lastSyncLabel = @"Last Sync: ";
        lastSyncLabel = [lastSyncLabel stringByAppendingString:lastSyncTime];
        label.text = lastSyncLabel;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont fontWithName:@"ProximaNova-Regular" size:12];
        label.backgroundColor = [UIColor clearColor];
        [headerView addSubview:label];
    }
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *SettingsCellIdentifier = @"settingsCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingsCellIdentifier];
        
        UILabel *settingsLabel  = (UILabel *)[cell viewWithTag:1];
        
        settingsLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:14];
        
        if (indexPath.section == 0) {
            settingsLabel.text = @"Sync Now";
        } else if (indexPath.section == 1) {
            settingsLabel.text = @"Select Credit Card to Display";
        } else if (indexPath.section == 2) {
            NSMutableArray *settingsLabelArray = [[NSMutableArray alloc] initWithObjects: @"Linked Bank Accounts", @"Account Information", nil];
            settingsLabel.text  = [settingsLabelArray objectAtIndex:indexPath.row];
        } else if (indexPath.section == 3) {
            NSMutableArray *settingsLabelArray = [[NSMutableArray alloc] initWithObjects:@"Other Settings", @"Legal Information", nil];
            settingsLabel.text  = [settingsLabelArray objectAtIndex:indexPath.row];
        } else if (indexPath.section == 4) {
            settingsLabel.text = @"Unlink iPhone from PayPort";
            settingsLabel.textColor = [UIColor whiteColor];
            
            cell.backgroundColor = [UIColor colorWithPatternImage:
                                    [UIImage imageNamed:@"buttonUnlink.png"]];
        }
        
        return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self syncNow];
        [settingsTable reloadData];
    }
    
    if (indexPath.section == 1) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        ChooseCardViewController *destVC = [storyboard instantiateViewControllerWithIdentifier:@"ChooseCardViewController"];
        
        [self.navigationController pushViewController:destVC animated:YES ];

    }
    
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            UIActionSheet *accountSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                      delegate:self
                                                             cancelButtonTitle:@"Cancel"
                                                        destructiveButtonTitle:nil
                                                             otherButtonTitles:
                                                            @"Add Account", @"Remove Account",
                                                            @"Edit Account", nil];
            [accountSheet showFromTabBar:self.tabBarController.tabBar];
            
        } else if (indexPath.row == 1) {

            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"InfoViewController"];
            [self.navigationController pushViewController:viewController animated:YES];
            
        }
    }
    
    if (indexPath.section == 3) {
        
        if (indexPath.row == 0) {
            // other settings
#warning changed for Notifier View Controller
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
            
            UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"NotifierViewController"];
            
            [self.navigationController pushViewController:viewController animated:YES];
        
            
        } else if (indexPath.row == 1) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Legal Information"
                                                            message:@"	Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Back"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
    }
    
    if (indexPath.section == 4) {
        
        if (indexPath.row == 0) {
            UIActionSheet *unlinkSheet = [[UIActionSheet alloc] initWithTitle:@"This will end the electronic organization of your purchases on your iPhone. Are you sure?"
                                                                     delegate:self
                                                            cancelButtonTitle:@"Cancel"
                                                       destructiveButtonTitle:@"Unlink iPhone"
                                                            otherButtonTitles:nil];
            
            [unlinkSheet showFromTabBar:self.tabBarController.tabBar];
        }
    }
}


@end
