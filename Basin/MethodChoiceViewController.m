//
//  MethodChoiceViewController.m
//  Basin
//
//  Created by Lucien Constable on 10/3/12.
//
//

#import "MethodChoiceViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MethodChoiceViewController ()

@end

@implementation MethodChoiceViewController

@synthesize methodTable;

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
    
    // set table frame for 22 px header, 70 px row height * 3
    CGRect newFrame = CGRectMake(methodTable.frame.origin.x, methodTable.frame.origin.y, methodTable.frame.size.width, 276);
    methodTable.frame = newFrame;
    
    [methodTable setScrollEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMethodTable:nil];
    [super viewDidUnload];
}

#pragma mark Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"methodCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UILabel *methodLabel  = (UILabel *)[cell viewWithTag:1];
    methodLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17];
    
    NSMutableArray *methodArray = [[NSMutableArray alloc] initWithObjects:@"Scan QR Code", @"Take a Photo", @"Add Manually", nil];
    
    methodLabel.text = [methodArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [methodTable deselectRowAtIndexPath:indexPath animated:YES];
    
    // scan qr code
    if (indexPath.row == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ScanQRCodeViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
   
    // take a photo
    if (indexPath.row == 1) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"TakePhotoViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    }

    // add manually
    if (indexPath.row == 2) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ManualAddViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}
@end
