//
//  GAppDelegate.m
//  Gist
//
//  Created by Alex Shafran on 12/6/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "GAppDelegate.h"
#import "GHTTPClient.h"
#import "GGistListViewController.h"
#import "GLoginViewController.h"

#define kForceLogin         0

@implementation GAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    GHTTPClient *client = [GHTTPClient newClient];
    [GHTTPClient setSharedClient:client];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:50.0/255.0 green:100.0/255.0 blue:150.0/255.0 alpha:1.0]];

    UIViewController *rootViewController;
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken] length] < 1 || kForceLogin) {
        rootViewController = [[GLoginViewController alloc] init];
    } else {
        rootViewController = [[GGistListViewController alloc] init];
    }
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    self.window.rootViewController = nc;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
