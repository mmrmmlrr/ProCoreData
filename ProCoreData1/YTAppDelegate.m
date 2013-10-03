//
//  YTAppDelegate.m
//  ProCoreData1
//
//  Created by Aleksey on 03.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import "YTAppDelegate.h"
#import "YTViewController.h"
#import "YTDataManager.h"

@implementation YTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Initializing CoreData layer
    
    
    //
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[YTViewController alloc] initWithNibName:@"YTViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[YTViewController alloc] initWithNibName:@"YTViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
