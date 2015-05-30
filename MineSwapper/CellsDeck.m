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
@property (nonatomic) NSUInteger bombs;
@end
@implementation CellsDeck

-(instancetype)initWithQuantityOfCellsHorizotal:(NSUInteger) quantityOfCellsHorizontal QuantityOfCellsVertical:(NSUInteger) quantityOfCellsVertical quantityOfMines:(NSUInteger) quantityOfMines{
    self=[super init];
    if(self){
        [self createCellsWithQuantityOfCellsHorizontal:quantityOfCellsHorizontal Vertical:quantityOfCellsVertical];
        [self placeQuantityOfMines:quantityOfMines];
        self.rows=quantityOfCellsVertical;
        self.columns=quantityOfCellsHorizontal;
        self.bombs=quantityOfMines;
    }
    return self;
}

-(void)placeQuantityOfMines:(NSUInteger) quantityOfMines{
    if(self.arrayOfCells){
        for(int i=0;i<quantityOfMines;i++){
            NSUInteger indexOfMine=[self getIndexOfRandomCell];
            [self.arrayOfCells[indexOfMine]  setIsBomb:YES];
            [self updateDeckWithCell:self.arrayOfCells[indexOfMine]];
        }
    }
}

-(NSUInteger) getIndexOfRandomCell{
     NSUInteger countOfCells=[self.arrayOfCells count];
     NSUInteger indexOfMine=arc4random()%countOfCells;
    if([self.arrayOfCells[indexOfMine] isBomb]){
        return [self getIndexOfRandomCell];
    }else{
    return indexOfMine;
    }
}


-(void)updateDeckWithCell:(MineSwapperCell*) cell{
    int x=0,y=0;
    for(int i=0;i<8;i++){
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
        Point cellAroundBomb=cell.positionInDeck;
        cellAroundBomb.h+=y;
        cellAroundBomb.v+=x;
        MineSwapperCell* cell=[self getCellByPosition:cellAroundBomb];
        if(cell){
            if(!cell.isBomb){
            if(!cell.cellValue){
                cell.cellValue=0;
            }
                cell.cellValue+=1;
            }
            else{cell.cellValue=0;}
        }
    }
}

-(MineSwapperCell*)getCellByPosition:(Point) position{
    for( MineSwapperCell *cell in self.arrayOfCells){
        if(position.h==cell.positionInDeck.h && position.v==cell.positionInDeck.v){
                       return cell;
        }
    }
    return nil;
}



-(void) increaseCellValue:(Point) cellPoint{
    for( MineSwapperCell *cell in self.arrayOfCells){
        if(cellPoint.h==cell.positionInDeck.h && cellPoint.v==cell.positionInDeck.v){
            if(!cell.cellValue){
                cell.cellValue=0;
            }
            cell.cellValue++;
        }
    }
}


-(void)createCellsWithQuantityOfCellsHorizontal:(NSUInteger)quantityOfCellsHorizontal Vertical:(NSUInteger)quantityOfCellsVertical{
    for(int i=1;i<=quantityOfCellsHorizontal;i++){
        for(int n=1;n<=quantityOfCellsVertical;n++){
            Point positionInDeck={i,n};
            MineSwapperCell *cell=[[MineSwapperCell alloc] initWithPositionInDeck:positionInDeck];
            if(!self.arrayOfCells){
                self.arrayOfCells=[[NSMutableArray alloc] init];
            }
            
            [self.arrayOfCells addObject:cell];
        }
    }
}
@end
