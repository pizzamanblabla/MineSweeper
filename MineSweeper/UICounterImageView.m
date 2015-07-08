//
//  UICounterImageView.m
//  MineSwapper
//
//  Created by Eugene on 5/31/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "UICounterImageView.h"
#import "MineSweeperPaletteFactory.h"
#import "PocketSVG+LayerMaker.h"

@interface UICounterImageView()

@property (strong,nonatomic) UIView *imageView;
@property (strong,nonatomic) NSString *image;
@end
@implementation UICounterImageView

-(instancetype) initWithFrame:(CGRect)frame andImage:(NSString*)image{
    self=[super initWithFrame:frame];
    if(self){
        self.image=image;
       
        [self addSubview:self.label];

        [self addSubview:self.imageView];
        
    }
    
    return self;
}

-(UILabelWithOffset*) label{
    
    if(!_label){
     
        CGRect frame=CGRectMake(0, 0, self.frame.size.width-self.frame.size.height, self.frame.size.height);
        
        _label=[[UILabelWithOffset alloc] initWithFrame:frame];
        _label.text=@"0";
        _label.font=[UIFont fontWithName:@"Futura" size:self.frame.size.height*0.8];
        _label.textColor=[MineSweeperPaletteFactory fontHeaderColorWithIndex:PALETTE];
        _label.textAlignment=NSTextAlignmentRight;
        _label.adjustsFontSizeToFitWidth = YES;
        
    }
   // [_label sizeToFit];
    return _label;
}

-(UIView*) imageView{
    if(!_imageView){
        CGRect frame=CGRectMake((self.frame.size.width-self.frame.size.height), 0, self.frame.size.height, self.frame.size.height);
        _imageView=[[UIView alloc] initWithFrame:frame];
        _imageView.backgroundColor=[MineSweeperPaletteFactory backgroundColorWithIndex:PALETTE];
        if(self.image){
            CAShapeLayer *ShapeLayer=[PocketSVG makeShapeLayerWithSVG:self.image andFrame:frame];
            [_imageView.layer addSublayer:ShapeLayer];
        }
    }
    return _imageView;
}

@end
