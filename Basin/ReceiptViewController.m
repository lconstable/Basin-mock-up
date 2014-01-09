//
//  ReceiptViewController.m
//  Basin
//
//  Created by Luke Constable on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReceiptViewController.h"
#import "ItemViewController.h"
#import "MapViewController.h"
#import "WebViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ReceiptViewController ()
@property (strong, nonatomic) NSMutableArray *mainSearchReceipts; // "searchReceipts" array taken from main view
@property (copy, nonatomic) NSDictionary *selection; // passed in from main view in "prepareForSegue" method
@end

@implementation ReceiptViewController : UIViewController

@synthesize itemDescriptions;
@synthesize itemImages;
@synthesize itemNames;
@synthesize itemPrices;
@synthesize itemReorderURLs;
@synthesize itemUserManualURLs;

@synthesize mainSearchReceipts; 
@synthesize selection;

@synthesize storeAddressText;
@synthesize storePhoneNumberText;
@synthesize storeNameText;
@synthesize returnUrlText;
@synthesize itemNamesText;

@synthesize selectedItemDescription;
@synthesize selectedItemImageText;
@synthesize selectedItemName;
@synthesize selectedItemPrice;
@synthesize selectedItemReorderUrl;
@synthesize selectedStoreYelpString;
@synthesize selectedItemAuthorizationNumber;
@synthesize selectedItemCreditCard;
@synthesize selectedItemPurchaseDate;
@synthesize selectedItemSequenceNumber;
@synthesize selectedItemTimeStamp;
@synthesize selectedStoreTwitterHandle;
@synthesize selectedItemUserManualUrl;
@synthesize selectedItemSimilarItemImages;
@synthesize selectedItemSimilarItemURLs;
@synthesize addAnnotation;
@synthesize likeDict;

