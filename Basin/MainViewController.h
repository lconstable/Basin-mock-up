//
//  MainViewController.h
//  Basin
//
//  Created by Luke Constable on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource ,UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) IBOutlet UISearchBar *mainSearchBar;
@property (strong, nonatomic) IBOutlet UIView *mainSearchView;

@property (nonatomic) BOOL selectSearchBar;

@end
