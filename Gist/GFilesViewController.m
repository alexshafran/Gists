//
//  GFilesViewController.m
//  Gist
//
//  Created by Alex Shafran on 12/18/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "GFilesViewController.h"
#import "GDetailViewController.h"
#import <UIView+Helpers.h>

@interface GFilesViewController ()

@end

@implementation GFilesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height)];
    backgroundView.backgroundColor = [UIColor colorWithRed:140.0f/255 green:206.0f/255 blue:236.0f/255 alpha:.5];
    self.tableView.backgroundView = backgroundView;
    
    self.refreshControl = nil;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.title = @"files";
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_fileNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:cell.frame];
    backgroundView.frameSizeWidth = 300;
    backgroundView.backgroundColor = [UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:176.0f/255.0f alpha:1.0f];
    
    if (indexPath.row == 0) {
            [backgroundView roundCornersTopLeft:8 topRight:8 bottomLeft:0 bottomRight:0];
    } else if (indexPath.row == [_fileNames count] - 1) {
            [backgroundView roundCornersTopLeft:0 topRight:0 bottomLeft:8 bottomRight:8];
    }
    
    cell.selectedBackgroundView = backgroundView;
    cell.textLabel.text = _fileNames[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GistItemDetail *itemDetail = [[GistItemDetail alloc] initWithExternalRepresentation:(_item.files)[_fileNames[indexPath.row]]];
    GDetailViewController *detailViewController = [[GDetailViewController alloc] initWithNibName:nil bundle:nil];
    detailViewController.itemDetail = itemDetail;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end

