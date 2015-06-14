//
//  MineSweeperPaletteFactory.m
//  MineSwapper
//
//  Created by Eugene on 6/6/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "MineSweeperPaletteFactory.h"
#import "MineSweeperPaletteDefault.h"
@implementation MineSweeperPaletteFactory
+(UIColor*) backgroundColorWithIndex:(int) index{
    
    return [MineSweeperPaletteDefault backgroundColor];
}

+(UIColor*) fontHeaderColorWithIndex:(int) index{
    
   return [MineSweeperPaletteDefault fontHeaderColor];
}

+(UIColor*) fontTextColorWithIndex:(int) index{
    
    return [MineSweeperPaletteDefault fontTextColor];
}

+(UIColor*) backgroundCellColorWithIndex:(int) index{
    
    return [MineSweeperPaletteDefault backgroundCellColor];
}

+(UIColor*) buttonTextColorWithIndex:(int) index{
    
    return [MineSweeperPaletteDefault buttonTextColor];
}

+(UIColor*) frontCellColorWithIndex:(int) index{
    
    return [MineSweeperPaletteDefault frontCellColor];
}

+(UIColor*) buttonColorWithIndex:(int) index{
    
   return [MineSweeperPaletteDefault buttonColor];
}

+(UIColor*) borderCellFrontColorWithIndex:(int) index{
    
   return [MineSweeperPaletteDefault borderCellFrontColor];
}

+(UIColor*) borderCellBackgroundColorWithIndex:(int) index{
    
    return [MineSweeperPaletteDefault borderCellBackgroundColor];
}

+(UIColor*) backgroundCellColorOfBombExploded:(int) index{
    
    return [MineSweeperPaletteDefault backgroundCellColorOfBombExploded];
    
}

+(UIColor*) halfOpacityBackground:(int) index{
    
    return [MineSweeperPaletteDefault backgroundColor];
}

@end
