//
//  AppDelegate.m
//  Basin
//
//  Created by Luke Constable on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
//#import "MFSideMenu.h"
//#import "SideMenuViewController.h"

@implementation AppDelegate

@synthesize window = _window;

@synthesize selectedCard;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor blackColor], UITextAttributeTextColor,
      [UIColor clearColor], UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)], UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"ProximaNova-Bold" size:0.0], UITextAttributeFont,
      nil]];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBar"]
                                       forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBar"]
                                       forBarMetrics:UIBarMetricsLandscapePhone];
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:210 green:215 blue:215 alpha:1]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor blackColor], UITextAttributeTextColor,
      [UIColor clearColor], UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"ProximaNova-Bold" size:12.0], UITextAttributeFont,
      nil]
                                                forState:UIControlStateNormal];

    // Assign tab bar item with titles
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    tabBarController.delegate = self;
    UITabBar *tabBar = tabBarController.tabBar;
    
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
    
    tabBarItem1.title = @"My Retailers";
    tabBarItem2.title = @"Receipts";
    tabBarItem3.title = @"What's New";
    tabBarItem4.title = @"Calendar";
    tabBarItem5.title = @"Settings";
    
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"buttonPressedRetailer"] withFinishedUnselectedImage:[UIImage imageNamed:@"buttonUnpressedRetailer"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"buttonPressedReceipt"] withFinishedUnselectedImage:[UIImage imageNamed:@"buttonUnpressedReceipt"]];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"buttonPressedExplore"] withFinishedUnselectedImage:[UIImage imageNamed:@"buttonUnpressedExplore"]];
    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"buttonPressedCalendar"] withFinishedUnselectedImage:[UIImage imageNamed:@"buttonUnpressedCalendar"]];
    [tabBarItem5 setFinishedSelectedImage:[UIImage imageNamed:@"buttonPressedProfile"] withFinishedUnselectedImage:[UIImage imageNamed:@"buttonUnpressedProfile"]];
    
    UIImage *tabBarBackground = [[UIImage imageNamed:@"tabBar"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 0, 1, 0)];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabBar"]];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor blackColor], UITextAttributeTextColor,
                                                       nil] forState:UIControlStateSelected];
    
    
    [tabBarController setSelectedIndex:2];
    
    
//    // side menu
//    [self.window makeKeyAndVisible];
//    UIViewController *rootController = [self.window rootViewController];
//    UINavigationController *navController = (UINavigationController *)rootController;
//    SideMenuViewController *sideMenuController = [[rootController storyboard] instantiateViewControllerWithIdentifier:@"SideMenuViewController"];
//    
//    MFSideMenuOptions options = MFSideMenuOptionMenuButtonEnabled|MFSideMenuOptionShadowEnabled;
//    MFSideMenuPanMode panMode = MFSideMenuPanModeNavigationBar|MFSideMenuPanModeNavigationController;
//    
//    MFSideMenu *sideMenu = [MFSideMenu menuWithNavigationController:navController
//                                                 sideMenuController:sideMenuController
//                                                           location:MFSideMenuLocationLeft
//                                                            options:options
//                                                            panMode:panMode];
//    
//    sideMenuController.sideMenu = sideMenu;
    
    // notifications
    application.applicationIconBadgeNumber = 0;
    
    UILocalNotification *localNotif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
        NSLog(@"Recieved Notification %@",localNotif);
    }
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    UINavigationController *navController = (UINavigationController *)viewController;
    if ([[navController.viewControllers objectAtIndex:0] isMemberOfClass:[MainViewController class]]) {
        [[navController.viewControllers objectAtIndex:0] viewWillAppear:YES];
    }
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    // Handle the notificaton when the app is running
    NSLog(@"Recieved Notification %@",notif);
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
