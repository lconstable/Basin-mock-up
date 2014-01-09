//
//  MyRetailerViewController.h
//  PayPort
//
//  Created by Lucien Constable on 5/29/13.
//
//

#import <UIKit/UIKit.h>

@interface MyRetailerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UITableView *retailerTable;

@property (strong, nonatomic) NSMutableArray *likeArray;

@property (strong, nonatomic) NSIndexPath *selectedIndexPath;


@end
