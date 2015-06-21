//
//  UICellDeckView.h
//  MineSwapper
//
//  Created by Eugene on 3/19/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICellDeckView : UIView
@property (strong,nonatomic) NSMutableArray *arrayOfCells;
@property (strong,nonatomic) NSMutableArray *arrayOfSuggestionsSizesOfCells;
-(instancetype)initWithQuantityOfCellsHorizotal:(int) rows QuantityOfCellsVertical:(int) columns;
-(void) drawDeckOfCellsWithQuantityOfCellsHorizotal:(int) rows QuantityOfCellsVertical:(int) columns;
-(void) calculateProbableSizesOfCell;
@end
