//
//  MainViewController.m
//  Basin
//
//  Created by Luke Constable on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
//#import "MFSideMenu.h"
#import <QuartzCore/QuartzCore.h>

@interface MainViewController ()

@property (strong, nonatomic) NSString *chosenCardFromPicker; // string for chosenCreditCard button
@property (strong, nonatomic) NSArray *receipts; // array to hold data from TransactionList.plist
@property (strong, nonatomic) NSMutableArray *searchReceipts; // array to load to table view and to deal with search

@property CGPoint originalSearchViewCenter; // CGPoint to allow movement of search bar view with keyboard
@property CGRect  originalTableViewFrame; // CGRect to allow distortion of table view with keyboard


// search methods
-(void)resetSearch;
-(void)handleSearchForTerm:(NSString *)searchTerm;

@end

@implementation MainViewController

@synthesize mainTableView;
@synthesize mainSearchBar;
@synthesize mainSearchView;

@synthesize selectSearchBar;

@synthesize chosenCardFromPicker;
@synthesize receipts;
@synthesize searchReceipts;

@synthesize originalSearchViewCenter;
@synthesize originalTableViewFrame;


- (void)viewDidAppear:(BOOL)animated
{
    if (selectSearchBar) {
        [mainSearchBar becomeFirstResponder];
        selectSearchBar = NO;
    }
    
    [super viewDidAppear:animated];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // hide back button, show menu button
    //  self.navigationItem.hidesBackButton = YES;
    //    [self.navigationController.sideMenu setupSideMenuBarButtonItem];
    
    // from CardPickerView via AppDelegate, filter receipts displayed by chosen credit card
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *cardFromAppDelegate = appDelegate.selectedCard;
    
    if ([cardFromAppDelegate length] > 4)
        chosenCardFromPicker = cardFromAppDelegate;
    else
        chosenCardFromPicker = @"All Cards";
    
    if (![chosenCardFromPicker isEqualToString:@"All Cards"]) {
        [self handleSearchForTerm:chosenCardFromPicker];
    } else if ([chosenCardFromPicker isEqualToString:@"All Cards"]) {
        [self resetSearch];  // to allow list to repopulate when switching back from specific card
    }
    
    // allow search, have "searchReceipts" make a mutable copy of "receipts"
    [self resetSearch];
    
    // hide 'cancel' button until textDidBeginEditing for search
    mainSearchBar.showsCancelButton = NO;
    
    [mainTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    // load path to transaction list, then load the plist into "receipts" array
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TransactionList"
                                                     ofType:@"plist"];
    NSDictionary *transactionInfo = [NSDictionary dictionaryWithContentsOfFile:path];
    self.receipts = [transactionInfo objectForKey:@"transactions"];
    
    // save the original coordinates, so to be able to move  with search bar keyboard
    originalSearchViewCenter.x         = mainSearchView.center.x;
    originalSearchViewCenter.y         = mainSearchView.center.y;
    originalTableViewFrame.origin.x    = mainTableView.frame.origin.x;
    originalTableViewFrame.origin.y    = mainTableView.frame.origin.y;
    originalTableViewFrame.size.width  = mainTableView.frame.size.width;
    originalTableViewFrame.size.height = mainTableView.frame.size.height;
    
    // add drop shadow to top and bottom
    CAGradientLayer *topScrollGradient = [CAGradientLayer layer];
    [topScrollGradient setFrame:CGRectMake(0, 0, 320, 4)];
    topScrollGradient.colors = [NSArray arrayWithObjects:
                                (id)[[[UIColor darkGrayColor] colorWithAlphaComponent:0.6f] CGColor],
                                (id)[[[UIColor grayColor] colorWithAlphaComponent:0.3f] CGColor],
                                (id)[[[UIColor grayColor] colorWithAlphaComponent:0.1f] CGColor],
                                (id)[[UIColor clearColor] CGColor],
                                nil];
    
       [self.view.layer addSublayer:topScrollGradient];
        
    // set background for navigation bar and bottom bars
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        UIImage *image = [UIImage imageNamed:@"navigationBar.png"];
        [self.navigationController.navigationBar setBackgroundImage:image
                                                      forBarMetrics:UIBarMetricsDefault];
    }
    
    mainSearchBar.backgroundImage = [UIImage imageNamed:@"navigationBarBottom.png"];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
