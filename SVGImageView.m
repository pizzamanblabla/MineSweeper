//
//  SVGImageView.m
//  MineSwapper
//
//  Created by Eugene on 6/8/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "SVGImageView.h"
#import "PocketSVG.h"
@interface SVGImageView()
@property (nonatomic,strong) NSString* image;
@end
@implementation SVGImageView
-(instancetype) initWithFrame:(CGRect)frame andImageNamed:(NSString*) image{
    self=[super initWithFrame:frame];
    
    
    if(self){
        NSLog(@"setImage");
        self.image=image;
        
        
    }
    
    return self;
}

-(void) drawRect:(CGRect)rect{
    NSLog(@"drawRect");
    CGPathRef myPath = [PocketSVG pathFromSVGFileNamed:self.image];
   // NSLog(@"self %@",);
    CGPathGetPathBoundingBox(myPath);
    UIBezierPath *path=[UIBezierPath bezierPathWithCGPath:myPath];
    //[path addClip];
    // path.bounds.size.height=self.bounds.size.height;
    //[path applyTransform:]
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor]setStroke];
    [path stroke];
    CGFloat scale = 1.9;
   [path applyTransform:CGAffineTransformMakeScale(scale, scale)];
    CGSize translation = CGSizeMake(100, 5);
    [path applyTransform:CGAffineTransformMakeTranslation(translation.width,
                                                          translation.height)];
    NSLog(@"self %f path %f",self.bounds.size.height,CGPathGetPathBoundingBox(myPath).size.height);
    NSLog(@"self %f path %f",self.bounds.size.width,CGPathGetPathBoundingBox(myPath).size.width);

    
}
@end
