//
//  GistItemDetail.m
//  Gist
//
//  Created by Alex Shafran on 12/7/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "GistItemDetail.h"
#import <NSDictionary+MTLManipulationAdditions.h>
#import <NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@implementation GistItemDetail

+ (NSDictionary*)externalRepresentationKeyPathsByPropertyKey {
    
    return [[super externalRepresentationKeyPathsByPropertyKey] mtl_dictionaryByAddingEntriesFromDictionary: @{
            @"rawUrl" : @"raw_url",
            }];
    
}

+ (NSValueTransformer *)rawUrlTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)htmlURLTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
