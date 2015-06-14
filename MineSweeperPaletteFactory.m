//
//  MineSweeperPaletteFactory.m
//  MineSwapper
//
//  Created by Eugene on 6/6/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "MineSweeperPaletteFactory.h"
#import "MineSweeperPaletteDefault.h"
#import "MineSweeperPaletteTerra.h"
@implementation MineSweeperPaletteFactory
+(UIColor*) backgroundColorWithIndex:(int) index{
    
    return [MineSweeperPaletteDefault backgroundColor];
     //return [MineSweeperPaletteTerra backgroundColor];
}

+(UIColor*) fontHeaderColorWithIndex:(int) index{
    
   return [MineSweeperPaletteDefault fontHeaderColor];
   // return [MineSweeperPaletteTerra fontHeaderColor];

}

+(UIColor*) fontTextColorWithIndex:(int) index{
    
    return [MineSweeperPaletteDefault fontTextColor];
   // return [MineSweeperPaletteTerra fontTextColor];

}

+(UIColor*) backgroundCellColorWithIndex:(int) index{
    
    return [MineSweeperPaletteDefault backgroundCellColor];
   // return [MineSweeperPaletteTerra backgroundCellColor];

}

+(UIColor*) buttonTextColorWithIndex:(int) index{
    
   return [MineSweeperPaletteDefault buttonTextColor];
   // return [MineSweeperPaletteTerra buttonTextColor];

}

+(UIColor*) frontCellColorWithIndex:(int) index{
    
    return [MineSweeperPaletteDefault frontCellColor];
   // return [MineSweeperPaletteTerra frontCellColor];

}

+(UIColor*) buttonColorWithIndex:(int) index{
    
   return [MineSweeperPaletteDefault buttonColor];
    //return [MineSweeperPaletteTerra buttonColor];

}

+(UIColor*) borderCellFrontColorWithIndex:(int) index{
    
   return [MineSweeperPaletteDefault borderCellFrontColor];
   // return [MineSweeperPaletteTerra borderCellFrontColor];

}

+(UIColor*) borderCellBackgroundColorWithIndex:(int) index{
    
    return [MineSweeperPaletteDefault borderCellBackgroundColor];
   // return [MineSweeperPaletteTerra borderCellBackgroundColor];

}

+(UIColor*) backgroundCellColorOfBombExploded:(int) index{
    
    return [MineSweeperPaletteDefault backgroundCellColorOfBombExploded];
   // return [MineSweeperPaletteTerra backgroundCellColorOfBombExploded];

    
}

+(UIColor*) halfOpacityBackground:(int) index{
    
    return [MineSweeperPaletteDefault backgroundColor];
   // return [MineSweeperPaletteTerra backgroundColor];
}

@end
