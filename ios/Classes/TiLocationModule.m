/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiLocationModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiLocationModule

@synthesize EXIT_REGION;
@synthesize ENTER_REGION;
@synthesize REGION_MONITOR_FAIL;
@synthesize LOCATION_UPDATE;
@synthesize MONITOR_REGION;
@synthesize HEADING;
@synthesize ERROR;



#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"52f96d34-8659-4320-aa63-0897e9f6c058";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.location";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

-(NSString *)EXIT_REGION
{
	return @"exitRegion";
}

-(NSString *)ENTER_REGION
{
	return @"enterRegion";
}

-(NSString *)REGION_MONITOR_FAIL
{
	return @"regionMonitorFail";
}

-(NSString *)LOCATION_UPDATE
{
	return @"locationUpdate";
}

-(NSString *)MONITOR_REGION
{
	return @"monitorRegion";
}
-(NSString *)HEADING
{
	return @"heading";
}
-(NSString *)ERROR
{
	return @"error";
}


@end
