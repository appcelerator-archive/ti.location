//
//  TiLocationLocationManagerProxy.m
//  location
//
//  Created by Pedro Enrique on 11/13/11.
//  Copyright (c) 2011 Appcelerator. All rights reserved.
//

#import "TiLocationLocationManagerProxy.h"
#import "TiLocationRegionProxy.h"
#import "TiUtils.h"
#import "TiHost.h"

@implementation TiLocationLocationManagerProxy

-(void)dealloc
{
	[myRegion release];
	[locationManager release];
	[super dealloc];
}

-(id)init
{
	if(self = [super init])
	{

	}
	return self;

}// Location Manager Creation:

-(CLLocationManager *)locationManager
{
	if([CLLocationManager regionMonitoringAvailable])
	{
		if(locationManager == nil){
			locationManager = [[CLLocationManager alloc] init];
			locationManager.delegate = self;
		}
		return locationManager;
	}
	else
	{
		return nil;
	}
}



-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	if ([self _hasListeners:@"error"])
	{
        NSMutableDictionary *tiEvent = [NSMutableDictionary dictionary];
        [tiEvent setObject:error forKey:@"error"];
		[self fireEvent:@"error" withObject:tiEvent];
	}
}

-(void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
	if ([self _hasListeners:@"regionMonitorFail"])
	{
		NSDictionary *reg = [NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithDouble:region.center.latitude],@"latitude",
			[NSNumber numberWithDouble:region.center.longitude],@"longitude",
			[NSNumber numberWithDouble:region.radius],@"center",
			nil];

        NSMutableDictionary *tiEvent = [NSMutableDictionary dictionary];
	    [tiEvent setObject:reg forKey:@"coord"];
	    //[tiEvent setObject:region forKey:@"region"];
        [tiEvent setObject:error forKey:@"error"];
		[self fireEvent:@"regionMonitorFail" withObject:tiEvent];
	}
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	if ([self _hasListeners:@"locationUpdate"])
	{
		NSDictionary *old = [NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithDouble:oldLocation.coordinate.latitude],@"latitude",
			[NSNumber numberWithDouble:oldLocation.coordinate.longitude],@"longitude",
			[NSNumber numberWithDouble:oldLocation.course],@"course",
			[NSNumber numberWithDouble:oldLocation.horizontalAccuracy],@"horizontalAccuracy",
			[NSNumber numberWithDouble:oldLocation.speed],@"speed",
			[NSNumber numberWithDouble:oldLocation.verticalAccuracy],@"verticalAccuracy",
			[NSNumber numberWithDouble:oldLocation.altitude],@"altitude",
			nil];

		NSDictionary *new = [NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithDouble:newLocation.coordinate.latitude],@"latitude",
			[NSNumber numberWithDouble:newLocation.coordinate.longitude],@"longitude",
			[NSNumber numberWithDouble:newLocation.course],@"course",
			[NSNumber numberWithDouble:newLocation.horizontalAccuracy],@"horizontalAccuracy",
			[NSNumber numberWithDouble:newLocation.speed],@"speed",
			[NSNumber numberWithDouble:newLocation.verticalAccuracy],@"verticalAccuracy",
			[NSNumber numberWithDouble:newLocation.altitude],@"altitude",
			nil];


        NSMutableDictionary *tiEvent = [NSMutableDictionary dictionary];
        [tiEvent setObject:new forKey:@"newLocation"];
        [tiEvent setObject:old forKey:@"oldLocation"];

		[self fireEvent:@"locationUpdate" withObject:tiEvent];
	}
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
	if ([self _hasListeners:@"enterRegion"])
	{
		NSDictionary *reg = [NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithDouble:region.center.latitude],@"latitude",
			[NSNumber numberWithDouble:region.center.longitude],@"longitude",
			[NSNumber numberWithDouble:region.radius],@"center",
			nil];

		NSMutableDictionary *tiEvent = [NSMutableDictionary dictionary];
	    [tiEvent setObject:reg forKey:@"coord"];
	    //[tiEvent setObject:region forKey:@"region"];

		[self fireEvent:@"enterRegion" withObject:tiEvent];
	}
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
	if ([self _hasListeners:@"exitRegion"])
	{
		NSDictionary *reg = [NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithDouble:region.center.latitude],@"latitude",
			[NSNumber numberWithDouble:region.center.longitude],@"longitude",
			[NSNumber numberWithDouble:region.radius],@"center",
			nil];

		NSMutableDictionary *tiEvent = [NSMutableDictionary dictionary];
	    [tiEvent setObject:reg forKey:@"coord"];
	    //[tiEvent setObject:region forKey:@"region"];

		[self fireEvent:@"exitRegion" withObject:tiEvent];
	}
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
	if ([self _hasListeners:@"monitorRegion"])
	{
		NSDictionary *reg = [NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithDouble:region.center.latitude],@"latitude",
			[NSNumber numberWithDouble:region.center.longitude],@"longitude",
			[NSNumber numberWithDouble:region.radius],@"center",
			nil];

        NSMutableDictionary *tiEvent = [NSMutableDictionary dictionary];
	    [tiEvent setObject:reg forKey:@"coord"];
	    //[tiEvent setObject:region forKey:@"region"];
		[self fireEvent:@"monitorRegion" withObject:tiEvent];
	}
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
	if ([self _hasListeners:@"heading"])
	{
		NSDictionary *head = [NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithDouble:newHeading.headingAccuracy],@"headingAccuracy",
			[NSNumber numberWithDouble:newHeading.magneticHeading],@"magneticHeading",
			[NSNumber numberWithDouble:newHeading.trueHeading],@"trueHeading",
			nil];

        NSMutableDictionary *tiEvent = [NSMutableDictionary dictionary];
        [tiEvent setObject:head forKey:@"heading"];
		[self fireEvent:@"heading" withObject:tiEvent];
	}

}

