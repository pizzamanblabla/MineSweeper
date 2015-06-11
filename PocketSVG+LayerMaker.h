//
//  PocketSVG+LayerMaker.h
//  MineSwapper
//
//  Created by Eugene on 6/7/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "PocketSVG.h"

@interface PocketSVG (LayerMaker)
+(CAShapeLayer*) makeShapeLayerWithSVG:(NSString*) image andFrame:(CGRect)frame;
@end
