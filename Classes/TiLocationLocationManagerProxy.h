//
//  TiLocationLocationManagerProxy.h
//  location
//
//  Created by Pedro Enrique on 11/13/11.
//  Copyright (c) 2011 Appcelerator. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "TiProxy.h"

@interface TiLocationLocationManagerProxy : TiProxy<CLLocationManagerDelegate>
{
	CLLocationManager *locationManager;
	CLRegion *myRegion;
}

@end
