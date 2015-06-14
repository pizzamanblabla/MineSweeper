//
//  MineSweeperPalette.h
//  MineSwapper
//
//  Created by Eugene on 6/6/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UIColor+NormalRGB.h"
@protocol MineSweeperPalette <NSObject>

+(UIColor*) backgroundColor;
+(UIColor*) fontHeaderColor;
+(UIColor*) fontTextColor;
+(UIColor*) buttonColor;
+(UIColor*) buttonTextColor;
+(UIColor*) frontCellColor;
+(UIColor*) backgroundCellColor;
+(UIColor*) borderCellFrontColor;
+(UIColor*) borderCellBackgroundColor;
+(UIColor*) backgroundCellColorOfBombExploded;
+(UIColor*) halfOpacityBackground;
@end
