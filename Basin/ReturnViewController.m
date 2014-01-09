//
//  ReturnViewController.m
//  Basin
//
//  Created by Lucien Constable on 11/4/12.
//
//

#import "ReturnViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ReturnViewController ()

@end

@implementation ReturnViewController

@synthesize selectedItemImageText;
@synthesize selectedItemName;
@synthesize selectedItemPrice;
@synthesize selectedStoreName;
@synthesize selectedItemAuthorizationNumber;
@synthesize selectedItemCreditCard;
@synthesize selectedItemPurchaseDate;
@synthesize selectedItemSequenceNumber;
@synthesize selectedItemTimeStamp;
@synthesize selectedStoreReturnUrlText;

@synthesize itemImageView;
@synthesize itemNameLabel;
@synthesize itemPriceLabel;
@synthesize cardLabel;
@synthesize timeStampLabel;
@synthesize authorizationTitleLabel;
@synthesize authorizationLabel;
@synthesize sequenceTitleLabel;
@synthesize sequenceLabel;
@synthesize barCodeImage;
@synthesize returnDateLabel;
@synthesize returnPolicyButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // passed via segue
    NSString *dateText = [selectedItemPurchaseDate stringByAppendingString:@" "];
    NSString *timeText = [dateText stringByAppendingString:selectedItemTimeStamp];
    
    itemImageView.image = [UIImage imageNamed:selectedItemImageText];
    itemNameLabel.text = selectedItemName;
    itemPriceLabel.text = selectedItemPrice;
    cardLabel.text = selectedItemCreditCard;
    timeStampLabel.text = timeText;
    authorizationLabel.text = selectedItemAuthorizationNumber;
    sequenceLabel.text = selectedItemSequenceNumber;
    barCodeImage.image = [UIImage imageNamed:@"barCode.png"];
    
    itemNameLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17];
    itemPriceLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17];
    cardLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:17];
    timeStampLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17];
    authorizationTitleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17];
    authorizationLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17];
    sequenceTitleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17];
    sequenceLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17];
    returnDateLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    returnPolicyButton.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:17];

    // add 90 days to date for return date label
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *purchaseDate = [dateFormatter dateFromString:selectedItemPurchaseDate];
    int daysToAdd = 90;     // this should vary based on actual store policy
    NSDate *returnDate = [purchaseDate dateByAddingTimeInterval:60*60*24*daysToAdd];
    NSString *returnDateText = [dateFormatter stringFromDate:returnDate];
    returnDateLabel.text = [NSString stringWithFormat:@"Return within 90 days (by %@).", returnDateText];
    
    // add drop shadow to top
    CAGradientLayer *topGradient = [CAGradientLayer layer];
    [topGradient setFrame:CGRectMake(0, 0, 320, 4)];
    topGradient.colors = [NSArray arrayWithObjects:
                          (id)[[[UIColor darkGrayColor] colorWithAlphaComponent:0.6f] CGColor],
                          (id)[[[UIColor grayColor] colorWithAlphaComponent:0.3f] CGColor],
                          (id)[[[UIColor grayColor] colorWithAlphaComponent:0.1f] CGColor],
                          (id)[[UIColor clearColor] CGColor],
                          nil];
    [self.view.layer addSublayer:topGradient];
    
    // set the navigationItem's titleView
    self.navigationItem.title = @"Return Item";
}

- (IBAction)returnPolicyPressed:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    WebViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    viewController.urlText = selectedStoreReturnUrlText;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSelectedItemImageText:nil];
    [self setSelectedItemName:nil];
    [self setSelectedItemPrice:nil];
    [self setSelectedStoreName:nil];
    [self setSelectedItemAuthorizationNumber:nil];
    [self setSelectedItemCreditCard:nil];
    [self setSelectedItemPurchaseDate:nil];
    [self setSelectedItemSequenceNumber:nil];
    [self setSelectedItemTimeStamp:nil];
    
    [self setItemImageView:nil];
    [self setItemNameLabel:nil];
    [self setItemPriceLabel:nil];
    [self setCardLabel:nil];
    [self setTimeStampLabel:nil];
    [self setAuthorizationLabel:nil];
    [self setSequenceLabel:nil];
    [self setAuthorizationTitleLabel:nil];
    [self setSequenceTitleLabel:nil];
    [self setBarCodeImage:nil];
    [self setReturnDateLabel:nil];
    [self setReturnPolicyButton:nil];
    [super viewDidUnload];
}
@end
