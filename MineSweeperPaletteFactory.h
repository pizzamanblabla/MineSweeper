//
//  MineSweeperPaletteFactory.h
//  MineSwapper
//
//  Created by Eugene on 6/6/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "PaletteConstant.h"
@interface MineSweeperPaletteFactory : NSObject
+(UIColor*) backgroundColorWithIndex:(int) index;
+(UIColor*) fontHeaderColorWithIndex:(int) index;
+(UIColor*) fontTextColorWithIndex:(int) index;
+(UIColor*) buttonColorWithIndex:(int) index;
+(UIColor*) buttonTextColorWithIndex:(int) index;
+(UIColor*) frontCellColorWithIndex:(int) index;
+(UIColor*) backgroundCellColorWithIndex:(int) index;
+(UIColor*) borderCellFrontColorWithIndex:(int) index;
+(UIColor*) borderCellBackgroundColorWithIndex:(int) index;
+(UIColor*) backgroundCellColorOfBombExploded:(int) index;
+(UIColor*) halfOpacityBackground:(int) index;
@end
