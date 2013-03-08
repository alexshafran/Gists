//
//  GLoginViewController.m
//  Gist
//
//  Created by Alex Shafran on 12/17/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "GLoginViewController.h"
#import "GLoginView.h"
#import <UIView+Helpers.h>
#import "GHTTPClient.h"
#import "GGistListViewController.h"

@interface GLoginViewController () {
    
    GLoginView *_loginView;
}

@end

@implementation GLoginViewController

#define kClientID                   @"7f22b2fda1b4525fa519"
#define kClientSecret               @"e31d0900160e5b0979c9caeb9181fa7f55d93fbc"
#define kScope                      @"gist"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Login to github";
    
    self.view.backgroundColor = [UIColor colorWithRed:140.0f/255 green:206.0f/255 blue:236.0f/255 alpha:1];
    
    GLoginView *loginView = [[GLoginView alloc] initWithFrame:self.view.bounds];

    [loginView.userField setDelegate:self];
    [loginView.passwordField setDelegate:self];
    
    [loginView.loginButton addTarget:self
                              action:@selector(loginButtonPressed:)
                    forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginView];
    _loginView = loginView;
    
    
}

#pragma mark - button callbacks

- (void)loginButtonPressed:(id)sender {
    
    [self login];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _loginView.userField) {
        [_loginView.passwordField becomeFirstResponder];
    }
    else if (textField == _loginView.passwordField) {
        [self login];
    }
    
    return YES;
}

#pragma mark - login

- (void)login {
    
    if (![[_loginView.userField text] length] || ![[_loginView.passwordField text] length])
         return;
    
    NSDictionary *params = @{
                            @"scopes" : @[kScope],
                            @"client_id" : kClientID,
                            @"client_secret" : kClientSecret
                            };
    
    [[GHTTPClient sharedClient] setParameterEncoding:AFJSONParameterEncoding];
    [[GHTTPClient sharedClient] setAuthorizationHeaderWithUsername:[_loginView.userField text]
                                                          password:[_loginView.passwordField text]];
    
    [[GHTTPClient sharedClient] postPath:kPathForAuthorizations
                              parameters:params
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     NSError *error;
                                     id json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                               options:0
                                                                                 error:&error];
                                     if (!error) {
                                         [self tokenReceived:json];
                                     } else {
                                         [self loadFailed:error];
                                     }
                                 }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     [self loadFailed:error];
                                 }];
    
}


- (void)tokenReceived:(id)result {
    
    NSString *token = [result valueForKey:@"token"];
    NSLog(@"logged in with token: %@", token);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:token forKey:kAccessToken];
    [defaults synchronize];
    
    
    GGistListViewController *listViewController = [[GGistListViewController alloc] init];
    [self.navigationController pushViewController:listViewController animated:YES];

}

- (void)loadFailed:(NSError*)error {
    
    
}

@end
