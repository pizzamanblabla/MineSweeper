//
//  MineSweeperGame.h
//  MineSwapper
//
//  Created by Eugene on 3/24/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellsDeck.h"
@interface MineSweeperGame : NSObject
@property (readonly,nonatomic) NSUInteger score;
@property (strong,nonatomic) CellsDeck *cellsDeck;
-(void) openCellsAroundWithPosition:(Point)position;
-(void) flagCellWithPosition:(Point)position;
-(BOOL) ckeckIsGameOver;
-(instancetype) initWithRows:(int)rows Columns:(int) columns Bombs:(int) bombs;
-(NSUInteger) calculateScore:(int) time;
@end
