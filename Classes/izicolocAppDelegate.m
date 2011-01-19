//
//  izicolocAppDelegate.m
//  izicoloc
//
//  Created by rt on 19/01/11.
//  Copyright 2011 Insa de Lyon. All rights reserved.
//

#import "izicolocAppDelegate.h"

#import "HomeViewController.h"
#import "MessageViewController.h"
#import "CorveeViewController.h"
#import "DepensesViewController.h"
#import "CoursesViewController.h"

@implementation izicolocAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Home View Controller
	HomeViewController* homevc = [[[HomeViewController alloc] init] autorelease];
	UINavigationController* navHomeVc = [[[UINavigationController alloc] initWithRootViewController:homevc] autorelease];
	
	// Message View Controller 
	MessageViewController* messagevc = [[[MessageViewController alloc] init] autorelease];
	UINavigationController* navMessageVc = [[[UINavigationController alloc] initWithRootViewController:messagevc] autorelease];
	
	// Corvee View Controller
	CorveeViewController* corveevc = [[[CorveeViewController alloc] init] autorelease];
	UINavigationController* navCorveeVc = [[[UINavigationController alloc] initWithRootViewController:corveevc] autorelease];
	
	// Depenses View Controller
	DepensesViewController* depensesvc = [[[DepensesViewController alloc] init] autorelease];
	UINavigationController* navDepensesVc = [[[UINavigationController alloc] initWithRootViewController:depensesvc] autorelease];
	
	// Courses View Controller
	CoursesViewController* coursesvc = [[[CoursesViewController alloc] init] autorelease];
	UINavigationController* navCoursesVc = [[[UINavigationController alloc] initWithRootViewController:coursesvc] autorelease];
	
	// Load the TabBar
	UITabBarController* tbvc = [[UITabBarController alloc] init];
	tbvc.viewControllers = [NSArray arrayWithObjects:navHomeVc, navMessageVc, navCorveeVc, navCoursesVc, navDepensesVc,  nil];
    
	// Display the tabBar's view
	[self.window addSubview:tbvc.view];
	
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	
    [window release];
    [super dealloc];
}


@end
