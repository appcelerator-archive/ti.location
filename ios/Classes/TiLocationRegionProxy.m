//
//  TiLocationRegionProxy.m
//  location
//
//  Created by Pedro Enrique on 11/13/11.
//  Copyright (c) 2011 Appcelerator. All rights reserved.
//

#import "TiLocationRegionProxy.h"
#import "TiUtils.h"

@implementation TiLocationRegionProxy
@synthesize _latitude;
@synthesize _longitude;
@synthesize _distance;
@synthesize _identifier;

-(void)dealloc
{
	[self release];
	[super dealloc];
}

-(id)init
{
	if(self = [super init])
	{
	}
	return self;
}

-(void)setLatitude:(id)arg
{	
	[self replaceValue:arg forKey:@"latitude" notification:NO];
}
-(void)setLongitude:(id)arg
{
	[self replaceValue:arg forKey:@"longitude" notification:NO];
}
-(void)setDistance:(id)arg
{
	[self replaceValue:arg forKey:@"distance" notification:NO];
}
-(void)setIdentifier:(id)arg
{
	[self replaceValue:arg forKey:@"identifier" notification:NO];
}

- (CLLocationDegrees)latitude
{
    return [TiUtils doubleValue:[self valueForUndefinedKey:@"latitude"]];
}

- (CLLocationDegrees)longitude
{
    return [TiUtils doubleValue:[self valueForUndefinedKey:@"longitude"]];
}

- (CLLocationDistance)distance
{
    return [TiUtils doubleValue:[self valueForUndefinedKey:@"distance"]];
}

-(NSString *)identifier
{
	return [TiUtils stringValue:[self valueForUndefinedKey:@"identifier"]];
}

// this is deadly!
-(void)destroyProxy:(id)args
{
	ENSURE_UI_THREAD_0_ARGS;
	[self release];
}

@end
