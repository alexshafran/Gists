//
//  GBaseTableViewController.m
//  Gist
//
//  Created by Alex Shafran on 12/7/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "GBaseTableViewController.h"
#import "UILabel+Shadow.h"

@interface GBaseTableViewController ()

@end

@implementation GBaseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl = refreshControl;
    refreshControl.tintColor = [[UINavigationBar appearance] tintColor];
    [refreshControl addTarget:self action:@selector(refreshControlPulled:) forControlEvents:UIControlEventValueChanged];
}

- (void)setTitle:(NSString *)title {
    
    [super setTitle:title];
    // had to do this bc cheap fonts have jacked up alignments
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Collegiate" size:26];
    label.text = [title lowercaseString];
    label.textAlignment = NSTextAlignmentCenter;
    [label addTextShadow];
    [label sizeToFit];
    self.navigationItem.titleView = label;
}

- (void)refreshControlPulled:(id)sender {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
