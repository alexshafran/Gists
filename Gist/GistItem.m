//
//  GistItem.m
//  Gist
//
//  Created by Alex Shafran on 12/7/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "GistItem.h"
#import <NSDictionary+MTLManipulationAdditions.h>
#import <NSValueTransformer+MTLPredefinedTransformerAdditions.h>
#import <MTLValueTransformer.h>

@implementation GistItem

+ (NSDictionary*)externalRepresentationKeyPathsByPropertyKey {

    return [[super externalRepresentationKeyPathsByPropertyKey] mtl_dictionaryByAddingEntriesFromDictionary: @{
        @"uid" : @"id",
        @"numComments" : @"comments",
        @"isPublic" : @"public",
        @"commentsURL" : @"comments_url",
        @"createdDate" : @"created_at",
        @"updatedDate" : @"updated_at",
        @"htmlURL" : @"html_url",
        @"avatarURL" : @"avatar_url"
    }];
    
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}

+ (NSValueTransformer *)commentsURLTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)urlTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)htmlURLTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)avatarURLTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)itemDetailTransformer {
    return [NSValueTransformer mtl_externalRepresentationTransformerWithModelClass:[GistItemDetail class]];
}

+ (NSValueTransformer *)createdDateTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)updatedDateTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

@end
