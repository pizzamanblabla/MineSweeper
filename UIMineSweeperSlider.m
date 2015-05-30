//
//  UIMineSweeperSlider.m
//  MineSwapper
//
//  Created by Eugene on 4/15/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "UIMineSweeperSlider.h"

@implementation UIMineSweeperSlider

-(instancetype) initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        [self setupAppearance];
    }
    return self;
}

-(void)setupAppearance{
    UIImage *sliderThumb = [[UIImage imageNamed:@"pin.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [self setThumbImage:sliderThumb forState:UIControlStateNormal];
    [self setThumbImage:sliderThumb forState:UIControlStateHighlighted];
    UIImage *sliderMinimum = [[UIImage imageNamed:@"frontSlider.png"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];
    [self setMinimumTrackImage:sliderMinimum forState:UIControlStateNormal];
    UIImage *sliderMaximum = [[UIImage imageNamed:@"backSlider.png"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];
    [self setMaximumTrackImage:sliderMaximum forState:UIControlStateNormal];
    
}
@end
