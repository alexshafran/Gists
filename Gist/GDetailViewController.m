//
//  GDetailViewController.m
//  Gist
//
//  Created by Alex Shafran on 12/7/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "GDetailViewController.h"
#import <AFHTTPRequestOperation.h>
#import <UIView+Helpers.h>

@interface GDetailViewController () {
    
    UITextView *_textView;
}
@end

@implementation GDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frameSizeWidth, self.view.frameSizeHeight)];
    _textView.font = [UIFont fontWithName:@"Courier" size:14];
    _textView.alwaysBounceHorizontal = NO;
    _textView.editable = NO;
    _textView.dataDetectorTypes = UIDataDetectorTypeLink;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_textView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_itemDetail.rawUrl];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self loadSucceeded:responseObject];
     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self loadFailed:error];
        
    }];
    [operation start];
    
    self.title = _itemDetail.filename;
}

- (void)loadSucceeded:(id)result {
    
    _plaintext = [[NSString alloc] initWithData:(NSData*)result encoding:NSUTF8StringEncoding];
    [_textView setText:_plaintext];

}

- (void)loadFailed:(NSError*)error {
    
    NSLog(@"load failed: %@", error);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
