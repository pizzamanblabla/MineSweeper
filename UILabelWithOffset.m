//
//  UILabelWithOffset.m
//  MineSwapper
//
//  Created by Eugene on 5/31/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "UILabelWithOffset.h"

@implementation UILabelWithOffset

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 10, 0, 10};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
