//
//  InfoViewController.h
//  Basin
//
//  Created by Lucien Constable on 3/12/13.
//
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *infoTable;


@property (strong, nonatomic) IBOutlet UILabel *personalInformationLabel;
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *address1Label;
@property (strong, nonatomic) IBOutlet UILabel *address2Label;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UILabel *zipLabel;
@property (strong, nonatomic) IBOutlet UITextView *firstNameText;
@property (strong, nonatomic) IBOutlet UITextView *lastNameText;
@property (strong, nonatomic) IBOutlet UITextView *emailText;
@property (strong, nonatomic) IBOutlet UITextView *phoneText;
@property (strong, nonatomic) IBOutlet UITextView *address1Text;
@property (strong, nonatomic) IBOutlet UITextView *address2Text;
@property (strong, nonatomic) IBOutlet UITextView *cityText;
@property (strong, nonatomic) IBOutlet UITextView *stateText;
@property (strong, nonatomic) IBOutlet UITextView *zipText;

@end
