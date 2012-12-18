//
//  GDetailViewController.h
//  Gist
//
//  Created by Alex Shafran on 12/7/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBaseViewController.h"
#import "GistItemDetail.h"

@interface GDetailViewController : GBaseViewController <UIActionSheetDelegate>

@property (nonatomic, strong) GistItemDetail *itemDetail;
@property (nonatomic, strong) NSString *plaintext;
@property (nonatomic, assign) BOOL isEditing;

@end
