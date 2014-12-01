//
//  TiLocationNotificationProxy.m
//  location
//
//  Created by Pedro Enrique on 11/13/11.
//  Copyright (c) 2011 Appcelerator. All rights reserved.
//

#import "TiLocationNotificationProxy.h"
#import "TiUtils.h"

@implementation TiLocationNotificationProxy

-(void)showNotification:(id)args
{
	if(args)
	{
		ENSURE_UI_THREAD_1_ARG(args);
		ENSURE_SINGLE_ARG(args, NSDictionary);
	}
	else
	{
		ENSURE_UI_THREAD_0_ARGS;
	}
	UILocalNotification *notification = [[UILocalNotification alloc] init];
	
	NSString *title = nil;
	NSString *viewButton = nil;
	
	if(args)
	{
	 	title = [args objectForKey:@"title"];
	 	viewButton = [args objectForKey:@"viewButton"];
	}
		
	notification.fireDate = [NSDate date];
	notification.alertBody = title;
	notification.alertAction = viewButton;
	notification.soundName = UILocalNotificationDefaultSoundName;

	[[UIApplication sharedApplication] scheduleLocalNotification:notification];
	[notification release];

}
@end
