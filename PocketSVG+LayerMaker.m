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
+(CAShapeLayer*) makeShapeLayerWithSVG:(NSString*) image andFrame:(CGRect)frame{
    CGPathRef myPath = [PocketSVG pathFromSVGFileNamed:image];
    
    CAShapeLayer *myShapeLayer = [CAShapeLayer layer];
    myShapeLayer.path = myPath;
    
    myShapeLayer.strokeColor = [MineSweeperPaletteFactory fontTextColorWithIndex:0].CGColor;
    myShapeLayer.lineWidth = 0.5;
    myShapeLayer.fillColor = [MineSweeperPaletteFactory fontTextColorWithIndex:0].CGColor;
   // myShapeLayer.shadowColor=[UIColor blackColor].CGColor;
    //myShapeLayer.shadowOpacity=0.8;
   // myShapeLayer.shadowRadius=5.0;
    float height=frame.size.height/CGPathGetPathBoundingBox(myPath).size.height;
   // float width=frame.size.width/CGPathGetPathBoundingBox(myPath).size.width;
   
    
    myShapeLayer.transform = CATransform3DMakeScale(height, height, 1);
    //myShapeLayer.position=CGPointMake(frame.origin.x, frame.origin.y);
    
       return myShapeLayer;
}
@end
