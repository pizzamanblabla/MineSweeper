//
//  UIAdditionalInformationView.m
//  MineSwapper
//
//  Created by Eugene on 5/22/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "UIAdditionalInformationView.h"
@interface UIAdditionalInformationView()

@property (nonatomic) float vertical;
@property (nonatomic) float horizontal;
@end
@implementation UIAdditionalInformationView

-(instancetype) initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if(self){
        
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self initilizeViewUI];
       [self addSubview:self.options];
       
    }
    return self;
}


-(instancetype) init{
    
    self=[[UIAdditionalInformationView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    return self;
}

-(instancetype) initWithFrame:(CGRect) frame Horizontal:(float)horizontal Vertical:(float) vertical{
    
    self=[[UIAdditionalInformationView alloc] initWithFrame:frame];
    
    if(self){
        self.vertical=vertical;
        self.horizontal=horizontal;
    }
    return self;
}

#pragma mark - initialize


-(float) vertical{
    
    if(!_vertical){
        
        _vertical=0.4;
    }
    
    return _vertical;
}

-(float) horizontal{
    
    if(!_horizontal){
        
        _horizontal=0.6;
    }
    
    return _horizontal;
}

-(void) initilizeViewUI{
    
    
}


-(void) showViewWithAnimation:(BOOL)hidden{
    
    if(hidden){
        CGRect originFrame=self.options.frame;
        [UIView animateWithDuration:0.5 delay:0
                            options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                
                                self.options.frame=CGRectMake(originFrame.origin.x,-self.frame.size.height,originFrame.size.width,originFrame.size.height);
                                [self setAlpha:0.0f];
                                
                            } completion:^(BOOL isFinish){
                                self.hidden=hidden;
                                self.options.frame =  originFrame;
                            }];
    }else{
        CGRect originFrame=self.options.frame;
        self.options.frame=CGRectMake(originFrame.origin.x,-self.frame.size.height,originFrame.size.width,originFrame.size.height);
        self.hidden=hidden;
        
        [UIView animateWithDuration:0.5 delay:0
                            options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                [self setAlpha:1.0f];
                                self.options.frame =  originFrame;
                            } completion:nil];
        
    }
}



-(UIView*)options{
    
    if(!_options){
        
        float height=(self.frame.origin.y+self.frame.size.height)*self.vertical;
        float width=(self.frame.origin.x + self.frame.size.width)*self.horizontal;
        float x=(self.frame.size.width-width)/2;
        float y=(self.frame.size.height-height)/2;
        CGPoint point={x,y};
        CGSize size={width,height};
        CGRect options={point,size};
        
        _options=[[UIView alloc] initWithFrame:options];
        _options.backgroundColor=[UIColor whiteColor];
        _options.layer.cornerRadius=10;
        _options.backgroundColor=[MineSweeperPaletteFactory backgroundColorWithIndex:0];
    }
    
    return _options;
    
}



-(CGRect) getRectBoundsWithNumberInView:(float)number{
    float height=self.options.frame.size.height*0.2;
    float width=self.options.frame.size.width*0.8;
    float x=self.options.frame.size.width*0.1;
    float y=self.options.frame.size.height*0.05+height*number;
    CGPoint point={x,y};
    CGSize size={width,height};
    CGRect options={point,size};
    return options;
}

-(CGRect) getRectLabelWithView:(UIView*) view{
    
    
    float height=self.options.frame.size.height*0.1;
    float width=self.options.frame.size.width*0.8;
    float x=self.options.frame.size.width*0.5-width/2;
    float y=view.frame.size.height+view.frame.origin.y;
    CGPoint point={x,y};
    CGSize size={width,height};
    CGRect options={point,size};
    return options;
    
    
    
}



@end
