//
//  UIAdditionalInformationView.h
//  MineSwapper
//
//  Created by Eugene on 5/22/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineSweeperPaletteFactory.h"

@interface UIAdditionalInformationView : UIView
@property (strong,nonatomic) UIView *options;
-(void) initilizeViewUI;
-(CGRect) getRectBoundsWithNumberInView:(float)number;
-(void) showViewWithAnimation:(BOOL)hidden;

@end
