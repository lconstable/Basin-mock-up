//
//  ReceiptViewController.h
//  Basin
//
//  Created by Luke Constable on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressAnnotation.h"

@interface ReceiptViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) NSMutableArray *itemDescriptions;
@property (strong, nonatomic) NSMutableArray *itemImages;
@property (strong, nonatomic) NSMutableArray *itemNames;
@property (strong, nonatomic) NSMutableArray *itemPrices;
@property (strong, nonatomic) NSMutableArray *itemReorderURLs;
@property (strong, nonatomic) NSMutableArray *itemUserManualURLs;

@property (strong, nonatomic) NSString *storeAddressText;
@property (strong, nonatomic) NSString *storePhoneNumberText;
@property (strong, nonatomic) NSString *storeNameText;
@property (strong, nonatomic) NSString *returnUrlText;
@property (strong, nonatomic) NSString *itemNamesText;

@property (strong, nonatomic) NSString *selectedItemDescription;
@property (strong, nonatomic) NSString *selectedItemImageText;
@property (strong, nonatomic) NSString *selectedItemName;
@property (strong, nonatomic) NSString *selectedItemPrice;
@property (strong, nonatomic) NSString *selectedItemReorderUrl;
@property (strong, nonatomic) NSString *selectedStoreYelpString;
@property (strong, nonatomic) NSString *selectedItemAuthorizationNumber;
@property (strong, nonatomic) NSString *selectedItemCreditCard;
@property (strong, nonatomic) NSString *selectedItemPurchaseDate;
@property (strong, nonatomic) NSString *selectedItemSequenceNumber;
@property (strong, nonatomic) NSString *selectedItemTimeStamp;
@property (strong, nonatomic) NSString *selectedStoreTwitterHandle;
@property (strong, nonatomic) NSString *selectedItemUserManualUrl;
@property (strong, nonatomic) NSMutableArray *selectedItemSimilarItemImages;
@property (strong, nonatomic) NSMutableArray *selectedItemSimilarItemURLs;
@property AddressAnnotation *addAnnotation;
@property (strong, nonatomic) NSMutableDictionary *likeDict;

@property (strong, nonatomic) IBOutlet UIButton *fbLikeButton;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UIButton *loyaltyButton;
@property (strong, nonatomic) IBOutlet UITableView *itemTable;
@property (strong, nonatomic) IBOutlet UIImageView *storeNameImage;
@property (strong, nonatomic) IBOutlet UIButton *storePhoneNumberButton;
@property (strong, nonatomic) IBOutlet UIButton *storeAddressButton;
@property (strong, nonatomic) IBOutlet UIButton *actionButton;
@property (strong, nonatomic) IBOutlet UILabel *numberOfItemsLabel;
@property (strong, nonatomic) IBOutlet UILabel *purchaseDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *subtotalTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *subtotalLabel;
@property (strong, nonatomic) IBOutlet UILabel *taxTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *taxLabel;
@property (strong, nonatomic) IBOutlet UILabel *loyaltyTotalTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *loyaltyTotalLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;
@property (strong, nonatomic) IBOutlet UIImageView *creditCardImageView;


- (IBAction)likePressed:(id)sender;
- (IBAction)phonePressed:(id)sender;
- (IBAction)actionPressed:(id)sender;

@end
