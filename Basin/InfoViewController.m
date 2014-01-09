//
//  InfoViewController.m
//  Basin
//
//  Created by Lucien Constable on 3/12/13.
//
//

#import "InfoViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface InfoViewController ()

@end

@implementation InfoViewController

@synthesize infoTable;

@synthesize personalInformationLabel;
@synthesize firstNameLabel;
@synthesize lastNameLabel;
@synthesize emailLabel;
@synthesize phoneLabel;
@synthesize address1Label;
@synthesize address2Label;
@synthesize cityLabel;
@synthesize stateLabel;
@synthesize zipLabel;
@synthesize firstNameText;
@synthesize lastNameText;
@synthesize emailText;
@synthesize phoneText;
@synthesize address1Text;
@synthesize address2Text;
@synthesize cityText;
@synthesize stateText;
@synthesize zipText;


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
    // table not scrollable
    [infoTable setScrollEnabled:NO];
    
    // set fonts
    personalInformationLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:20];
    firstNameLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:17];
    lastNameLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:17];
    emailLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:17];
    phoneLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:17];
    address1Label.font = [UIFont fontWithName:@"ProximaNova-Bold" size:17];
    address2Label.font = [UIFont fontWithName:@"ProximaNova-Bold" size:17];
    cityLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:17];
    stateLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:17];
    zipLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:17];
    firstNameText.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14];
    lastNameText.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14];
    emailText.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14];
    phoneText.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14];
    address1Text.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14];
    address2Text.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14];
    cityText.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14];
    stateText.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14];
    zipText.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14];
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setFirstNameLabel:nil];
    [self setLastNameLabel:nil];
    [self setEmailLabel:nil];
    [self setPhoneLabel:nil];
    [self setAddress1Label:nil];
    [self setAddress2Label:nil];
    [self setCityLabel:nil];
    [self setStateLabel:nil];
    [self setZipLabel:nil];
    [self setFirstNameText:nil];
    [self setLastNameText:nil];
    [self setEmailText:nil];
    [self setPhoneText:nil];
    [self setAddress1Label:nil];
    [self setAddress1Text:nil];
    [self setAddress1Text:nil];
    [self setAddress2Text:nil];
    [self setCityText:nil];
    [self setStateText:nil];
    [self setZipText:nil];
    [self setPersonalInformationLabel:nil];
    [self setInfoTable:nil];
    [super viewDidUnload];
}

#pragma mark Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        static NSString *cellIdentifier = @"doubleCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        UITextField *firstNameField = (UITextField *)[cell viewWithTag:1];
        UITextField *lastNameField = (UITextField *)[cell viewWithTag:2];
        
        firstNameField.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
        lastNameField.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
        
        [firstNameField becomeFirstResponder];
        
        // sample data
        firstNameField.text = @"John";
        lastNameField.text = @"Smith";
        
        firstNameField.delegate = self;
        lastNameField.delegate  = self;
        
        return cell;
        
    } else if (indexPath.row == 3) {
      
        static NSString *cellIdentifier = @"tripleCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        UITextField *firstField = (UITextField *)[cell viewWithTag:1];
        UITextField *secondField = (UITextField *)[cell viewWithTag:2];
        UITextField *thirdField = (UITextField *)[cell viewWithTag:3];
        
        firstField.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
        secondField.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
        thirdField.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
        
        // sample data
        firstField.text = @"New York";
        secondField.text = @"NY";
        thirdField.text = @"10028";
        
        firstField.delegate = self;
        secondField.delegate = self;
        thirdField.delegate = self;
        
        return cell;
        
    } else {
        
        static NSString *cellIdentifier = @"entryCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        UITextField *entryField = (UITextField *)[cell viewWithTag:1];
        
        entryField.font = [UIFont fontWithName:@"ProximaNova-Regular" size:14];
        
        NSMutableArray *placeholderArray = [[NSMutableArray alloc] initWithObjects:@"Email Address", @"Address", nil];
        
        entryField.placeholder = [placeholderArray objectAtIndex:indexPath.row - 1];
        
        // set keyboard for email address
        if (indexPath.row == 1) {
            [entryField setKeyboardType:UIKeyboardTypeEmailAddress];
            [entryField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
            entryField.text = @"john@smith.com";
        } else if (indexPath.row == 2) {
            entryField.text = @"1000 5th Ave Apartment 1A";
        }
        
        entryField.delegate = self;
        
        return cell;
    }
}
@end
