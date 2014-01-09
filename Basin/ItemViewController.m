//
//  ItemViewController.m
//  Basin
//
//  Created by Lucien Constable on 10/30/12.
//
//

#import "ItemViewController.h"
#import "WebViewController.h"
#import "ReturnViewController.h"
#import "WebViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ItemViewController ()

@end

@implementation ItemViewController : UIViewController

@synthesize mySLComposerSheet;
@synthesize selectedItemDescription;
@synthesize selectedItemImageText;
@synthesize selectedItemName;
@synthesize selectedItemPrice;
@synthesize selectedItemReorderUrl;
@synthesize selectedItemUserManualUrl;
@synthesize selectedStoreName;
@synthesize selectedItemAuthorizationNumber;
@synthesize selectedItemCreditCard;
@synthesize selectedItemPurchaseDate;
@synthesize selectedItemSequenceNumber;
@synthesize selectedItemTimeStamp;
@synthesize selectedStoreTwitterHandle;
@synthesize selectedItemSimilarItemImages;
@synthesize selectedItemSimilarItemURLs;
@synthesize selectedStoreReturnUrlText;

@synthesize itemDescriptionLabel;
@synthesize reorderButton;
@synthesize itemImageView;
@synthesize itemNameLabel;
@synthesize itemPriceLabel;
@synthesize actionTable;
@synthesize similarItemView;
@synthesize similarItemLabel;
@synthesize leftSimilarItemButton;
@synthesize centerSimilarItemButton;
@synthesize rightSimilarItemButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [reorderButton setTintColor:[UIColor colorWithRed:40.0/256.0 green:90.0/256.0 blue:225.0/256.0 alpha:1.0]];
    [reorderButton setTitleTextAttributes:
                        [NSDictionary dictionaryWithObjectsAndKeys:
                         [UIColor whiteColor], UITextAttributeTextColor,
                         [UIColor clearColor], UITextAttributeTextShadowColor,
                         [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                         [UIFont fontWithName:@"ProximaNova-Bold" size:12.0], UITextAttributeFont,
                         nil]
     forState:UIControlStateNormal];
    
    UIView *tableTopBorder = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(actionTable.frame), 320, 1)];
    [tableTopBorder setBackgroundColor:[UIColor colorWithRed:224.0/256.0 green:224.0/256.0 blue:224.0/256.0 alpha:1.0]];
    [self.view addSubview:tableTopBorder];
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // passed via segue
    itemImageView.image = [UIImage imageNamed:selectedItemImageText];
    itemNameLabel.text = selectedItemName;
    itemPriceLabel.text = selectedItemPrice;
    itemDescriptionLabel.text = selectedItemDescription;
    similarItemLabel.text = @"People like you also love:";
    
    itemNameLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17];
    itemPriceLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17];
    itemDescriptionLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    similarItemLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14];
    
    [leftSimilarItemButton setBackgroundImage:[UIImage imageNamed:
                                                [selectedItemSimilarItemImages objectAtIndex:0]]
                                     forState:UIControlStateNormal];
    [centerSimilarItemButton setBackgroundImage:[UIImage imageNamed:
                                                [selectedItemSimilarItemImages objectAtIndex:1]]
                                     forState:UIControlStateNormal];
    [rightSimilarItemButton setBackgroundImage:[UIImage imageNamed:
                                                [selectedItemSimilarItemImages objectAtIndex:2]]
                                     forState:UIControlStateNormal];

    // hide 'similar items view' if showing user manual
    if (selectedItemUserManualUrl.length > 0) {
        [similarItemView setHidden:YES];
        CGRect newFrame = CGRectMake(actionTable.frame.origin.x, actionTable.frame.origin.y, actionTable.frame.size.width, actionTable.frame.size.height + 44);
        actionTable.frame = newFrame;
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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSelectedItemDescription:nil];
    [self setSelectedItemImageText:nil];
    [self setSelectedItemName:nil];
    [self setSelectedItemPrice:nil];
    [self setSelectedItemReorderUrl:nil];
    [self setSelectedItemUserManualUrl:nil];
    [self setSelectedStoreName:nil];
    [self setSelectedItemAuthorizationNumber:nil];
    [self setSelectedItemCreditCard:nil];
    [self setSelectedItemPurchaseDate:nil];
    [self setSelectedItemSequenceNumber:nil];
    [self setSelectedItemTimeStamp:nil];
    [self setSelectedStoreTwitterHandle:nil];
    [self setSelectedItemSimilarItemImages:nil];
    [self setSelectedItemSimilarItemURLs:nil];
    
    [self setItemDescriptionLabel:nil];
    [self setItemImageView:nil];
    [self setItemNameLabel:nil];
    [self setItemPriceLabel:nil];
    [self setActionTable:nil];
    [self setSimilarItemView:nil];
    [self setSimilarItemLabel:nil];    
    [self setLeftSimilarItemButton:nil];
    [self setCenterSimilarItemButton:nil];
    [self setRightSimilarItemButton:nil];
    [self setReorderButton:nil];
    [super viewDidUnload];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // prepare information for web view (return policy)
    if ([segue.identifier isEqualToString:@"itemToWeb1"]) {
        WebViewController *destViewController  = segue.destinationViewController;
        destViewController.urlText      = [selectedItemSimilarItemURLs objectAtIndex:0];
    }
    
    if ([segue.identifier isEqualToString:@"itemToWeb2"]) {
        WebViewController *destViewController  = segue.destinationViewController;
        destViewController.urlText      = [selectedItemSimilarItemURLs objectAtIndex:1];
    }
    
    if ([segue.identifier isEqualToString:@"itemToWeb3"]) {
        WebViewController *destViewController  = segue.destinationViewController;
        destViewController.urlText      = [selectedItemSimilarItemURLs objectAtIndex:2];
    }
}

