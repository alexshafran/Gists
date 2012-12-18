//
//  GDetailViewController.m
//  Gist
//
//  Created by Alex Shafran on 12/7/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "GDetailViewController.h"
#import "GHTTPClient.h"
#import <AFHTTPRequestOperation.h>
#import <UIView+Helpers.h>

@interface GDetailViewController () {
    
    UITextView *_textView;
    
    UIBarButtonItem *_actionItem;
    UIBarButtonItem *_saveButton;
    UIBarButtonItem *_cancelButton;
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
    
    [super viewDidLoad];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frameSizeWidth, self.view.frameSizeHeight)];
    _textView.font = [UIFont fontWithName:@"Courier" size:14];
    _textView.alwaysBounceHorizontal = NO;
    _textView.editable = NO;
    _textView.dataDetectorTypes = UIDataDetectorTypeLink;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_textView];
    
    _actionItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                target:self
                                                                                action:@selector(actionButtonPressed:)];
    
    _saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                target:self
                                                                                action:@selector(saveButtonPressed:)];
    
    _cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                  target:self
                                                                  action:@selector(cancelButtonPressed:)];
    
    [self.navigationItem setRightBarButtonItem:_actionItem];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
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

#pragma mark - button callbacks

- (void)actionButtonPressed:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Options"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Edit", @"View Details", @"Share", @"Delete", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    NSLog(@"action sheet index: %d", buttonIndex);
    
    switch (buttonIndex) {
        case 0:
            [self setIsEditing:YES];
            break;
        case 1:
            [self viewDetails];
            break;
        case 2:
            [self share];
            break;
        case 3:
            [self deleteGist];
            break;
        default:
            break;
    }
}

- (void)setIsEditing:(BOOL)isEditing {
    
    _isEditing = isEditing;
    _textView.editable = isEditing;
    if (isEditing) {
        [_textView becomeFirstResponder];
    }
    
    [self.navigationItem setRightBarButtonItem:(isEditing ? _saveButton : _actionItem) animated:YES];
    [self.navigationItem setLeftBarButtonItem:(isEditing ? _cancelButton : nil) animated:YES];
    
}

- (void)viewDetails {
    
    GMoreDetailsViewController *detailViewController = [[GMoreDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    detailViewController.itemDetail = [_itemDetail copy];
    detailViewController.delegate = self;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (void)share {
    
    
}

- (void)deleteGist {
    
    
}

- (void)cancelButtonPressed:(id)sender {
    
    [self setIsEditing:NO];
}

- (void)saveButtonPressed:(id)sender {
    
    [self save];
    [self setIsEditing:NO];
}

#pragma mark - saving

- (void)save {
    
}

#pragma mark - more info delegate

- (void)moreDetailsViewControllerDidEditItem:(GistItemDetail*)item {
    
    NSDictionary *content =
                            @{
                                @"description" : [item.description length] > 0 ? item.description : @"",
                                @"files" : @{
                                    _itemDetail.filename : @{
                                        @"filename" : item.filename,
                                        @"content" : [_textView text]
                                    }
                                }
    
                            };
    
    _itemDetail = item;
    [self setTitle:item.filename];
    
    [[GHTTPClient sharedClient] editGist:item.uid
                                 content:content
                              completion:^(NSError *error, id result) {
                                  if (!error) {
                                      [self uploadSucceeded:result];
                                  } else {
                                      [self uploadFailed:error];
                                  }
                                  
                              }];
}

- (void)uploadSucceeded:(id)result {
    
    NSLog(@"result: %@", result);
}

- (void)uploadFailed:(NSError*)error {
    
    
}

@end
