//
//  MapViewController.m
//  Basin
//
//  Created by Luke Constable on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "AddressAnnotation.h"
#import <QuartzCore/QuartzCore.h>

@interface MapViewController ()

@property AddressAnnotation *addAnnotation;

@end

@implementation MapViewController

@synthesize mapView;
@synthesize storeAddressText;
@synthesize storeNameText;

@synthesize addAnnotation;

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
	
    // set self as mapView delegate
    self.mapView.delegate = self;
    
    // show passed-in address on map
    [self showAddress];
    
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

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setStoreAddressText:nil];
    [self setStoreNameText:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Map view

// displays address with pin on map
-(void)showAddress
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta  = 0.005;
    span.longitudeDelta = 0.005;
    
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
    // storeAddressText passed in from ReceiptViewController
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
