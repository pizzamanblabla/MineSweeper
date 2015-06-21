//
//  MineSwapperCell.m
//  MineSwapper
//
//  Created by Eugene on 3/7/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "MineSweeperCell.h"
@interface MineSweeperCell()
@property (nonatomic,readwrite) Point positionInDeck;
@end
@implementation MineSweeperCell

-(instancetype) initWithPositionInDeck:(Point) position{
    self=[super init];
    if(position.h>=0 && position.v>=0){
        if(self){
            _positionInDeck.h=position.h;
            _positionInDeck.v=position.v;
               
        }
        return self;
    }else{
        return nil;
    }
}

-(NSUInteger) cellValue{
    
    
    if(!_cellValue){
        _cellValue=0;
    }
    return _cellValue;
}

-(BOOL) isShown{
    if(!_isShown){
        _isShown=NO;
    }
    return _isShown;
}

@end
