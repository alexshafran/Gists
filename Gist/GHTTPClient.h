//
//  GHTTPClient.h
//  Gist
//
//  Created by Alex Shafran on 12/7/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFHTTPClient.h>

typedef void (^GHTTPClientCompletionBlock)(NSError *error, id result);

@interface GHTTPClient : AFHTTPClient

@property (nonatomic, strong) NSString *accessToken;

+ (id)newClient;
+ (id)sharedClient;
+ (void)setSharedClient:(GHTTPClient*)client;

// requests
- (void)getAllGists:(GHTTPClientCompletionBlock)completion;

@end