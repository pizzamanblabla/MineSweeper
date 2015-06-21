//
//  UIOptionsView.h
//  MineSwapper
//
//  Created by Eugene on 4/8/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAdditionalInformationView.h"
#import "ViewController.h"
@interface UIOptionsView : UIAdditionalInformationView
@property (weak,nonatomic) ViewController *controllerDelegate;
-(void) updateViewWithModel:(BOOL)update;
-(void) submitOptions;
@end