-(CLRegion *)myRegion:(TiLocationRegionProxy *)args
{
	TiLocationRegionProxy *reg = args;
	
	CLLocationDegrees latitude = [reg latitude];
	CLLocationDegrees longitude = [reg longitude];
	CLLocationDistance distance = [reg distance];
	NSString *identifier = [reg identifier];

	if(!latitude){
		NSLog(@"[ERROR] \"latitude\" needed");
		return nil;
	}
	if(!longitude){
		NSLog(@"[ERROR] \"longitude\" needed");
		return nil;
	}
	if(!distance){
		NSLog(@"[ERROR] \"distance\" needed");
		return nil;
	}
	if(!identifier){
		NSLog(@"[ERROR] \"identifier\" needed");
		return nil;
	}

	
	CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(latitude, longitude);

	if(!CLLocationCoordinate2DIsValid(coords))
	{
		NSLog(@"[ERROR] coordinates not valid");
		return nil;
	}

	return [[[CLRegion alloc] initCircularRegionWithCenter:coords radius:distance identifier:identifier] autorelease];

}


#pragma mark Public API calls

-(void)stopMonitoringSignificantLocationChanges:(id)args
{
	ENSURE_UI_THREAD_0_ARGS;
	[[self locationManager] stopMonitoringSignificantLocationChanges];
}

-(void)startMonitoringSignificantLocationChanges:(id)args
{
	ENSURE_UI_THREAD_0_ARGS;
	[[self locationManager] startMonitoringSignificantLocationChanges];
}

-(void)startUpdatingLocation:(id)args
{
	ENSURE_UI_THREAD_0_ARGS;
	[[self locationManager] startUpdatingLocation];
}

-(void)stopUpdatingLocation:(id)args
{
	ENSURE_UI_THREAD_0_ARGS;
	[[self locationManager] stopUpdatingLocation];
}

-(void)startUpdatingHeading:(id)args
{
	ENSURE_UI_THREAD_0_ARGS;
	[[self locationManager] startUpdatingHeading];
}

-(void)stopUpdatingHeading:(id)args
{
	ENSURE_UI_THREAD_0_ARGS;
	[[self locationManager] stopUpdatingHeading];
}

-(void)startMonitoringForRegion:(id)args
{
	ENSURE_SINGLE_ARG(args,NSObject);
	ENSURE_UI_THREAD_1_ARG(args);
	
	if (![args isKindOfClass:[TiLocationRegionProxy class]])
	{
		return;
	}
	CLRegion *a = [self myRegion:args];
	CLLocationAccuracy b = a.radius;
	[[self locationManager] startMonitoringForRegion:a desiredAccuracy:b];
}


-(void)stopMonitoringForRegion:(id)args
{
	ENSURE_SINGLE_ARG(args,NSObject);
	ENSURE_UI_THREAD_1_ARG(args);
	
	if (![args isKindOfClass:[TiLocationRegionProxy class]])
	{
		return;
	}
	CLRegion *a = [self myRegion:args];
	[[self locationManager] stopMonitoringForRegion:a];
}


-(id)allRegions:(id)args
{	
	NSArray *a = [[[self locationManager] monitoredRegions] allObjects];
	int len = [a count];

	NSMutableArray *ar = [[[NSMutableArray alloc] init] autorelease];
	for(int i = 0; i < len; i++)
	{
		[ar addObject:[a objectAtIndex:i]];
	}
	NSArray *pe = [NSArray arrayWithArray:(NSArray *)ar];
	[ar release];
	NSLog(@"%@",pe);
	return pe;
}

-(void)stopAll:(id)args
{
	NSArray *a = [[[self locationManager] monitoredRegions] allObjects];
	int len = [a count];

	for(int i = 0; i < len; i++)
	{
		[[self locationManager] stopMonitoringForRegion:[a objectAtIndex:i]];
	}
}

-(id)getRegion:(id)args
{
	
	if (![args isKindOfClass:[TiLocationRegionProxy class]])
	{
		return nil;
	}

	/*

	NSDictionary *reg = [NSDictionary dictionaryWithObjectsAndKeys:
		[NSNumber numberWithDouble:r.center.latitude],@"latitude",
		[NSNumber numberWithDouble:r.center.longitude],@"longitude",
		[NSNumber numberWithDouble:r.radius],@"distance",
		r.identifier,@"identifier",
		nil];
	*/
	return args;
}

-(BOOL)isSupported:(id)arg

{
	return [CLLocationManager regionMonitoringAvailable];
}

@end

