//
//  EventViewController.h
//  PayPort
//
//  Created by Lucien Constable on 5/29/13.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface EventViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *eventTable;

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) NSString *eventString;
@property (strong, nonatomic) NSString *dateString;

@end
