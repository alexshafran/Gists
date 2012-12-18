//
//  GFilesViewController.h
//  Gist
//
//  Created by Alex Shafran on 12/18/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "GBaseTableViewController.h"
#import "GistItem.h"

@interface GFilesViewController : GBaseTableViewController

@property (nonatomic, strong) GistItem *item;
@property (nonatomic, strong) NSArray *fileNames;
@end
