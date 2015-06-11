//
//  UIColor+NormalRGB.m
//  MineSwapper
//
//  Created by Eugene on 6/6/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "UIColor+NormalRGB.h"

@implementation UIColor (NormalRGB)
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha {
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}
@end
