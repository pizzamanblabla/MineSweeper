//
//  MineSweeperGame.m
//  MineSwapper
//
//  Created by Eugene on 3/24/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "MineSweeperGame.h"
#import "MineSwapperCell.h"

@interface MineSweeperGame()
@property (readwrite,nonatomic) NSUInteger score;
@property (nonatomic) float gameValue;
@end
@implementation MineSweeperGame



-(void) flagCellWithPosition:(Point)position{
    MineSwapperCell *cell=[self.cellsDeck getCellByPosition:position];
    if(!cell.isShown){
        cell.isFlag=!cell.isFlag;
        if(cell.isFlag){
            self.cellsDeck.bombs--;
        }else{
            self.cellsDeck.bombs++;
        }
    }
}

-(BOOL) ckeckIsGameOver{
    
    for( MineSwapperCell *cell in self.cellsDeck.arrayOfCells){
        if(!cell.isShown && !cell.isFlag){
            return NO;
        }
    }
    return YES;
}

-(NSUInteger) calculateScore:(int) time{
    
    self.score=self.gameValue/time;
    return self.score;
    
}

-(void) openCellsAroundWithPosition:(Point)position{
    
    MineSwapperCell *mainCell=[self.cellsDeck getCellByPosition:position];
    if(mainCell){
        if(!mainCell.isBomb){
    mainCell.isShown=YES;
        if(mainCell.cellValue==0){
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
        
        Point point={position.v+x,position.h+y};
        MineSwapperCell *cell=[self.cellsDeck getCellByPosition:point];
        
        
        if(cell.cellValue==0 && cell.isShown==NO){
                
            if(!(cell.positionInDeck.v==0 && cell.positionInDeck.h==0)){
                [self openCellsAroundWithPosition:cell.positionInDeck];}
                    }
        else{
            if(cell.isFlag==NO){
                cell.isShown=YES;
            }
        }
    }
        
    }
        }
        else{
            for (MineSwapperCell *cell in self.cellsDeck.arrayOfCells){
                
                cell.isShown=YES;
                cell.isFlag=NO;
                
            }
        }
    }
}

-(instancetype) initWithRows:(int)rows Columns:(int) columns Bombs:(int) bombs{
    self=[super init];
    if(self){
        self.gameValue=(100000*rows*columns)/bombs;
        self.cellsDeck=[[CellsDeck alloc] initWithQuantityOfCellsHorizotal:rows QuantityOfCellsVertical:columns quantityOfMines:bombs];
        
    }
    return self;
}


@end
