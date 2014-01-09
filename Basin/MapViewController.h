//
//  MapViewController.h
//  Basin
//
//  Created by Luke Constable on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSString *storeAddressText;
@property (strong, nonatomic) NSString *storeNameText;

@end
