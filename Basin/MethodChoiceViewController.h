//
//  MethodChoiceViewController.h
//  Basin
//
//  Created by Lucien Constable on 10/3/12.
//
//

#import <UIKit/UIKit.h>

@interface MethodChoiceViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *methodTable;
@end
