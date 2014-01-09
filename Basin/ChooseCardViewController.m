//
//  ChooseCardViewController.m
//  Basin
//
//  Created by Lucien Constable on 9/30/12.
//
//

#import <QuartzCore/QuartzCore.h>
#import "ChooseCardViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"

@interface ChooseCardViewController ()

@end

@implementation ChooseCardViewController

@synthesize cardTableView;
@synthesize cardData;
@synthesize chosenCard;


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

    // Pull cardData from TransactionList.plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TransactionList"
                                                     ofType:@"plist"];
    NSDictionary *transactionInfo = [NSDictionary dictionaryWithContentsOfFile:path];
    NSMutableArray *receipts = [transactionInfo objectForKey:@"transactions"];
    
    NSMutableArray *cardPickerDataWithDuplicates = [[NSMutableArray alloc] init];
    
    for (NSDictionary *oneDict in receipts) {
        NSString *creditCard = [oneDict objectForKey:@"creditCard"];
        [cardPickerDataWithDuplicates addObject:creditCard];
    }
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithObjects:@"All Cards", nil];
    for (id obj in cardPickerDataWithDuplicates) {
        if (![tempArray containsObject:obj]) {
            [tempArray addObject:obj];
        }
    }
    [tempArray sortUsingSelector:@selector(compare:)];
    cardData = tempArray;

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
                
    [cardTableView setScrollEnabled:NO];
    
}

- (void)viewDidUnload
{
    [self setCardData:nil];
    [self setChosenCard:nil];
    [self setCardTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cardData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"creditCardCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UIImageView *creditCardImage = (UIImageView *)[cell viewWithTag:1];
    UILabel *creditCardNameLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *creditCardNumberLabel = (UILabel *)[cell viewWithTag:3];
    
    creditCardNameLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    creditCardNumberLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    
    NSString *creditCardString = [cardData objectAtIndex:indexPath.row];
    
    if (creditCardString == @"All Cards")
    {
        creditCardNameLabel.text = creditCardString;
        creditCardNumberLabel.text = @"";
        
        creditCardNameLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:24];
        
        CGRect newLabelFrame = CGRectMake(creditCardImage.frame.origin.x, creditCardNameLabel.frame.origin.y + 15, creditCardNameLabel.frame.size.width, creditCardNameLabel.frame.size.height);
        creditCardNameLabel.frame = newLabelFrame;
    }
    else if ([creditCardString rangeOfString:@"Amex" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        creditCardImage.image = [UIImage imageNamed:@"cardAmex"];
        creditCardNameLabel.text = @"American Express Gold Card";
        creditCardNumberLabel.text = [creditCardString substringFromIndex:5];
    }
    else if ([creditCardString rangeOfString:@"MC" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        creditCardImage.image = [UIImage imageNamed:@"cardMastercard"];        
        creditCardNameLabel.text = @"Citibank Mastercard";
        creditCardNumberLabel.text = [creditCardString substringFromIndex:3];
    }
    else if ([creditCardString rangeOfString:@"Visa" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        creditCardImage.image = [UIImage imageNamed:@"cardVisa"];
        creditCardNameLabel.text = @"Bank of America Visa";
        creditCardNumberLabel.text = [creditCardString substringFromIndex:5];
    }

    
    
    return cell;

}

// dirty solution to get rid of excess rows
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}


#pragma mark Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    chosenCard = [cardData objectAtIndex:indexPath.row];
    
    // use App Delegate in order to save selected card for main view
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.selectedCard = chosenCard;
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
