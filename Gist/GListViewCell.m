//
//  GListViewCell.m
//  Gist
//
//  Created by Alex Shafran on 12/7/12.
//  Copyright (c) 2012 WillowTree Apps, Inc. All rights reserved.
//

#import "GListViewCell.h"
#import <UIView+Helpers.h>

#define kDateLabelWidth             100.0f
#define kDateLabelPadding           20.0f

@implementation GListViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        _dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateLabel.frame = CGRectMake(self.frameSizeWidth - kDateLabelWidth - kDateLabelPadding,
                                      12, kDateLabelWidth, 20);
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.font = [UIFont fontWithName:self.detailTextLabel.font.fontName size:14];
        _dateLabel.textColor = [UIColor colorWithRed:250.0/255.0f green:130.0f/255.0f blue:0.0f alpha:1];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_dateLabel];
        
        self.textLabel.highlightedTextColor = [UIColor blackColor];
        self.detailTextLabel.highlightedTextColor = [UIColor grayColor];
        
        UIView *highlightView = [[UIView alloc] initWithFrame:self.frame];
        highlightView.backgroundColor = [UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:176.0f/255.0f alpha:01.0f];
        self.selectedBackgroundView = highlightView;
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

@end
