//
//  TiLocationRegionProxy.h
//  location
//
//  Created by Pedro Enrique on 11/13/11.
//  Copyright (c) 2011 Appcelerator. All rights reserved.
//

#import "TiProxy.h"
#import <CoreLocation/CoreLocation.h>

@interface TiLocationRegionProxy : TiProxy


@property(nonatomic)CLLocationDegrees _latitude;
@property(nonatomic)CLLocationDegrees _longitude;
@property(nonatomic)CLLocationDistance _distance;
@property(nonatomic,retain)NSString *_identifier;

-(CLLocationDegrees)latitude;
-(CLLocationDegrees)longitude;
-(CLLocationDistance)distance;
-(NSString *)identifier;
@end
