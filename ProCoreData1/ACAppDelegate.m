//
//  YTAppDelegate.m
//  ProCoreData1
//
//  Created by Aleksey on 03.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import "ACAppDelegate.h"
#import "ACTeamsViewController.h"
#import "ACDataManager.h"

@implementation ACAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[ACDataManager sharedManager] setLoggingAllowed:NO];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ACTeamsViewController alloc] initWithNibName:@"ACTeamsViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[ACTeamsViewController alloc] initWithNibName:@"ACTeamsViewController_iPad" bundle:nil];
    }
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
