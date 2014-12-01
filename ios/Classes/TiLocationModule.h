/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiModule.h"
#import <CoreLocation/CoreLocation.h>

@interface TiLocationModule : TiModule

@property(nonatomic, retain) NSString *EXIT_REGION;
@property(nonatomic, retain) NSString *ENTER_REGION;
@property(nonatomic, retain) NSString *REGION_MONITOR_FAIL;
@property(nonatomic, retain) NSString *LOCATION_UPDATE;
@property(nonatomic, retain) NSString *MONITOR_REGION;
@property(nonatomic, retain) NSString *HEADING;
@property(nonatomic, retain) NSString *ERROR;

@end
