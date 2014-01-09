//
//  NotifierViewController.h
//  Basin
//
//  Created by Lucien Constable on 2/8/13.
//
//

#import <UIKit/UIKit.h>

@interface NotifierViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
	IBOutlet UITextField *eventText;
}

@property (nonatomic, retain) IBOutlet UITextField *eventText;

- (IBAction) scheduleAlert:(id) sender;

@end