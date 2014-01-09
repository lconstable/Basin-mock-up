//
//  NotifierViewController.m
//  Basin
//
//  Created by Lucien Constable on 2/8/13.
//
//

#import "NotifierViewController.h"

@interface NotifierViewController ()

@end

@implementation NotifierViewController

@synthesize eventText;

- (void)viewWillAppear:(BOOL)animated
{
    [eventText becomeFirstResponder];
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction) scheduleAlert:(id)sender
{

    NSDate *itemDate = [[NSDate date] dateByAddingTimeInterval:10];
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    localNotif.fireDate = itemDate;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    localNotif.alertBody = [eventText text];
    localNotif.alertAction = @"View";
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
    
	// Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end