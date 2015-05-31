//
//  UICounterImageView.m
//  MineSwapper
//
//  Created by Eugene on 5/31/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "UICounterImageView.h"
@interface UICounterImageView()

@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UIImage *image;
@end
@implementation UICounterImageView

-(instancetype) initWithFrame:(CGRect)frame andImage:(UIImage*)image{
    self=[super initWithFrame:frame];
    if(self){
        self.image=image;
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        
    }
    
    return self;
}

-(UILabelWithOffset*) label{
    
    if(!_label){
     
        CGRect frame=CGRectMake(0, 0, self.frame.size.width-self.frame.size.height, self.frame.size.height);
        
        _label=[[UILabelWithOffset alloc] initWithFrame:frame];
        _label.text=@"0";
        _label.font=[UIFont fontWithName:@"Futura" size:self.frame.size.height*0.8];
        _label.textAlignment=NSTextAlignmentRight;
        
        
    }
    return _label;
}

-(UIImageView*) imageView{
    if(!_imageView){
        CGRect frame=CGRectMake((self.frame.size.width-self.frame.size.height), 0, self.frame.size.height, self.frame.size.height);
        _imageView=[[UIImageView alloc] initWithImage:self.image];
        _imageView.frame=frame;
        
    }
    
    return _imageView;
}

@end