@synthesize fbLikeButton;
@synthesize footerView;
@synthesize loyaltyButton;
@synthesize itemTable;
@synthesize storeNameImage;
@synthesize storeAddressButton;
@synthesize storePhoneNumberButton;
@synthesize actionButton;
@synthesize numberOfItemsLabel;
@synthesize purchaseDateLabel;
@synthesize subtotalTextLabel;
@synthesize subtotalLabel;
@synthesize taxTextLabel;
@synthesize taxLabel;
@synthesize loyaltyTotalTextLabel;
@synthesize loyaltyTotalLabel;
@synthesize totalTextLabel;
@synthesize totalLabel;
@synthesize creditCardImageView;


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // after passed from main view, taking selected index path from selected cell, recreating main view's "searchReceipts" array to load correct data
    NSIndexPath *selectedIndexPath = [selection objectForKey:@"indexPath"];
    NSDictionary *rowData = [mainSearchReceipts objectAtIndex:selectedIndexPath.row];
    
    // loading selected item and store arrays
    itemDescriptions = [rowData objectForKey:@"itemDescriptions"];
    itemNames  = [rowData objectForKey:@"itemNames"];
    itemPrices = [rowData objectForKey:@"itemPrices"];
    itemImages = [rowData objectForKey:@"itemImages"];
    itemReorderURLs = [rowData objectForKey:@"itemReorderURLs"];
    itemUserManualURLs = [rowData objectForKey:@"itemUserManualURLs"];
    selectedStoreYelpString = [rowData objectForKey:@"yelpString"];
    selectedItemAuthorizationNumber = [rowData objectForKey:@"authorizationNumber"];
    selectedItemCreditCard = [rowData objectForKey:@"creditCard"];
    selectedItemPurchaseDate = [rowData objectForKey:@"purchaseDate"];
    selectedItemSequenceNumber = [rowData objectForKey:@"sequenceNumber"];
    selectedItemTimeStamp = [rowData objectForKey:@"timeStamp"];
    selectedStoreTwitterHandle = [rowData objectForKey:@"twitterHandle"];
    // for last 2, in functional app, associate by items, not transactions
    selectedItemSimilarItemImages = [rowData objectForKey:@"itemSimilarItemImages"];
    selectedItemSimilarItemURLs = [rowData objectForKey:@"itemSimilarItemURLs"];
    
    // setting labels and images from plist
    storeNameImage.image    = [UIImage imageNamed:[rowData objectForKey:@"storeNameLogo"]];
    purchaseDateLabel.text  = [rowData objectForKey:@"purchaseDate"];
    subtotalLabel.text      = [rowData objectForKey:@"subtotal"];
    taxLabel.text           = [rowData objectForKey:@"tax"];
    totalLabel.text         = [rowData objectForKey:@"total"];
    NSString *totalString = [totalLabel.text substringFromIndex:1];
    float totalNum = [totalString floatValue];
    float loyaltyNum = totalNum*0.9;
    NSString *loyaltyString = [NSString stringWithFormat:@"%.02f", loyaltyNum];
    loyaltyTotalLabel.text = [@"$" stringByAppendingString:loyaltyString];
    
    NSString *creditCard = [rowData objectForKey:@"creditCard"];
    if ([creditCard rangeOfString:@"Amex"].location != NSNotFound) {
        creditCardImageView.image = [UIImage imageNamed:@"cardAmex.png"];
    } else if ([creditCard rangeOfString:@"MC"].location != NSNotFound) {
        creditCardImageView.image = [UIImage imageNamed:@"cardMastercard.png"];
    } else if ([creditCard rangeOfString:@"Visa"].location != NSNotFound) {
        creditCardImageView.image = [UIImage imageNamed:@"cardVisa.png"];
    }
    
    // set button text
    storeAddressText     = [rowData objectForKey:@"storeAddress"];
    storePhoneNumberText = [rowData objectForKey:@"storePhoneNumber"];
    
    int numberOfObjects = [itemNames count];
    NSString *numberString = [NSString stringWithFormat:@"%i", numberOfObjects];
    if (numberOfObjects > 1) {
        numberOfItemsLabel.text = [numberString stringByAppendingString:@" Items:"];
    } else {
        numberOfItemsLabel.text = [numberString stringByAppendingString:@" Item:"];
    }
    
    // set font and text color
    loyaltyButton.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    numberOfItemsLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:17];
    purchaseDateLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    subtotalTextLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    subtotalLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    taxTextLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    taxLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    loyaltyTotalTextLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14];
    loyaltyTotalLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14];
    totalTextLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:17];
    totalLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:17];
            
    // change for split bill
    BOOL isSplit = [[rowData objectForKey:@"isSplit"] boolValue];
    if (isSplit == YES) {
        subtotalTextLabel.text = @"Split Bill:";
        subtotalTextLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:14];
        subtotalLabel.text = @"";
        
        taxTextLabel.text = @"Total:";
        taxLabel.text = [rowData objectForKey:@"splitBillTotal"];
        
        totalTextLabel.text = @"Your Total:";
        totalTextLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:17];
    }
        
    // set buttons
    storePhoneNumberButton.layer.borderColor = [UIColor blackColor].CGColor;
    storePhoneNumberButton.layer.borderWidth = 1.0;
    storeAddressButton.layer.borderColor = [UIColor blackColor].CGColor;
    storeAddressButton.layer.borderWidth = 1.0;
    actionButton.layer.borderColor = [UIColor blackColor].CGColor;
    actionButton.layer.borderWidth = 1.0;
    
    storeAddressButton.layer.cornerRadius = storeAddressButton.frame.size.width/2;
    storeAddressButton.layer.masksToBounds = YES;
    storePhoneNumberButton.layer.cornerRadius = storePhoneNumberButton.frame.size.width/2;
    storePhoneNumberButton.layer.masksToBounds = YES;
    actionButton.layer.cornerRadius = actionButton.frame.size.width/2;
    actionButton.layer.masksToBounds = YES;
    
    // set facebook like button
    likeDict = [[NSMutableDictionary alloc] init];
    [likeDict setValue:[NSNumber numberWithBool:NO] forKey:@"liked"];
    
    // to pass via segue
    storeNameText = [rowData objectForKey:@"storeName"];
    returnUrlText = [rowData objectForKey:@"returnPolicyUrl"];
    
    // for email message, set itemNamesText
    itemNamesText = [[itemNames valueForKey:@"description"] componentsJoinedByString:@", "];
    
    // set table view and scroll view
    if ([itemNames count] < 3) {
        
        [self.itemTable setScrollEnabled:NO];
        [self.itemTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
    } else if ([itemNames count] > 2) {
                
        CGFloat itemMinY = CGRectGetMinY(itemTable.frame);
        CGFloat footerMinY = CGRectGetMinY(footerView.frame);
        UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, itemMinY, self.view.bounds.size.width, 1)];
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, footerMinY - 1, self.view.bounds.size.width, 1)];
        topLineView.backgroundColor = [UIColor blackColor];
        bottomLineView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:topLineView];
        [self.view addSubview:bottomLineView];
    }
    
    // set drop shadow
    CAGradientLayer *topGradient = [CAGradientLayer layer];
    [topGradient setFrame:CGRectMake(0, 0, 320, 4)];
    topGradient.colors = [NSArray arrayWithObjects:
                                (id)[[[UIColor darkGrayColor] colorWithAlphaComponent:0.6f] CGColor],
                                (id)[[[UIColor grayColor] colorWithAlphaComponent:0.3f] CGColor],
                                (id)[[[UIColor grayColor] colorWithAlphaComponent:0.1f] CGColor],
                                (id)[[UIColor clearColor] CGColor],
                                nil];
    [self.view.layer addSublayer:topGradient];

