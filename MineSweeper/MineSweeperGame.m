//
//  MineSweeperGame.m
//  MineSwapper
//
//  Created by Eugene on 3/24/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "MineSweeperGame.h"

@interface MineSweeperGame()
@property (readwrite,nonatomic) NSUInteger score;
@property (nonatomic) float gameValue;
@end
@implementation MineSweeperGame

#pragma mark - init

-(instancetype) initWithRows:(int) rows Columns:(int) columns Bombs:(int) bombs {
    self = [super init];
    
    if (self) {
        self.gameValue = (rows*columns*rows*columns)*bombs;
        self.cellsDeck = [[CellsDeck alloc] initWithQuantityOfCellsHorizotal:rows QuantityOfCellsVertical:columns quantityOfMines:bombs];
    }
    
    return self;
}

#pragma mark - updating model

-(NSUInteger) calculateScore: (int) time {
    self.score = self.gameValue / time;
    return self.score;
    
}

-(void) flagCellWithPosition: (Point) position {
    MineSweeperCell *cell = [self.cellsDeck getCellByPosition:position];
    
    if (!cell.isShown) {
        cell.isFlag = !cell.isFlag;
        
        if (cell.isFlag) {
            self.cellsDeck.bombs--;
        } else {
            self.cellsDeck.bombs++;
        }
    }
}

-(BOOL) checkIsLose {
    for (MineSweeperCell *cell in self.cellsDeck.arrayOfCells) {
        if (
            cell.isBomb &&
            !cell.isFlag &&
            cell.isShown
        ) {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL) ckeckIsGameOver {
    for (MineSweeperCell *cell in self.cellsDeck.arrayOfCells) {
        if(!cell.isShown && !cell.isFlag) {
            return NO;
        }
    }
    
    if (!self.cellsDeck.bombs) {
        return YES;
    } else {
        return NO;
    }
}

-(void) openCellsAroundWithPosition:(Point) position{
    MineSweeperCell *mainCell = [self.cellsDeck getCellByPosition:position];
    
    if (mainCell) {
        if (!mainCell.isBomb) {
            if (!mainCell.isFlag) {
                mainCell.isShown = YES;
            }
            
            if (mainCell.cellValue == 0) {
                int x = 0,y = 0;
                
                for (int i = 0;i < 8;i++) {
                    switch (i) {
                        case 0:
                            x = -1;
                            y = -1;
                            break;
                            
                        case 1:
                            x = 0;
                            y = -1;
                            break;
                            
                        case 2:
                            x = -1;
                            y = 0;
                            break;
                            
                        case 3:
                            x = 1;
                            y = 1;
                            break;
                            
                        case 4:
                            x = 1;
                            y = -1;
                            break;
                            
                        case 5:
                            x = -1;
                            y = 1;
                            break;
                            
                        case 6:
                            x = 0;
                            y = 1;
                            break;
                            
                        case 7:
                            x=1;
                            y=0;
                            break;
        
                        default:
                            break;
                    }
        
                    Point point = {position.v + x, position.h + y};
                    MineSweeperCell *cell = [self.cellsDeck getCellByPosition:point];
        
                    if (cell.cellValue == 0 && !cell.isShown) {
                        if (!(cell.positionInDeck.v == 0 && cell.positionInDeck.h == 0)){
                            [self openCellsAroundWithPosition:cell.positionInDeck];
                        }
                    } else {
                        if(!cell.isFlag){
                            cell.isShown = YES;
                        }
                    }
                }
            }
        } else {
            for (MineSweeperCell *cell in self.cellsDeck.arrayOfCells) {
                if (cell.isFlag) {
                    if ([self checkIsLose]) {
                        cell.isShown = YES;
                    }
                } else {
                    cell.isShown = YES;
                }
            }
        }
    }
}

@end
