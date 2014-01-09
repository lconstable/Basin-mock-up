//
//  UIViewController_f.h
//  Basin
//
//  Created by Luke Constable on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

// places pin in the map

@interface AddressAnnotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, retain) NSString *title;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c;

@end

