//
//  UIAdditionalInformationView.h
//  MineSwapper
//
//  Created by Eugene on 5/22/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAdditionalInformationView : UIView
@property (strong,nonatomic) UIView *options;
-(void) showViewWithAnimation:(BOOL)hidden;
-(void) initilizeViewUI;
-(CGRect) getRectBoundsWithNumberInView:(float)number;
@end
