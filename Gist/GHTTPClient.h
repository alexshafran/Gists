//
//  GHTTPClient.h
//  Gist
//
//  Created by Alex Shafran on 12/7/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFHTTPClient.h>
#import "GHTTPUrlDefinitions.h"

typedef void (^GHTTPClientCompletionBlock)(NSError *error, id result);

@interface GHTTPClient : AFHTTPClient

+ (id)newClient;
+ (id)sharedClient;
+ (void)setSharedClient:(GHTTPClient*)client;

// requests
- (void)getAllGists:(GHTTPClientCompletionBlock)completion;
- (void)editGist:(NSString*)uid content:(NSDictionary*)content completion:(GHTTPClientCompletionBlock)completion;

@end
