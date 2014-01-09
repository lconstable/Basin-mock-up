//
//  ManualAddViewController.m
//  Basin
//
//  Created by Lucien Constable on 9/11/12.
//
//

#import <QuartzCore/QuartzCore.h>
#import "ManualAddViewController.h"
#import "MainViewController.h"


@interface ManualAddViewController ()

@end

@implementation ManualAddViewController

@synthesize entryTable;
@synthesize entryTableTextView;

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

    // set up table view
    entryTable.allowsSelection = NO;
    
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
        
}

- (void)viewDidUnload
{
    [self setEntryTable:nil];
    [self setEntryTableTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)doneButtonPressed:(id)sender
{
    // write data here

    [self popToMainController];
}

-(void)popToMainController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    MainViewController *mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    [self.navigationController pushViewController:mainViewController animated:NO];
    
    //    int vcCount = [[self.navigationController viewControllers] count];
    //
    //    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:vcCount - 3] animated:YES];
    // Pop no longer works due to side menu
#warning Will this just keep piling up VCs and waste memory?
}

#pragma mark - Table view data source

 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 {
    return 1;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
     return 4;
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ManualAddCellIdentifier = @"manualAddCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ManualAddCellIdentifier];
    
    UILabel *promptLabel  = (UILabel *)[cell viewWithTag:1];
    UITextField *entryField = (UITextField *)[cell viewWithTag:2];
    
    promptLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    entryField.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
    
    NSMutableArray *promptLabelArray = [[NSMutableArray alloc] initWithObjects:@"Store Name", @"Purchase Date", @"Authorization #", @"Credit Card #", nil];
    promptLabel.text  = [promptLabelArray objectAtIndex:indexPath.row];
    
    NSMutableArray *placeholderArray = [[NSMutableArray alloc] initWithObjects:@"General Store", @"MM/YY", @"1234567", @"1234 5678 9123 4567", nil];
    entryField.placeholder = [placeholderArray objectAtIndex:indexPath.row];
    
    entryField.delegate = self;
    
    if (indexPath.row == 0) {
        [entryField becomeFirstResponder];
    }
    if (indexPath.row == 3) {
        [entryField setReturnKeyType:UIReturnKeyDone];
    }
    
    return cell;
    
}

#pragma mark - Text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    UITableViewCell *currentCell = (UITableViewCell *) textField.superview.superview;
    NSIndexPath *currentIndexPath = [self.entryTable indexPathForCell:currentCell];    
    
    if (currentIndexPath.row == 3) {
        [self popToMainController];
    }
    else {
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:currentIndexPath.row + 1 inSection:0];
    UITableViewCell *nextCell = (UITableViewCell *) [self.entryTable cellForRowAtIndexPath:nextIndexPath];    
    [[nextCell viewWithTag:2] becomeFirstResponder];
    }
        
    return NO;
}

@end
