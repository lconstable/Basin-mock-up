//
//  MyRetailerViewController.m
//  PayPort
//
//  Created by Lucien Constable on 5/29/13.
//
//

#import "MyRetailerViewController.h"

@interface MyRetailerViewController ()

@property (strong, nonatomic) NSArray *receipts; // array to hold data from TransactionList.plist

@end

@implementation MyRetailerViewController

@synthesize retailerTable;
@synthesize likeArray;
@synthesize selectedIndexPath;
@synthesize receipts;


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
    likeArray = [[NSMutableArray alloc] init];
    
    // number of retailers as 20 for now
    for (int n = 0; n < 20; n++) {
        NSMutableDictionary *likeDict = [[NSMutableDictionary alloc] init];
        [likeDict setValue:[NSNumber numberWithBool:NO] forKey:@"liked"];
        [likeArray addObject:likeDict];
    }

    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // just using receipt retailers for now
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TransactionList"
                                                     ofType:@"plist"];
    NSDictionary *transactionInfo = [NSDictionary dictionaryWithContentsOfFile:path];
    self.receipts = [transactionInfo objectForKey:@"transactions"];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setRetailerTable:nil];
    [super viewDidUnload];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.receipts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // identified prototype cell in storyboard as "receiptCell"
    NSString *receiptCellIdentifier = @"retailerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:receiptCellIdentifier];
    
    UIImageView *retailerLogo       = (UIImageView *)[cell viewWithTag:10];
    
    NSDictionary *rowData = [self.receipts objectAtIndex:indexPath.row];
    retailerLogo.image     = [UIImage imageNamed:[rowData objectForKey:@"storeNameLogo"]];
    
    // like button
    NSMutableDictionary *likeDict = [likeArray objectAtIndex:indexPath.row];
    [likeDict setObject:cell forKey:@"cell"];
    BOOL liked = [[likeDict objectForKey:@"liked"] boolValue];
    UIImage *image = (liked) ? [UIImage imageNamed:@"liked.png"] : [UIImage imageNamed:@"unliked.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    button.frame = frame;	// match the button's size with the image size
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(likeButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    cell.accessoryView = button;
    
    return cell;
}


#pragma mark Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableView: retailerTable  accessoryButtonTappedForRowWithIndexPath: indexPath];
    [retailerTable deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)likeButtonTapped:(id)sender event:(id)event
{
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.retailerTable];
	NSIndexPath *indexPath = [self.retailerTable indexPathForRowAtPoint: currentTouchPosition];
    selectedIndexPath = indexPath;
	if (indexPath != nil)
	{
		[self tableView: self.retailerTable accessoryButtonTappedForRowWithIndexPath: indexPath];
	}
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	NSMutableDictionary *likeDict = [likeArray objectAtIndex:indexPath.row];
	BOOL liked = [[likeDict objectForKey:@"liked"] boolValue];
    
    if (!liked) {

        // unliked to liked
        [likeDict setObject:[NSNumber numberWithBool:!liked] forKey:@"liked"];
        
        UITableViewCell *cell = [likeDict objectForKey:@"cell"];
        UIButton *button = (UIButton *)cell.accessoryView;
        UIImage *newImage = (liked) ? [UIImage imageNamed:@"unliked"] : [UIImage imageNamed:@"liked"];
        [button setBackgroundImage:newImage forState:UIControlStateNormal];
    
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
        // liked to unliked, selectedIndexPath passed from likeButtonTapped
        NSMutableDictionary *likeDict = [likeArray objectAtIndex:selectedIndexPath.row];
        BOOL liked = [[likeDict objectForKey:@"liked"] boolValue];

        [likeDict setObject:[NSNumber numberWithBool:!liked] forKey:@"liked"];
        
        UITableViewCell *cell = [likeDict objectForKey:@"cell"];
        UIButton *button = (UIButton *)cell.accessoryView;
        UIImage *newImage = (liked) ? [UIImage imageNamed:@"unliked"] : [UIImage imageNamed:@"liked"];
        [button setBackgroundImage:newImage forState:UIControlStateNormal];
        
        [likeDict setObject:[NSNumber numberWithBool:!liked] forKey:@"liked"];
        
    }
}
@end
