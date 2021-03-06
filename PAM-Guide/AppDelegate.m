//
//  AppDelegate.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/14/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "JASidePanelController.h"
#import "MainViewController.h"
#import "HasilInvestasiViewController.h"
#import "leftwindowViewController.h"
#define kObserver @"vcRadioButtonItemFromGroupSelected"


@implementation AppDelegate
@synthesize fvalueGlobalString,fvalueString,arrayCustodianID,custodianID,index;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setCenter:)
												name:@"dealNotification"
											  object:nil];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.viewControllers = [[JASidePanelController alloc] init];
	[self setCenter:nil];
	self.viewControllers.leftPanel=[[leftwindowViewController alloc]init];
	self.window.rootViewController = self.viewControllers;
    [self.window makeKeyAndVisible];
	self.viewControllers.leftFixedWidth = 375;
    return YES;
}
-(void)setCenter:(NSNotification *)name{
	NSMutableArray *dict = (NSMutableArray*)name.object;
	if(name==nil){
		self.viewControllers.centerPanel = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
	}
	else if([[dict objectAtIndex:0] isEqualToString:@"Hasil Investasi"]){
		self.viewControllers.centerPanel = [[HasilInvestasiViewController alloc]init];
	
	}
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    fvalueGlobalString = [[NSMutableString alloc]init];
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
