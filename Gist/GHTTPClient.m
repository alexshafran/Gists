//
//  GHTTPClient.m
//  Gist
//
//  Created by Alex Shafran on 12/7/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "GHTTPClient.h"

static GHTTPClient *_sharedHTTPClient = nil;

typedef void (^GHTTPClientSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^GHTTPClientFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@implementation GHTTPClient

+ (void)setSharedClient:(GHTTPClient*)client {
    @synchronized(self)
    {
        _sharedHTTPClient = client;
    }
}

+ (id)newClient {
    
    return [[self alloc] initWithBaseURL:[NSURL URLWithString:kGistBaseUrl]];
}

+ (id)sharedClient {
    
    return _sharedHTTPClient;
}

- (NSString*)accessToken {
    
    return [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken];
}
- (NSDictionary*)defaultParameters {
    
    NSString *token = [self accessToken];
    if ([token length] > 0) {
        return @{kAccessToken : token};
    } else return nil;
}

#pragma mark - GET

- (void)getAllGists:(GHTTPClientCompletionBlock)completion {
    
    self.parameterEncoding = AFJSONParameterEncoding;
    
    [self getPath:[NSString stringWithFormat:@"%@%@%@", kPathForUsers, @"/alexshafran", kPathForAllGists]
       parameters:[self defaultParameters]
          success:[self handleSuccess:completion]
          failure:[self handleFailure:completion]];
    
}

- (void)editGist:(NSString*)uid content:(NSDictionary*)content completion:(GHTTPClientCompletionBlock)completion {
 
    [self patchPath:[NSString stringWithFormat:@"%@/%@?%@=%@", kPathForAllGists, uid, kAccessToken, [self accessToken]]
         parameters:content
            success:[self handleSuccess:completion]
            failure:[self handleFailure:completion]];
}

- (GHTTPClientSuccessBlock)handleSuccess:(GHTTPClientCompletionBlock)completion {
    
    return ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError *error = nil;
        id object = responseObject;
        
        if ([responseObject isKindOfClass:[NSData class]])
            object = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        
        if (error && completion)
            completion(error, nil);
        
        else if (completion)
            completion(nil, object);
        
    };
}

- (GHTTPClientFailureBlock)handleFailure:(GHTTPClientCompletionBlock)completion {
    
    return ^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(error, nil);
    };
}

@end
