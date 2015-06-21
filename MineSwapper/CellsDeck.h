//
//  CellsDeck.h
//  MineSwapper
//
//  Created by Eugene on 3/7/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MineSweeperCell.h"


@interface CellsDeck : NSObject
@property (strong,nonatomic) NSMutableArray *arrayOfCells;
@property (nonatomic) signed int bombs;
-(MineSweeperCell*)getCellByPosition:(Point) position;
-(instancetype)initWithQuantityOfCellsHorizotal:(NSUInteger) quantityOfCellsHorizontal QuantityOfCellsVertical:(NSUInteger) quantityOfCellsVertical quantityOfMines:(NSUInteger) quantityOfMines;
@end
