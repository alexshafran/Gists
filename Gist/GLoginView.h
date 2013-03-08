//
//  GLoginView.h
//  Gist
//
//  Created by Alex Shafran on 3/7/13.
//  Copyright (c) 2013 WillowTree Apps, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLoginView : UIView

@property (nonatomic, strong) UITextField *userField;
@property (nonatomic, strong) UITextField *passwordField;

@property (nonatomic, strong) UIButton *loginButton;
@end
