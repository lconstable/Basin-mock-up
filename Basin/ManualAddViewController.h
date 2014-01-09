//
//  ManualAddViewController.h
//  Basin
//
//  Created by Lucien Constable on 9/11/12.
//
//

#import <UIKit/UIKit.h>

@interface ManualAddViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *entryTable;
@property (strong, nonatomic) IBOutlet UITextView *entryTableTextView;

- (IBAction)doneButtonPressed:(id)sender;
-(void)popToMainController;
@end