- (IBAction)reorderPressed:(id)sender
{
    if ([selectedItemReorderUrl isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"No online order available. \nPlease order in store."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        WebViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
        viewController.urlText = selectedItemReorderUrl;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (IBAction)twPressed:(id)sender
{
    //twitter
    mySLComposerSheet = [[SLComposeViewController alloc] init];
    mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    NSString *tweet1 = @"I love the ";
    NSString *tweet2 = [tweet1 stringByAppendingString:selectedItemName];
    NSString *tweet3 = @" from ";
    NSString *tweet4 = [tweet3 stringByAppendingString:selectedStoreName];
    NSString *tweet5 = @". Check it out at ";
    NSString *tweet6 = selectedItemReorderUrl;
    NSString *tweet7 = [[[selectedStoreName stringByReplacingOccurrencesOfString:@"."
                                                                      withString:@""]
                         stringByReplacingOccurrencesOfString:@"'" withString:@""]
                        stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *tweet8 = [@" #Basin #" stringByAppendingString:tweet7];
    NSString *tweet9 = [tweet2 stringByAppendingString:tweet4];
    NSString *tweet10 = [tweet5 stringByAppendingString:tweet6];
    NSString *tweet11 = [tweet9 stringByAppendingString:tweet10];
    
    NSString *tweet = [tweet11 stringByAppendingString:tweet8];
    
    
    [mySLComposerSheet setInitialText:tweet];
    
    [self presentViewController:mySLComposerSheet animated:YES completion:nil];
}

- (IBAction)fbPressed:(id)sender
{
    // facebook
    mySLComposerSheet = [[SLComposeViewController alloc] init];
    mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    NSString *post1 = @"I love the ";
    NSString *post2 = [post1 stringByAppendingString:selectedItemName];
    NSString *post3 = @" from ";
    NSString *post4 = [post3 stringByAppendingString:selectedStoreName];
    NSString *post5 = @". Check it out at ";
    NSString *post6 = selectedItemReorderUrl;
    NSString *post7 = [post2 stringByAppendingString:post4];
    NSString *post8 = [post5 stringByAppendingString:post6];
    NSString *post9 = [post7 stringByAppendingString:post8];
    NSString *post10 = [post9 stringByAppendingString:@" #Basin #"];
    NSString *post11 = [[[selectedStoreName stringByReplacingOccurrencesOfString:@"."
                                                                      withString:@""]
                         stringByReplacingOccurrencesOfString:@"'" withString:@""]
                        stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *post = [post10 stringByAppendingString:post11];
    
    [mySLComposerSheet setInitialText:post];
    
    [self presentViewController:mySLComposerSheet animated:YES completion:nil];
}

- (IBAction)pinPressed:(id)sender {
}

- (IBAction)textPressed:(id)sender
{
    if ([MFMessageComposeViewController canSendText]) {
        NSString *post1 = @"I love the ";
        NSString *post2 = [post1 stringByAppendingString:selectedItemName];
        NSString *post3 = @" from ";
        NSString *post4 = [post3 stringByAppendingString:selectedStoreName];
        NSString *post5 = @". Check it out at ";
        NSString *post6 = selectedItemReorderUrl;
        NSString *post7 = [post2 stringByAppendingString:post4];
        NSString *post8 = [post5 stringByAppendingString:post6];
        NSString *textMessage = [post7 stringByAppendingString:post8];
        
        MFMessageComposeViewController *smsVC = [[MFMessageComposeViewController alloc] init];
        smsVC.messageComposeDelegate = self;
        [smsVC setBody:textMessage];
        
        [self presentViewController:smsVC animated:YES completion:NULL];

    }
    
}

- (IBAction)emailPressed:(id)sender
{
    if ([MFMailComposeViewController canSendMail]) {
        
        NSString *post1 = @"I love the ";
        NSString *post2 = [post1 stringByAppendingString:selectedItemName];
        NSString *post3 = @" from ";
        NSString *post4 = [post3 stringByAppendingString:selectedStoreName];
        NSString *post5 = @". Check it out at ";
        NSString *post6 = selectedItemReorderUrl;
        NSString *post7 = [post2 stringByAppendingString:post4];
        NSString *post8 = [post5 stringByAppendingString:post6];
        NSString *emailMessage = [post7 stringByAppendingString:post8];

        
        NSString *emailTitle = @"Check this out!";
        NSArray *emailRecipients = [NSArray arrayWithObject:@"lukeconstable@gmail.com"];
        
        // remove the custom nav bar font to avoid crash
        NSMutableDictionary *navBarTitleAttributes = [[UINavigationBar appearance] titleTextAttributes].mutableCopy;
        UIFont *navBarTitleFont = navBarTitleAttributes[UITextAttributeFont];
        navBarTitleAttributes[UITextAttributeFont] = [UIFont systemFontOfSize:navBarTitleFont.pointSize];
        [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleAttributes];
        
        MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
        mailVC.mailComposeDelegate = self;
        [mailVC setSubject:emailTitle];
        [mailVC setMessageBody:emailMessage isHTML:NO];
        [mailVC setToRecipients:emailRecipients];
        
        // reset custom nav bar font
        [self presentViewController:mailVC animated:YES completion:^{
            navBarTitleAttributes[UITextAttributeFont] = navBarTitleFont;
            [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleAttributes];
        }];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"SMS cancelled");
            break;
        case MessageComposeResultFailed:
            NSLog(@"SMS failed");
            break;
        case MessageComposeResultSent:
            NSLog(@"SMS sent");
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ActionCellIdentifier = @"actionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ActionCellIdentifier];
    
    UILabel *actionLabel  = (UILabel *)[cell viewWithTag:1];
    actionLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    
//    if (indexPath.row == 0) {
//        actionLabel.text = @"User Manual";
//    }
//    else if (indexPath.row == 1) {
        actionLabel.text = @"Return";
//    }
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

//    if (indexPath.row == 0) {
//        
//        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//        WebViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
//        viewController.urlText = selectedItemUserManualUrl;
//        [self.navigationController pushViewController:viewController animated:YES];
//        
//    } else if (indexPath.row == 1) {
    
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        ReturnViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ReturnViewController"];
        
        viewController.selectedItemImageText = selectedItemImageText;
        viewController.selectedItemName = selectedItemName;
        viewController.selectedItemPrice = selectedItemPrice;
        viewController.selectedStoreName = selectedStoreName;
        viewController.selectedItemAuthorizationNumber = selectedItemAuthorizationNumber;
        viewController.selectedItemCreditCard = selectedItemCreditCard;
        viewController.selectedItemPurchaseDate = selectedItemPurchaseDate;
        viewController.selectedItemSequenceNumber = selectedItemSequenceNumber;
        viewController.selectedItemTimeStamp = selectedItemTimeStamp;
        viewController.selectedStoreReturnUrlText = selectedStoreReturnUrlText;
        [self.navigationController pushViewController:viewController animated:YES];

//    }
    
}

@end
