//
//  MainTableViewController.m
//  Basin
//
//  Created by Luke Constable on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()
@property (strong, nonatomic) NSArray *receipts;
@end

@implementation MainTableViewController

@synthesize receipts;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"TransactionList"
                                                     ofType:@"plist"];
    NSDictionary *transactionInfo = [NSDictionary dictionaryWithContentsOfFile:path];
    self.receipts = [transactionInfo objectForKey:@"transactions"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.receipts = nil;
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
    return [self.receipts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
/*
    For search to work, add a dictionary full of information, load it in here
*/
    
    NSString *receiptCellIdentifier = @"receiptCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:receiptCellIdentifier];
    
    UILabel *storeNameLabel      = (UILabel *)[cell viewWithTag:1];
    UILabel *itemNameLabel       = (UILabel *)[cell viewWithTag:2];
    UILabel *purchaseDateLabel   = (UILabel *)[cell viewWithTag:3];
    UILabel *totalLabel          = (UILabel *)[cell viewWithTag:4];

    NSDictionary *rowData = [self.receipts objectAtIndex:indexPath.row];

    storeNameLabel.text      = [rowData objectForKey:@"storeName"];
    itemNameLabel.text       = [rowData objectForKey:@"itemName"];
    purchaseDateLabel.text   = [rowData objectForKey:@"purchaseDate"];
    totalLabel.text          = [rowData objectForKey:@"total"];
        
    return cell;
}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark Segue related
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"mainToReceipt"]) { 
        UIViewController *destination = segue.destinationViewController;
        if ([destination respondsToSelector:@selector(setDelegate:)]) {
            [destination setValue:self forKey:@"delegate"];
        }
        if ([destination respondsToSelector:@selector(setSelection:)]) {
            // prepare selection information
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            id object = [self.receipts objectAtIndex:indexPath.row];
            NSDictionary *selection = [NSDictionary dictionaryWithObjectsAndKeys:
                                       indexPath, @"indexPath",
                                       object, @"object",
                                       nil];
            [destination setValue:selection forKey:@"selection"];
        }
    }
}
@end
