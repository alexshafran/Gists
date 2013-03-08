//
//  GMoreDetailsViewController.h
//  Gist
//
//  Created by Alex Shafran on 12/18/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "GBaseTableViewController.h"
#import "GistItemDetail.h"

@protocol GMoreDetailViewControllerDelegate <NSObject>

@optional
- (void)moreDetailsViewControllerDidEditItem:(GistItemDetail*)item;

@end

@interface GMoreDetailsViewController : GBaseTableViewController <UIAlertViewDelegate>

@property (nonatomic) BOOL editablePrivacy;
@property (nonatomic, strong) GistItemDetail *itemDetail;
@property (nonatomic, weak) id <GMoreDetailViewControllerDelegate> delegate;

@end
