//
//  ReturnViewController.h
//  Basin
//
//  Created by Lucien Constable on 11/4/12.
//
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"

@interface ReturnViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *selectedItemImageText;
@property (strong, nonatomic) NSString *selectedItemName;
@property (strong, nonatomic) NSString *selectedItemPrice;
@property (strong, nonatomic) NSString *selectedStoreName;
@property (strong, nonatomic) NSString *selectedItemAuthorizationNumber;
@property (strong, nonatomic) NSString *selectedItemCreditCard;
@property (strong, nonatomic) NSString *selectedItemPurchaseDate;
@property (strong, nonatomic) NSString *selectedItemSequenceNumber;
@property (strong, nonatomic) NSString *selectedItemTimeStamp;
@property (strong, nonatomic) NSString *selectedStoreReturnUrlText;

@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *cardLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorizationTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorizationLabel;
@property (strong, nonatomic) IBOutlet UILabel *sequenceTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *sequenceLabel;
@property (strong, nonatomic) IBOutlet UIImageView *barCodeImage;
@property (strong, nonatomic) IBOutlet UILabel *returnDateLabel;
@property (strong, nonatomic) IBOutlet UIButton *returnPolicyButton;

- (IBAction)returnPolicyPressed:(id)sender;


@end
