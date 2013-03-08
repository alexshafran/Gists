//
//  GLoginView.m
//  Gist
//
//  Created by Alex Shafran on 3/7/13.
//  Copyright (c) 2013 WillowTree Apps, Inc. All rights reserved.
//

#import "GLoginView.h"
#import <UIView+Helpers.h>

@implementation GLoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _userField = [self textfieldWithSize:CGSizeMake(290, 40)];
        _userField.frameOrigin = CGPointMake(15, [[UIScreen mainScreen] bounds].size.height > 480 ? 90 : 30);
        _userField.placeholder = @"username";
        _userField.returnKeyType = UIReturnKeyNext;
        [self addSubview:_userField];
        
        _passwordField = [self textfieldWithSize:_userField.frameSize];
        _passwordField.frameOrigin = CGPointMake(_userField.frameOriginX, CGRectGetMaxY(_userField.frame) + 15);
        _passwordField.placeholder = @"password";
        _passwordField.secureTextEntry = YES;
        _passwordField.returnKeyType = UIReturnKeyDone;
        [self addSubview:_passwordField];
        
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.frame = CGRectMake(_userField.frameOriginX,
                                       CGRectGetMaxY(_passwordField.frame) + 15,
                                       _userField.frameSizeWidth,
                                       50);
        _loginButton.frameOriginY = CGRectGetMaxY(_passwordField.frame) + 15;
        _loginButton.backgroundColor = [UIColor colorWithRed:245.0f/255 green:245.0f/255 blue:160.0f/255 alpha:1];
        [_loginButton setTitle:@"Git-R-Done" forState:UIControlStateNormal];
        [_loginButton.titleLabel setFont:[UIFont fontWithName:@"Collegiate" size:26]];
        [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self addSubview:_loginButton];
        
    }
    return self;
}

#pragma mark - Textfield config

- (UITextField*)textfieldWithSize:(CGSize)size {
    
    UITextField *textField = [[UITextField alloc] initWithSize:size];
    textField.backgroundColor = [UIColor whiteColor];
    textField.font = [UIFont fontWithName:@"Collegiate" size:26];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    return textField;
}

@end
