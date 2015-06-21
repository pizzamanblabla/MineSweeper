//
//  UITimerView.m
//  MineSwapper
//
//  Created by Eugene on 4/16/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "UITimerView.h"

@implementation UITimerView

- (void)drawTextInRect:(CGRect)rect {
   UIEdgeInsets insets = {0, 5, 0, 5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
