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
#import "MineSweeperPaletteTrance.h"
@implementation MineSweeperPaletteFactory
+(UIColor*) backgroundColorWithIndex:(int) index{
    switch (index) {
        case 0:
            return [MineSweeperPaletteDefault backgroundColor];
            break;
        case 1:
            return [MineSweeperPaletteTerra backgroundColor];
            break;
        case 2:
            return [MineSweeperPaletteTrance backgroundColor];
            break;
        default:
            return [MineSweeperPaletteDefault backgroundColor];
            break;
    }
    
    
}

+(UIColor*) fontHeaderColorWithIndex:(int) index{
    
    switch (index) {
        case 0:
            return [MineSweeperPaletteDefault fontHeaderColor];
            break;
        case 1:
            return [MineSweeperPaletteTerra fontHeaderColor];
            break;
        case 2:
            return [MineSweeperPaletteTrance fontHeaderColor];
            break;
        default:
            return [MineSweeperPaletteDefault fontHeaderColor];
            break;
    }

}

+(UIColor*) fontTextColorWithIndex:(int) index{
    
    switch (index) {
        case 0:
            return [MineSweeperPaletteDefault fontTextColor];
            break;
        case 1:
            return [MineSweeperPaletteTerra fontTextColor];
            break;
        case 2:
            return [MineSweeperPaletteTrance fontTextColor];
            break;
        default:
            return [MineSweeperPaletteDefault fontTextColor];
            break;
    }
  

}

+(UIColor*) backgroundCellColorWithIndex:(int) index{
    
    switch (index) {
        case 0:
            return [MineSweeperPaletteDefault backgroundCellColor];
            break;
        case 1:
            return [MineSweeperPaletteTerra backgroundCellColor];
            break;
        case 2:
            return [MineSweeperPaletteTrance backgroundCellColor];
            break;
        default:
            return [MineSweeperPaletteDefault backgroundCellColor];
            break;
    }

}

+(UIColor*) buttonTextColorWithIndex:(int) index{
    
    switch (index) {
        case 0:
            return [MineSweeperPaletteDefault buttonTextColor];
            break;
        case 1:
            return [MineSweeperPaletteTerra buttonTextColor];
            break;
        case 2:
            return [MineSweeperPaletteTrance buttonTextColor];
            break;
        default:
            return [MineSweeperPaletteDefault buttonTextColor];
            break;
    }
    

}

+(UIColor*) frontCellColorWithIndex:(int) index{
    
    switch (index) {
        case 0:
            return [MineSweeperPaletteDefault frontCellColor];
            break;
        case 1:
            return [MineSweeperPaletteTerra frontCellColor];
            break;
        case 2:
            return [MineSweeperPaletteTrance frontCellColor];
            break;
        default:
            return [MineSweeperPaletteDefault frontCellColor];
            break;
    }
    

}

+(UIColor*) buttonColorWithIndex:(int) index{
    
    switch (index) {
        case 0:
            return [MineSweeperPaletteDefault buttonColor];
            break;
        case 1:
            return [MineSweeperPaletteTerra buttonColor];
            break;
        case 2:
            return [MineSweeperPaletteTrance buttonColor];
            break;
        default:
            return [MineSweeperPaletteDefault buttonColor];
            break;
    }
  

}

+(UIColor*) borderCellFrontColorWithIndex:(int) index{
    
    switch (index) {
        case 0:
            return [MineSweeperPaletteDefault borderCellFrontColor];
            break;
        case 1:
            return [MineSweeperPaletteTerra borderCellFrontColor];
            break;
        case 2:
            return [MineSweeperPaletteTrance borderCellFrontColor];
            break;
        default:
            return [MineSweeperPaletteDefault borderCellFrontColor];
            break;
    }


}

+(UIColor*) borderCellBackgroundColorWithIndex:(int) index{
    
    switch (index) {
        case 0:
            return [MineSweeperPaletteDefault borderCellBackgroundColor];
            break;
        case 1:
            return [MineSweeperPaletteTerra borderCellBackgroundColor];
            break;
        case 2:
            return [MineSweeperPaletteTrance borderCellBackgroundColor];
            break;
        default:
            return [MineSweeperPaletteDefault borderCellBackgroundColor];
            break;
    }
    

}

+(UIColor*) backgroundCellColorOfBombExploded:(int) index{
    
    switch (index) {
        case 0:
            return [MineSweeperPaletteDefault backgroundCellColorOfBombExploded];
            break;
        case 1:
            return [MineSweeperPaletteTerra backgroundCellColorOfBombExploded];
            break;
        case 2:
            return [MineSweeperPaletteTrance backgroundCellColorOfBombExploded];
            break;
        default:
            return [MineSweeperPaletteDefault backgroundCellColorOfBombExploded];
            break;
    }
    
    
}

+(UIColor*) halfOpacityBackground:(int) index{
    
    switch (index) {
        case 0:
            return [MineSweeperPaletteDefault backgroundColor];
            break;
        case 1:
            return [MineSweeperPaletteTerra backgroundColor];
            break;
        case 2:
            return [MineSweeperPaletteTrance backgroundColor];
            break;
        default:
            return [MineSweeperPaletteDefault backgroundColor];
            break;
    }

}

@end
