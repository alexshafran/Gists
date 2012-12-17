//
//  GistItemDetail.h
//  Gist
//
//  Created by Alex Shafran on 12/7/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "MTLModel.h"

@interface GistItemDetail : MTLModel

@property (nonatomic, copy) NSString *filename;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, assign) BOOL isPublic;
@property (nonatomic, copy) NSURL *rawUrl;

@end