//    [UIView animateWithDuration:0 animations:
//     ^{
//         mainSearchView.center = CGPointMake(originalSearchViewCenter.x, originalSearchViewCenter.y - 22); // for some reason, need a 22 pt offset here... was screen center reset?
//         mainTableView.frame   = CGRectMake(originalTableViewFrame.origin.x, originalTableViewFrame.origin.y,
//                                            originalTableViewFrame.size.width, originalTableViewFrame.size.height - 38); // again, need a seemingly arbitrary offset
//     }];
    
    [mainSearchBar resignFirstResponder];
    
    mainSearchBar.text = @"";
    [mainTableView reloadData];
}

- (void)viewDidUnload
{    
    [self setMainTableView:nil];
    [self setMainSearchBar:nil];
    [self setMainSearchView:nil];
    
    [self setChosenCardFromPicker:nil];
    [self setReceipts:nil];
    [self setSearchReceipts:nil];
        
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchReceipts count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return chosenCardFromPicker;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // identified prototype cell in storyboard as "receiptCell"
    NSString *receiptCellIdentifier = @"receiptCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:receiptCellIdentifier];
    
    // tagged imageview and labels in storyboard, load label text from the "searchReceipts" array
    UIImageView *storeNameImage  = (UIImageView *)[cell viewWithTag:1];
    UILabel *itemNameLabel       = (UILabel *)[cell viewWithTag:2];
    UILabel *purchaseDateLabel   = (UILabel *)[cell viewWithTag:3];
    UILabel *totalLabel          = (UILabel *)[cell viewWithTag:4];
    
    NSDictionary *rowData = [self.searchReceipts objectAtIndex:indexPath.row];
    
    storeNameImage.image     = [UIImage imageNamed:[rowData objectForKey:@"storeNameLogo"]];
    purchaseDateLabel.text   = [rowData objectForKey:@"purchaseDate"];
    totalLabel.text          = [rowData objectForKey:@"total"];
    
    // item name label from itemNames array
    NSMutableArray *itemNames = [rowData objectForKey:@"itemNames"];
    if ([itemNames count] > 1)
        itemNameLabel.text = [itemNames componentsJoinedByString:@", "];
    else
        itemNameLabel.text = [itemNames objectAtIndex:0];
    
    
    // set fonts
    
    itemNameLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    purchaseDateLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    totalLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17];
    
    return cell;
}


#pragma mark Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mainTableView deselectRowAtIndexPath:indexPath animated:YES];
    [self resetSearch];
    
}

#pragma mark Search bar delegate
-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // move search view, resize table view for keyboard
    
    [UIView beginAnimations:@"MoveView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.21f];

    mainSearchBar.showsCancelButton = YES; // show cancel button when searchbar moves up with keyboard
    
//    mainSearchView.center = CGPointMake(originalSearchViewCenter.x, originalSearchViewCenter.y - 238); // 238 = 216 for keyboard + 44/2 for UIView

    // 216 for keyboard + 22 for footer - 49 for tab bar - 12 for ?? = 167
    mainTableView.contentInset=UIEdgeInsetsMake(0,0,167,0);
    
    CGPoint scrollPoint = CGPointMake(0, 0);
    [mainTableView setContentOffset:scrollPoint animated:YES];
    
    [UIView commitAnimations];
    
}

-(void) searchBarTextDidEndEditing:(UISearchBar *)searchBar
{

}

// live search
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText length] == 0) {
        [self resetSearch];
        [mainTableView reloadData];
        return;
    }
    [self handleSearchForTerm:searchText];
}

// cancel search button will reset search and remove keyboard
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    mainSearchBar.text = @"";
    [self resetSearch];
    [mainTableView reloadData];
    
    [UIView beginAnimations:@"MoveView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.215f];
    mainSearchBar.showsCancelButton = NO; // hide cancel button when searchbar moves down with keyboard

    mainTableView.contentInset=UIEdgeInsetsMake(0,0,0,0);
    
    CGPoint scrollPoint = CGPointMake(0, 0);
    [mainTableView setContentOffset:scrollPoint animated:YES];

    [UIView commitAnimations];

    [mainSearchBar resignFirstResponder];
    
}


