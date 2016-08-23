//
//  PocketSVG+LayerMaker.m
//  MineSwapper
//
//  Created by Eugene on 6/7/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "PocketSVG+LayerMaker.h"
#import "MineSweeperPaletteFactory.h"
@implementation PocketSVG (LayerMaker)
+(CAShapeLayer*) makeShapeLayerWithSVG:(NSString*) image andFrame:(CGRect) frame {
    CGPathRef myPath = [PocketSVG pathFromSVGFileNamed:image];
    CAShapeLayer *myShapeLayer = [CAShapeLayer layer];
    myShapeLayer.path = myPath;
    myShapeLayer.strokeColor = [MineSweeperPaletteFactory fontHeaderColorWithIndex:PALETTE].CGColor;
    myShapeLayer.lineWidth = 0.5;
    myShapeLayer.fillColor = [MineSweeperPaletteFactory fontTextColorWithIndex:PALETTE].CGColor;

    float height = frame.size.height/CGPathGetPathBoundingBox(myPath).size.height;
    myShapeLayer.transform = CATransform3DMakeScale(height, height, 1);
    
       return myShapeLayer;
}

+(CAShapeLayer*) makeShapeLayerWithSVG:(NSString*) image andFrame:(CGRect)frame andColor:(UIColor*) color {
    CGPathRef myPath = [PocketSVG pathFromSVGFileNamed:image];
    CAShapeLayer *myShapeLayer = [CAShapeLayer layer];
    myShapeLayer.path = myPath;
    myShapeLayer.strokeColor = [MineSweeperPaletteFactory fontHeaderColorWithIndex:PALETTE].CGColor;
    myShapeLayer.lineWidth = 0.5;
    myShapeLayer.fillColor = color.CGColor;
    float height=frame.size.height/CGPathGetPathBoundingBox(myPath).size.height;
    myShapeLayer.transform = CATransform3DMakeScale(height, height, 1);

    return myShapeLayer;
}


+(CAShapeLayer*) configureShapeLayer:(CAShapeLayer*) layer withFrame:(CGRect)frame{
    
    CAShapeLayer *myShapeLayer=[[CAShapeLayer alloc] init];
    myShapeLayer.path=layer.path;
    myShapeLayer.strokeColor = [MineSweeperPaletteFactory fontTextColorWithIndex:PALETTE].CGColor;
    myShapeLayer.lineWidth = 0.5;
    myShapeLayer.fillColor = [MineSweeperPaletteFactory fontTextColorWithIndex:PALETTE].CGColor;
    float height=frame.size.height/CGPathGetPathBoundingBox(layer.path).size.height;
    myShapeLayer.transform = CATransform3DMakeScale(height, height, 1);
    
    return myShapeLayer;
}
@end
