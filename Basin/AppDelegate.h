//
//  AppDelegate.h
//  Basin
//
//  Created by Luke Constable on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate> {
    NSString *selectedCard;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) NSString *selectedCard; // from card picker view to main view

@end
