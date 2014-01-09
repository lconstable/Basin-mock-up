//
//  AddressAnnotation.m
//  Basin
//
//  Created by Luke Constable on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddressAnnotation.h"

@implementation AddressAnnotation 

@synthesize coordinate;
@synthesize title;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c
{
    coordinate = c;
    return self;
}

@end
