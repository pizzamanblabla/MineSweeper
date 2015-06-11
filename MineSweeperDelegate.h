//
//  MineSweeperDelegate.h
//  MineSwapper
//
//  Created by Eugene on 6/4/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MineSweeperDelegate <NSObject>
@property (strong,nonatomic) NSCache *SVGCache;
-(void) touchedCell:(Point) position;
-(void) flagedCell:(Point) position;
@end
