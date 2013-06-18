//
//  AppDelegate.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/14/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

#import "MainViewController.h"
#define kObserver @"vcRadioButtonItemFromGroupSelected"


@implementation AppDelegate
@synthesize fvalueGlobalString,fvalueString,arrayCustodianID,custodianID,index;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        { self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone4" bundle:nil];
        }
        if(result.height == 568)
        {
            self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
//            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
//            self.window.rootViewController = navController;
            
            navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
            navigationController.navigationBarHidden = NO;
            navigationController.navigationBar.tag = 42;
            
            self.window.rootViewController = navigationController;

            
            //[self.view addSubview:navigationController.view];


        }
    } else {
        
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
        self.window.rootViewController = self.viewController;
        
    }
    
    // Create MainViewController instance
    //MainViewController *mainViewController = [[MainViewController alloc] init];
    
    // Set mainViewController backgroud color
	//mainViewController.view.backgroundColor = [UIColor lightGrayColor];
	
    
    // Add mainViewController to window
	//[self.window addSubview:mainViewController.view];
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
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
