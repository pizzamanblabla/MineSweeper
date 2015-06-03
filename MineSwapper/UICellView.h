//
//  UICellView.h
//  MineSwapper
//
//  Created by Eugene on 3/15/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MineSweeperDelegate.h"
@interface UICellView : UIView
@property (nonatomic,readonly) Point position;
@property (nonatomic) NSUInteger valueOfCell;
@property (nonatomic) BOOL isBomb;
@property (nonatomic) BOOL isHidden;
@property (nonatomic) BOOL isFlag;
@property (weak,nonatomic) id<MineSweeperDelegate> controllerDelegate;
-(instancetype)initWithFrame:(CGRect)frame andPosition:(Point)position;
-(void) drawValueOfCell;
-(void)updateUI;
@end
