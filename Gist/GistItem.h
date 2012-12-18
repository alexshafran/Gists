//
//  GistItem.h
//  Gist
//
//  Created by Alex Shafran on 12/7/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import <MTLModel.h>
#import "GistItemDetail.h"

@interface GistItem : MTLModel

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSNumber *numComments;
@property (nonatomic, assign) BOOL isPublic;
@property (nonatomic, copy) NSURL *commentsURL;
@property (nonatomic, copy) NSDate *createdDate;
@property (nonatomic, copy) NSDate *updatedDate;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSDictionary *files;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, copy) NSURL *htmlURL;
@property (nonatomic, copy) NSURL *avatarURL;
@property (nonatomic, copy) GistItemDetail *itemDetail;

+ (NSDateFormatter *)dateFormatter;

@end