//  receipt border
//    self.view.layer.borderWidth = 5.0;
//    self.view.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backLilly.png"]].CGColor;

        
}

- (void)viewDidUnload {
    [self setItemDescriptions:nil];
    [self setItemNames:nil];
    [self setItemPrices:nil];
    [self setItemImages:nil];
    [self setItemReorderURLs:nil];
    [self setItemUserManualURLs:nil];
    
    [self setMainSearchReceipts:nil];
    [self setSelection:nil];
    
    [self setStoreAddressText:nil];
    [self setStorePhoneNumberText:nil];
    [self setStoreNameText:nil];
    [self setReturnUrlText:nil];
    [self setItemNamesText:nil];
    
    [self setSelectedItemDescription:nil];
    [self setSelectedItemImageText:nil];
    [self setSelectedItemName:nil];
    [self setSelectedItemPrice:nil];
    [self setSelectedItemReorderUrl:nil];
    [self setSelectedStoreYelpString:nil];
    [self setSelectedItemAuthorizationNumber:nil];
    [self setSelectedItemCreditCard:nil];
    [self setSelectedItemPurchaseDate:nil];
    [self setSelectedItemSequenceNumber:nil];
    [self setSelectedItemTimeStamp:nil];
    [self setSelectedStoreTwitterHandle:nil];
    [self setSelectedItemUserManualUrl:nil];
    [self setSelectedItemSimilarItemImages:nil];
    [self setSelectedItemSimilarItemURLs:nil];
    [self setAddAnnotation:nil];
    
    [self setFooterView:nil];
    [self setItemTable:nil];
    [self setStoreNameImage:nil];
    [self setStoreAddressButton:nil];
    [self setStorePhoneNumberButton:nil];
    [self setActionButton:nil];
    [self setNumberOfItemsLabel:nil];
    [self setPurchaseDateLabel:nil];
    [self setSubtotalLabel:nil];
    [self setSubtotalTextLabel:nil];
    [self setTaxLabel:nil];
    [self setTaxTextLabel:nil];
    [self setTotalLabel:nil];
    [self setTotalTextLabel:nil];
    [self setCreditCardImageView:nil];
    
    [self setLoyaltyButton:nil];
    [self setLoyaltyTotalTextLabel:nil];
    [self setLoyaltyTotalLabel:nil];
    [self setFbLikeButton:nil];
    [super viewDidUnload];
}

#pragma mark - Button methods
- (IBAction)phonePressed:(id)sender
{
    NSString *cleanedStorePhoneNumberText = [[storePhoneNumberText stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]]
                                             stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", cleanedStorePhoneNumberText]]];
}

