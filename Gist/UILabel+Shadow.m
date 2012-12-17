//
//  UILabel+Shadow.m
//  AllStarEvents
//
//  Created by Alex Shafran on 11/26/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "UILabel+Shadow.h"
#import <QuartzCore/QuartzCore.h>

@implementation UILabel (Shadow)

- (void)addTextShadow {
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, - 1.0f);
    self.layer.shadowOpacity = 0.75f;
    self.clipsToBounds = NO;
    self.layer.shadowRadius = 0.5f;
}

@end