#pragma Search methods
-(void)resetSearch
{
    if (chosenCardFromPicker == @"All Cards") {
        self.searchReceipts = [self.receipts mutableCopy];
    } else {
        NSMutableArray *unfilteredSearchReceipts = [self.receipts mutableCopy];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"creditCard == %@", chosenCardFromPicker];
        NSArray *filteredArray = [unfilteredSearchReceipts filteredArrayUsingPredicate:predicate];
        
        self.searchReceipts = [filteredArray mutableCopy];
        
    }
    
}

-(void)handleSearchForTerm:(NSString *)searchTerm
{
    [self resetSearch];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"creditCard == %@", chosenCardFromPicker];
    NSArray *filteredReceipts = [searchReceipts filteredArrayUsingPredicate:predicate];
    
    NSArray *relevantReceipts = [[NSArray alloc] init];
    if (chosenCardFromPicker == @"All Cards") {
        relevantReceipts = searchReceipts;
    } else {
        relevantReceipts = filteredReceipts;
    }
    
    NSMutableArray *dictsToKeep = [[NSMutableArray alloc] init];
    NSMutableArray *dictsWithDuplicates = [[NSMutableArray alloc] init];
    
    for (NSDictionary *oneDict in relevantReceipts) {
                
        // adding keys to keyArray in alphabetical order manually to avoid including itemNames and itemPrices arrays
        NSMutableArray *keyArray = [[NSMutableArray alloc] initWithObjects: @"creditCard", @"purchaseDate", @"returnPolicyUrl", @"storeAddress", @"storeName", @"storeNameLogo", @"storePhoneNumber", @"subtotal", @"tax", @"total", nil];
        
        for (NSString *oneKey in keyArray) {
            
            NSMutableArray *objectArray = [[NSMutableArray alloc] init];
            [objectArray addObject:[oneDict valueForKey:oneKey]];
            
            for (NSString *oneObject in objectArray) {
                if ([oneObject rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location != NSNotFound)
                    [dictsWithDuplicates addObject:oneDict];
            }
        }
    }
    
    // searching itemNames and itemPrices seperately
    for (NSDictionary *oneDict in searchReceipts) {
        NSMutableArray *itemArrays = [[NSMutableArray alloc] initWithObjects:@"itemNames", @"itemPrices", nil];
        
        for (NSString *oneArray in itemArrays) {
            
            NSMutableArray *objectArray = [[NSMutableArray alloc] init];
            int arrayCount = [[oneDict valueForKey:oneArray] count];
            
            for (int i = 0; i < arrayCount; i++) {
                [objectArray addObject:[[oneDict valueForKey:oneArray] objectAtIndex:i]];
                
                for (NSString *oneObject in objectArray){
                    if ([oneObject rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location != NSNotFound)
                        [dictsWithDuplicates addObject:oneDict];
                }
                
                [objectArray removeAllObjects];
            }
        }
    }
    
    //remove duplicates
    for (id obj in dictsWithDuplicates) {
        if (![dictsToKeep containsObject:obj]) {
            [dictsToKeep addObject:obj];
        }
    }
    
    
    [searchReceipts removeAllObjects];
    [searchReceipts addObjectsFromArray:dictsToKeep];
    
    [mainTableView reloadData];
}


#pragma mark Segue related

// take selected cell (receipt), send it to the next view controller in order to load the correct data
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"mainToReceipt"]) {
        UIViewController *destination = segue.destinationViewController;
        if ([destination respondsToSelector:@selector(setDelegate:)]) {
            [destination setValue:self forKey:@"delegate"];
        }
        if ([destination respondsToSelector:@selector(setSelection:)]) {
            // prepare selection information
            NSIndexPath *indexPath = [mainTableView indexPathForCell:sender];
            NSDictionary *selection = [NSDictionary dictionaryWithObjectsAndKeys:
                                       indexPath, @"indexPath",
                                       nil];
            [destination setValue:selection forKey:@"selection"];
        }
        if ([destination respondsToSelector:@selector(setMainSearchReceipts:)]) {
            // pass searchReceipts to ReceiptViewController.m
            NSMutableArray *mainSearchReceipts = searchReceipts;
            [destination setValue:mainSearchReceipts forKey:@"mainSearchReceipts"];
        }
    }
}

@end
