//
//  UICounterImageView.h
//  MineSwapper
//
//  Created by Eugene on 5/31/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//
#import "UILabelWithOffset.h"
#import <UIKit/UIKit.h>

@interface UICounterImageView : UIView
@property (strong,nonatomic) UILabelWithOffset *label;
-(instancetype) initWithFrame:(CGRect)frame andImage:(UIImage*)image;
@end
