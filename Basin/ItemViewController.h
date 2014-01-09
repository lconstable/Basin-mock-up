//
//  ItemViewController.h
//  Basin
//
//  Created by Lucien Constable on 10/30/12.
//
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface ItemViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) SLComposeViewController *mySLComposerSheet;
@property (strong, nonatomic) NSString *selectedItemDescription;
@property (strong, nonatomic) NSString *selectedItemImageText;
@property (strong, nonatomic) NSString *selectedItemName;
@property (strong, nonatomic) NSString *selectedItemPrice;
@property (strong, nonatomic) NSString *selectedItemReorderUrl;
@property (strong, nonatomic) NSString *selectedItemUserManualUrl;
@property (strong, nonatomic) NSString *selectedStoreName;
@property (strong, nonatomic) NSString *selectedItemAuthorizationNumber;
@property (strong, nonatomic) NSString *selectedItemCreditCard;
@property (strong, nonatomic) NSString *selectedItemPurchaseDate;
@property (strong, nonatomic) NSString *selectedItemSequenceNumber;
@property (strong, nonatomic) NSString *selectedItemTimeStamp;
@property (strong, nonatomic) NSString *selectedStoreTwitterHandle;
@property (strong, nonatomic) NSMutableArray *selectedItemSimilarItemImages;
@property (strong, nonatomic) NSMutableArray *selectedItemSimilarItemURLs;
@property (strong, nonatomic) NSString *selectedStoreReturnUrlText;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *reorderButton;
@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemDescriptionLabel;
@property (strong, nonatomic) IBOutlet UITableView *actionTable;
@property (strong, nonatomic) IBOutlet UIView *similarItemView;
@property (strong, nonatomic) IBOutlet UILabel *similarItemLabel;
@property (strong, nonatomic) IBOutlet UIButton *leftSimilarItemButton;
@property (strong, nonatomic) IBOutlet UIButton *centerSimilarItemButton;
@property (strong, nonatomic) IBOutlet UIButton *rightSimilarItemButton;

- (IBAction)reorderPressed:(id)sender;
- (IBAction)twPressed:(id)sender;
- (IBAction)fbPressed:(id)sender;
- (IBAction)pinPressed:(id)sender;
- (IBAction)textPressed:(id)sender;
- (IBAction)emailPressed:(id)sender;



@end