- (IBAction)actionPressed:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Add note", @"Review on Yelp", @"Gift receipt to a friend", @"Report fraud",
                                                                nil];
    actionSheet.destructiveButtonIndex = 3;
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (IBAction)likePressed:(id)sender
{
	BOOL liked = [[likeDict objectForKey:@"liked"] boolValue];
    
    if (!liked) {
        
        // unliked to liked
        [likeDict setObject:[NSNumber numberWithBool:!liked] forKey:@"liked"];
        
        UIImage *newImage = (liked) ? [UIImage imageNamed:@"unliked"] : [UIImage imageNamed:@"liked"];
        [fbLikeButton setImage:newImage forState:UIControlStateNormal];
        
    } else if (liked) {
        
        // liked to unliked -- uiactionsheet
        UIActionSheet *unlinkSheet = [[UIActionSheet alloc] initWithTitle:@"If you unlink from this retailer, you will miss out events, sales, and calendar syncing features. Are you sure?"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:@"Unlink from retailer"
                                                        otherButtonTitles:nil];
        
        [unlinkSheet showFromTabBar:self.tabBarController.tabBar];
        
    }
}

#pragma mark UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // liked to unliked
        BOOL liked = [[likeDict objectForKey:@"liked"] boolValue];
        
        [likeDict setObject:[NSNumber numberWithBool:!liked] forKey:@"liked"];
        
        UIImage *newImage = (liked) ? [UIImage imageNamed:@"unliked"] : [UIImage imageNamed:@"liked"];
        [fbLikeButton setImage:newImage forState:UIControlStateNormal];
    }
}



#pragma mark Table view
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [itemNames count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *receiptCellIdentifier = @"itemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:receiptCellIdentifier];
    
    UILabel *itemNameLabel  = (UILabel *)[cell viewWithTag:1];
    UILabel *itemPriceLabel = (UILabel *)[cell viewWithTag:2];
    UIImageView *itemImageView = (UIImageView *)[cell viewWithTag:3];
    
    // set fonts and colors
    itemNameLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17];
    itemPriceLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17];
      
    itemNameLabel.text  = [itemNames objectAtIndex:indexPath.row];
    itemNameLabel.backgroundColor = [UIColor clearColor];
    itemPriceLabel.text = [itemPrices objectAtIndex:indexPath.row];
    itemPriceLabel.backgroundColor = [UIColor clearColor];

    itemImageView.image = [UIImage imageNamed:[itemImages objectAtIndex:indexPath.row]];
        
    // transparent cells
    cell.backgroundColor = [UIColor clearColor];
            
    return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedItemDescription = [itemDescriptions objectAtIndex:indexPath.row];
    selectedItemImageText = [itemImages objectAtIndex:indexPath.row];
    selectedItemName  = [itemNames objectAtIndex:indexPath.row];
    selectedItemPrice = [itemPrices objectAtIndex:indexPath.row];
    selectedItemReorderUrl = [itemReorderURLs objectAtIndex:indexPath.row];
    selectedItemUserManualUrl = [itemUserManualURLs objectAtIndex:indexPath.row];
    
    return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Segue related

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // prepare information for item view
    if ([segue.identifier isEqualToString:@"receiptToItem"]) {
        ItemViewController *destViewController = segue.destinationViewController;
        destViewController.selectedItemDescription = selectedItemDescription;
        destViewController.selectedItemImageText = selectedItemImageText;
        destViewController.selectedItemName = selectedItemName;
        destViewController.selectedItemPrice = selectedItemPrice;
        destViewController.selectedItemReorderUrl = selectedItemReorderUrl;
        destViewController.selectedItemUserManualUrl = selectedItemUserManualUrl;
        destViewController.selectedStoreName = storeNameText;
        destViewController.selectedItemAuthorizationNumber = selectedItemAuthorizationNumber;
        destViewController.selectedItemCreditCard = selectedItemCreditCard;
        destViewController.selectedItemPurchaseDate = selectedItemPurchaseDate;
        destViewController.selectedItemSequenceNumber = selectedItemSequenceNumber;
        destViewController.selectedItemTimeStamp = selectedItemTimeStamp;
        destViewController.selectedStoreTwitterHandle = selectedStoreTwitterHandle;
        destViewController.selectedItemSimilarItemImages = selectedItemSimilarItemImages;
        destViewController.selectedItemSimilarItemURLs = selectedItemSimilarItemURLs;
        destViewController.selectedStoreReturnUrlText      = returnUrlText;
    }
    // prepare information for map view
    else if ([segue.identifier isEqualToString:@"receiptToMap"]) {
        MapViewController *destViewController  = segue.destinationViewController;
        destViewController.storeAddressText  = storeAddressText;
        destViewController.storeNameText       = storeNameText;        
    } 
}

@end