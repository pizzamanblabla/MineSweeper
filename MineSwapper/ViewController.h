//
//  ViewController.h
//  MineSwapper
//
//  Created by Eugene on 3/7/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICellDeckView.h"
@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICellDeckView *cells;
-(void) setStartGameOptions;
-(void) touchedCell:(Point) position;
-(void) flagedCell:(Point) position;
-(void) updateViewWithRows:(int) rows andColumns:(int) columns Bombs:(int)bombs updateModel:(BOOL) update;
@end

