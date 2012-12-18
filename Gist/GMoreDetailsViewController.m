//
//  GMoreDetailsViewController.m
//  Gist
//
//  Created by Alex Shafran on 12/18/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "GMoreDetailsViewController.h"
#import <UIView+Helpers.h>

@interface GMoreDetailsViewController () {
    
}

@end

@implementation GMoreDetailsViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.refreshControl = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.title = @"detail";
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 2;
    else return 1;
    
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 1) return @"Description";
    else return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        if (indexPath.row == 0) {
            
            UIView *backgroundView = [[UIView alloc] initWithFrame:cell.frame];
            backgroundView.frameSizeWidth = 300;
            backgroundView.backgroundColor = [UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:176.0f/255.0f alpha:1.0f];
            [backgroundView roundCornersTopLeft:8 topRight:8 bottomLeft:0 bottomRight:0];
            cell.selectedBackgroundView = backgroundView;
            
            cell.textLabel.text = @"Filename";
            cell.detailTextLabel.text = _itemDetail.filename;

        } else if (indexPath.row == 1) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"Private";
            UISwitch *sw = [[UISwitch alloc] init];
            sw.on = ! _itemDetail.isPublic;
            cell.accessoryView = sw;
        }
        
        return cell;
        
    } else if (indexPath.section == 1) {
        
        static NSString *CellIdentifier = @"Cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            [cell.textLabel setFont:[UIFont systemFontOfSize:17]];
            cell.selectionStyle = UITableViewCellEditingStyleNone;
        }
        
        cell.textLabel.text = _itemDetail.description;
        return cell;
    } else {
        
        static NSString *CellIdentifier = @"Cell3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.textLabel.text = @"Delete this Gist";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.backgroundColor = [UIColor redColor];
        }
        
        return cell;
    }

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
