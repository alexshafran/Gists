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
    
    UIWebView *_webView;
}

@end

@implementation GLoginViewController

#define kLoginURLPath               @"https://github.com/login/oauth/authorize"
#define kClientID                   @"7f22b2fda1b4525fa519"
#define kClientSecret               @"e31d0900160e5b0979c9caeb9181fa7f55d93fbc"
#define kRedirectURI                @"https://gist.shafran.com"
#define kScopeList                  @"gist"

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

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frameSizeWidth, self.view.frameSizeHeight)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSString *loginPath = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&scope=%@",
                           kLoginURLPath,
                           kClientID,
                           kRedirectURI,
                           kScopeList];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:loginPath]];
    [_webView loadRequest:request];
    
    self.title = @"Logging in...";
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([request.URL.absoluteString rangeOfString:@"code="].location != NSNotFound) {
        
        NSString *code = [request.URL.absoluteString substringFromIndex:[request.URL.absoluteString rangeOfString:@"="].location + 1];
        
        NSDictionary *params = @{
                                @"client_id" : kClientID,
                                @"redirect_uri" : kRedirectURI,
                                @"client_secret" : kClientSecret,
                                @"code" : code
                                };
        
        [[GHTTPClient sharedClient] postPath:@"https://github.com/login/oauth/access_token"
                                  parameters:params
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         [self tokenReceived:responseObject];
                                     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         [self requestFailed:error];
                                         
         }];
        
        return NO;
    }
    
    return YES;
}

- (void)tokenReceived:(id)result {
    
    NSString *tokenString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    int startLocation = [tokenString rangeOfString:@"="].location + 1;
    int endLocation = [tokenString rangeOfString:@"&token_type"].location;
    tokenString = [tokenString substringWithRange:NSMakeRange(startLocation, endLocation - startLocation)];
    NSLog(@"token: %@", tokenString);
    
    [[GHTTPClient sharedClient] setAccessToken:tokenString];
    
    GGistListViewController *listViewController = [[GGistListViewController alloc] init];
    [self.navigationController pushViewController:listViewController animated:YES];

    
}

- (void)requestFailed:(NSError*)error {
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
