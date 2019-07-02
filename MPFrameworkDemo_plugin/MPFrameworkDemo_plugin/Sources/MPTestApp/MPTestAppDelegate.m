//
//  MPTestAppDelegate.m
//  APMusic
//
//  Created by Jason on 3/21/16.
//  Copyright (c) 2016 Jason. All rights reserved.
//

#import "MPTestAppDelegate.h"
#import "MPTestAppViewController.h"

@interface MPTestAppDelegate ()
{
}

@property(nonatomic, strong) UIViewController *rootController;

@end

///////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation MPTestAppDelegate

- (UIViewController *)rootControllerInApplication:(DTMicroApplication *)application
{
    return self.rootController;
}

- (void)applicationDidCreate:(DTMicroApplication *)application
{
}

- (void)application:(DTMicroApplication *)application willStartLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.rootController = [[MPTestAppViewController alloc] init];
}

- (void)application:(DTMicroApplication *)application willResumeWithOptions:(NSDictionary *)options
{
}

- (void)applicationDidFinishLaunching:(DTMicroApplication *)application
{
}

- (void)applicationWillPause:(DTMicroApplication *)application
{
}

- (void)applicationWillTerminate:(DTMicroApplication *)application
{
}

- (void)applicationDidResume:(DTMicroApplication *)application
{
}

@end