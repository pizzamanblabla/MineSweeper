//
//  MineSwapperCell.h
//  MineSwapper
//
//  Created by Eugene on 3/7/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineSweeperCell : NSObject
@property (nonatomic) BOOL isShown;
@property (nonatomic) BOOL isBomb;
@property (nonatomic) BOOL isFlag;
@property (nonatomic) NSUInteger cellValue;
@property (nonatomic,readonly) Point positionInDeck;
-(instancetype) initWithPositionInDeck:(Point) position;
@end
