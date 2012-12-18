//
//  GGistListViewController.m
//  Gist
//
//  Created by Alex Shafran on 12/7/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "GGistListViewController.h"
#import "GHTTPClient.h"
#import "GistItem.h"
#import "NSDate+Helpers.h"
#import "GListViewCell.h"
#import "GDetailViewController.h"
#import "GistItemDetail.h"
#import "GFilesViewController.h"

#define kTableViewRowHeight         80.0f

@interface GGistListViewController () {
    
    NSMutableArray *_items;
}

@end

@implementation GGistListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = kTableViewRowHeight;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self loadData];
    
    self.title = @"gists";
    [self.navigationItem setHidesBackButton:YES];
}

#pragma mark - loading

- (void)loadData {
    
    [[GHTTPClient sharedClient] getAllGists:^(NSError *error, id result) {
        
        if (!error) {
            [self loadSucceeded:result];
        } else {
            [self loadFailed:error];
        }
    }];
}

- (void)loadSucceeded:(id)result {
    
    _items = [NSMutableArray new];
    
    for (NSDictionary *dict in result) {
        GistItem *item = [[GistItem alloc] initWithExternalRepresentation:dict];
        [_items addObject:item];
    }
    
    [self.refreshControl endRefreshing];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)loadFailed:(NSError*)error {
    
    NSLog(@"load failed: %@", error);
}

- (void)refreshControlPulled:(id)sender {
    
    [self loadData];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    GListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[GListViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    GistItem *item = _items[indexPath.row];
    cell.textLabel.textColor = item.isPublic ? [UIColor blackColor] : [UIColor colorWithRed:.2 green:0 blue:0 alpha:1];
    
    GistItemDetail *itemDetail;
    if ([[item.files allKeys] count] > 0) {
        itemDetail= [[GistItemDetail alloc] initWithExternalRepresentation:((NSDictionary*)item.files)[([(NSDictionary*)item.files allKeys])[0]]];
    }
    cell.textLabel.text = [itemDetail.filename length] > 0 ? itemDetail.filename : @"";
    
    NSDateFormatter *formatter = [GistItem dateFormatter];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@", item.description, [formatter stringFromDate:item.createdDate]];
    
    cell.dateLabel.text = [item.updatedDate stringDaysAgo];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GistItem *item = _items[indexPath.row];
    if ([[item.files allKeys] count] < 1) return;
    
    GistItemDetail *itemDetail = [[GistItemDetail alloc] initWithExternalRepresentation:(item.files)[([item.files allKeys])[0]]];
    itemDetail.description = item.description;
    itemDetail.isPublic = item.isPublic;
    itemDetail.htmlURL = item.htmlURL;
    itemDetail.uid = item.uid;
    
    if ([[item.files allKeys] count] == 1) {
        GDetailViewController *detailViewController = [[GDetailViewController alloc] initWithNibName:nil bundle:nil];
        detailViewController.itemDetail = itemDetail;
        [self.navigationController pushViewController:detailViewController animated:YES];
    } else {
        GFilesViewController *filesViewController = [[GFilesViewController alloc] initWithStyle:UITableViewStyleGrouped];
        filesViewController.fileNames = [item.files allKeys];
        filesViewController.item = item;
        [self.navigationController pushViewController:filesViewController animated:YES];
    }
    
}

@end
