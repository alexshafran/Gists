//
//  GLoginViewController.m
//  Gist
//
//  Created by Alex Shafran on 12/17/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "GLoginViewController.h"
#import <UIView+Helpers.h>
#import "GHTTPClient.h"
#import "GGistListViewController.h"

@interface GLoginViewController () {
    
    UITextField *_userField;
    UITextField *_passField;
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
    
    self.title = @"Login";
    
    self.view.backgroundColor = [UIColor colorWithRed:140.0f/255 green:206.0f/255 blue:236.0f/255 alpha:1];
    
    _userField = [self textfieldWithSize:CGSizeMake(290, 40)];
    _userField.frameOrigin = CGPointMake(15, [[UIScreen mainScreen] bounds].size.height > 480 ? 90 : 30);
    _userField.placeholder = @"username";
    _userField.returnKeyType = UIReturnKeyNext;
    [self.view addSubview:_userField];
    
    _passField = [self textfieldWithSize:_userField.frameSize];
    _passField.frameOrigin = CGPointMake(_userField.frameOriginX, CGRectGetMaxY(_userField.frame) + 15);
    _passField.placeholder = @"password";
    _passField.secureTextEntry = YES;
    _passField.returnKeyType = UIReturnKeyDone;
    _passField.delegate = self;
    [self.view addSubview:_passField];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(_userField.frameOriginX,
                                   CGRectGetMaxY(_passField.frame) + 15,
                                   _userField.frameSizeWidth,
                                   50);
    loginButton.frameOriginY = CGRectGetMaxY(_passField.frame) + 15;
    loginButton.backgroundColor = [UIColor colorWithRed:245.0f/255 green:245.0f/255 blue:160.0f/255 alpha:1];
    [loginButton setTitle:@"Git-R-Done" forState:UIControlStateNormal];
    [loginButton.titleLabel setFont:[UIFont fontWithName:@"Collegiate" size:26]];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    
}

#pragma mark - textfield

- (UITextField*)textfieldWithSize:(CGSize)size {
    
    UITextField *textField = [[UITextField alloc] initWithSize:size];
    textField.backgroundColor = [UIColor whiteColor];
    textField.font = [UIFont fontWithName:@"Collegiate" size:26];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    return textField;
}

#pragma mark - button callbacks

- (void)loginButtonPressed:(id)sender {
    
    [self login];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _passField) {
        [self login];
    }
    
    return YES;
}

#pragma mark - login

- (void)login {
    
    if (![[_userField text] length] || ![[_passField text] length])
         return;
    
    NSDictionary *params = @{
                            @"scopes" : @[kScope],
                            @"client_id" : kClientID,
                            @"client_secret" : kClientSecret
                            };
    
    [[GHTTPClient sharedClient] setParameterEncoding:AFJSONParameterEncoding];
    [[GHTTPClient sharedClient] setAuthorizationHeaderWithUsername:[_userField text] password:[_passField text]];
    [[GHTTPClient sharedClient] postPath:kPathForAuthorizations
                              parameters:params
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     NSError *error;
                                     id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
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
