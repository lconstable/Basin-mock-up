//
//  EventViewController.m
//  PayPort
//
//  Created by Lucien Constable on 5/29/13.
//
//

#import "EventViewController.h"
#import "AddressAnnotation.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageExtras.h"

@interface EventViewController ()

@property AddressAnnotation *addAnnotation;

@end

@implementation EventViewController

@synthesize eventTable;
@synthesize mapView;
@synthesize eventString;
@synthesize dateString;
@synthesize addAnnotation;

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
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    eventTable.userInteractionEnabled = NO;
    eventTable.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setEventTable:nil];
    [super viewDidUnload];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 76;
    } else {
        return 160;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 0) {
        
        NSString *cellIdentifier = @"labelCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        UILabel *eventTitleLabel       = (UILabel *)[cell viewWithTag:1];
        UILabel *dateLabel   = (UILabel *)[cell viewWithTag:2];
        
        eventTitleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17];
        dateLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14];
        
        eventTitleLabel.text = eventString;
        dateLabel.text = dateString;
        
        
        return cell;
    
    } else {
        
        NSString *cellIdentifier = @"mapCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 300, 159)];
        self.mapView.delegate = self;
        [self showAddress];
        
        mapView.userInteractionEnabled = NO;
        mapView.layer.cornerRadius = 8;
        
        [cell.contentView addSubview:mapView];
        cell.userInteractionEnabled = NO;
        
        return cell;
    }
    
}


#pragma mark Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark Map view

// displays address with pin on map
-(void)showAddress
{
    // storeNameText is dummy data
    NSString *storeNameText = @"Store Name";
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta  = 0.003;
    span.longitudeDelta = 0.003;
    
    CLLocationCoordinate2D location = [self addressLocation];
    region.span = span;
    region.center = location;
    
    // add annotation, set title, select it to display title
    if (addAnnotation != nil) {
        [mapView removeAnnotation:addAnnotation];
        addAnnotation = nil;
    }
    addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location];
    addAnnotation.title = storeNameText;
    
    [mapView addAnnotation:addAnnotation];
    [mapView selectAnnotation:addAnnotation animated:NO];
    
    [mapView setRegion:region animated:YES];
    [mapView regionThatFits:region];
}

// match the text to work with the Google Maps API, sets location in proper format
-(CLLocationCoordinate2D)addressLocation
{
    // storeAddressText is dummy text
    NSString *storeAddressText = @"77 5th Avenue New York, NY 10003";
    
    double latitude  = 0.0;
    double longitude = 0.0;
    
    NSString *esc_addr =  [storeAddressText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    
    CLLocationCoordinate2D location;
    location.latitude  = latitude;
    location.longitude = longitude;
    
    return location;
}

@end
