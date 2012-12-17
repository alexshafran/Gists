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

@implementation GAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    GHTTPClient *client = [GHTTPClient newClient];
    [GHTTPClient setSharedClient:client];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:50.0/255.0 green:100.0/255.0 blue:150.0/255.0 alpha:1.0]];
    
    GLoginViewController *loginController = [[GLoginViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:loginController];
    self.window.rootViewController = nc;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
