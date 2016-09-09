//
//  CellsDeck.m
//  MineSwapper
//
//  Created by Eugene on 3/7/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "CellsDeck.h"
@interface CellsDeck()
@property (nonatomic) NSUInteger rows;
@property (nonatomic) NSUInteger columns;
@end
@implementation CellsDeck

#pragma mark - init

-(instancetype) initWithQuantityOfCellsHorizotal: (NSUInteger) quantityOfCellsHorizontal QuantityOfCellsVertical: (NSUInteger) quantityOfCellsVertical quantityOfMines: (NSUInteger) quantityOfMines {
    self = [super init];
    
    if (self) {
        [self createCellsWithQuantityOfCellsHorizontal: quantityOfCellsHorizontal Vertical: quantityOfCellsVertical];
        [self placeQuantityOfMines: quantityOfMines];
        self.rows = quantityOfCellsVertical;
        self.columns = quantityOfCellsHorizontal;
        self.bombs = (int) quantityOfMines;
    }
    
    return self;
}

#pragma mark - create cells

-(void) createCellsWithQuantityOfCellsHorizontal: (NSUInteger) quantityOfCellsHorizontal Vertical: (NSUInteger) quantityOfCellsVertical {
    for (int i = 1;i <= quantityOfCellsHorizontal;i++) {
        for (int n = 1;n <= quantityOfCellsVertical;n++) {
            Point positionInDeck = {i,n};
            MineSweeperCell *cell = [[MineSweeperCell alloc] initWithPositionInDeck:positionInDeck];
            
            if (!self.arrayOfCells) {
                self.arrayOfCells = [[NSMutableArray alloc] init];
            }
            
            [self.arrayOfCells addObject:cell];
        }
    }
}

-(void)placeQuantityOfMines: (NSUInteger) quantityOfMines {
    if (self.arrayOfCells) {
        for (int i = 0;i < quantityOfMines;i++) {
            NSUInteger indexOfMine = [self getIndexOfRandomCell];
            [self.arrayOfCells[indexOfMine] setIsBomb: YES];
            [self updateDeckWithCell: self.arrayOfCells[indexOfMine]];
        }
    }
}

-(NSUInteger) getIndexOfRandomCell {
     NSUInteger countOfCells = [self.arrayOfCells count];
     NSUInteger indexOfMine = arc4random()%countOfCells;
    
    if ([self.arrayOfCells[indexOfMine] isBomb]) {
        return [self getIndexOfRandomCell];
    } else {
        return indexOfMine;
    }
}


-(void) updateDeckWithCell: (MineSweeperCell*) cell {
    int x = 0,y = 0;
    
    for (int i = 0;i < 8;i++){
        switch (i) {
            case 0:
                 x=-1;
                 y=-1;
                break;
            case 1:
                x=0;
                y=-1;
                break;
            case 2:
                x=-1;
                y=0;
                break;
            case 3:
                x=1;
                y=1;
                break;
            case 4:
                x=1;
                y=-1;
                break;
            case 5:
                x=-1;
                y=1;
                break;
            case 6:
                x=0;
                y=1;
                break;
            case 7:
                x=1;
                y=0;
                break;
                
            default:
                break;
        }
        
        Point cellAroundBomb = cell.positionInDeck;
        cellAroundBomb.h += y;
        cellAroundBomb.v += x;
        MineSweeperCell* cell = [self getCellByPosition:cellAroundBomb];
        
        if (cell) {
            if (!cell.isBomb) {
                if (!cell.cellValue) {
                    cell.cellValue = 0;
                }
                
                cell.cellValue += 1;
            } else {
                cell.cellValue = 0;
            }
        }
    }
}

-(MineSweeperCell*) getCellByPosition: (Point) position {
    for (MineSweeperCell *cell in self.arrayOfCells) {
        if ([self comparePositionWithPoint: position AndPoint: cell.positionInDeck]) {
            return cell;
        }
    }
    
    return nil;
}



-(void) increaseCellValue:(Point) cellPoint {
    for( MineSweeperCell *cell in self.arrayOfCells) {
        if ([self comparePositionWithPoint: cellPoint AndPoint: cell.positionInDeck]) {
            if (!cell.cellValue) {
                cell.cellValue = 0;
            }
            
            cell.cellValue++;
        }
    }
}

-(BOOL) comparePositionWithPoint: (Point) point AndPoint: (Point) comparablePoint {
    return point.h == comparablePoint.h && point.v == comparablePoint.v;
}

@end
