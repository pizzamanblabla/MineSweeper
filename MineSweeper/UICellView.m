//
//  UICellView.m
//  MineSwapper
//
//  Created by Eugene on 3/15/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "UICellView.h"
#import "MineSweeperPaletteFactory.h"
#import "PocketSVG+LayerMaker.h"
#import <AudioToolbox/AudioToolbox.h>
@interface UICellView()
@property (nonatomic,readwrite) Point position;
@property (strong,nonatomic) UIView *Image;
@property (nonatomic) CAShapeLayer *imageLayer;
@property (nonatomic) SystemSoundID tapSound;
@property (nonatomic) SystemSoundID flagSound;


@end
@implementation UICellView

#pragma mark - init

-(instancetype)initWithFrame:(CGRect)frame andPosition:(Point)position{
    
    self=[super initWithFrame:frame];
    if(self){
        self.position=position;
        self.isShown=NO;
        self.isFlag=NO;
        [self addSubview:self.Image];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGesture];
        UILongPressGestureRecognizer *pressGesture=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlePressGesture:)];
        [self addGestureRecognizer:pressGesture];
    }
    return self;
}




#pragma mark - properties

-(void) setIsShown:(BOOL)isShown{
    _isShown=isShown;
    if(isShown){
        
        if(!self.isBomb && self.isFlag){
            self.Image.backgroundColor=[MineSweeperPaletteFactory backgroundCellColorOfBombExploded:0];
        }
    }
    
    [self updateImage];
}


-(void) setIsFlag:(BOOL)isFlag{
    _isFlag=isFlag;
    [self updateImage];
    
}


-(void) setImageLayer:(CAShapeLayer *)imageLayer{
    if(_imageLayer){
        self.Image.layer.sublayers=nil;
        _imageLayer=imageLayer;
        [self.Image.layer addSublayer: _imageLayer];
    }else{
        _imageLayer=imageLayer;
        [self.Image.layer addSublayer: _imageLayer];
    }
    
    
}


-(SystemSoundID) tapSound{
    
    if(!_tapSound){
        NSURL *toneURLRef = [[NSBundle mainBundle] URLForResource:@"tapSound"
                                                    withExtension:@"wav"];
         AudioServicesCreateSystemSoundID((__bridge CFURLRef)(toneURLRef), &_tapSound);
    }
    return _tapSound;
}


-(SystemSoundID) flagSound{
    
    if(!_flagSound){
        NSURL *toneURLRef = [[NSBundle mainBundle] URLForResource:@"flagSound"
                                                    withExtension:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(toneURLRef), &_flagSound);
    }
    return _flagSound;
}


-(UIView*) Image{
    if(!_Image){
        _Image=[[UIImageView alloc] initWithFrame:self.bounds];
        _Image.backgroundColor=[MineSweeperPaletteFactory borderCellFrontColorWithIndex:0];
        self.layer.borderColor=[UIColor whiteColor].CGColor;
        self.layer.borderWidth=self.frame.size.width*0.03;
    }
    return _Image;
}




#pragma mark - animation


-(CABasicAnimation*) buttonTouchedAnimationFrom:(float) from to:(float) to{
    CABasicAnimation *pulseAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.fromValue = [NSNumber numberWithFloat:from];
    pulseAnimation.toValue = [NSNumber numberWithFloat:to];
    [pulseAnimation setFillMode:kCAFillModeForwards];
    [pulseAnimation setRemovedOnCompletion:NO];
    pulseAnimation.duration = 0.2;
    
    return pulseAnimation;
}

#pragma mark - method for checking is sound OFF/ON

-(BOOL) checkSound{
    NSNumber *sound=[[NSUserDefaults standardUserDefaults] objectForKey:@"sound"];
    
    if(!sound){
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"sound"];
        sound=[[NSUserDefaults standardUserDefaults] objectForKey:@"sound"];

    }
    
    return [sound intValue];
}

#pragma mark - handling events

-(void) handleTapGesture:(UITapGestureRecognizer *)sender{
    if(!self.isShown){
    if(sender.state==UIGestureRecognizerStateBegan){
        [[self layer] addAnimation:[self buttonTouchedAnimationFrom:1.0 to:0.8] forKey:@"transform.scale"];
        
    }
    if(sender.state==UIGestureRecognizerStateEnded){
        [[self layer] addAnimation:[self buttonTouchedAnimationFrom:0.8 to:1.0] forKey:@"transform.scale"];
        if(!self.isHidden && !self.isFlag){
        
            if(self.isBomb){
                if([self checkSound]){
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
                self.Image.backgroundColor=[MineSweeperPaletteFactory backgroundCellColorOfBombExploded:0];
            }else{
                if([self checkSound]){
                    AudioServicesPlaySystemSound(self.tapSound);
                }
            }
        
            if(self.controllerDelegate){
            
                [self.controllerDelegate touchedCell:self.position];
            }
        }}
    }
}

-(void) handlePressGesture:(UILongPressGestureRecognizer *)sender{
  
    
   if(sender.state==UIGestureRecognizerStateBegan){
       if(!self.isShown){
           [[self layer] addAnimation:[self buttonTouchedAnimationFrom:0.8 to:1.0] forKey:@"transform.scale"];
           if(self.controllerDelegate){
               if([self checkSound]){
                   AudioServicesPlaySystemSound(self.flagSound);
               }
               [self.controllerDelegate flagedCell:self.position];
           }
       }
    }
}

#pragma mark - creating/updating image

-(CAShapeLayer*) getImageLayerWithName:(NSString*)name{
    CGRect imageFrame=CGRectMake(self.frame.size.height*0.05, self.frame.size.height*0.05, self.frame.size.width*0.7, self.frame.size.height*0.7);
    CAShapeLayer *subLayer=[[self.controllerDelegate SVGCache] objectForKey:name];
    CAShapeLayer *newImageLayer=[[CAShapeLayer alloc] init];
    if(!subLayer){
         newImageLayer=[PocketSVG makeShapeLayerWithSVG:name andFrame:imageFrame];
        [[self.controllerDelegate SVGCache] setObject:newImageLayer forKey:name];
    }else{
       newImageLayer=[PocketSVG configureShapeLayer:subLayer withFrame:imageFrame];
    }
    
    
    return newImageLayer;
    
    
}


-(void) updateImage{
  
    if(self.isFlag){
        self.imageLayer=[self getImageLayerWithName:@"flag"];
        
        self.layer.borderColor=[MineSweeperPaletteFactory borderCellBackgroundColorWithIndex:0].CGColor;
        
      
        
    }else{
        if(self.isShown){
            if(self.isBomb){
             self.imageLayer=[self getImageLayerWithName:@"bomb"];
            }else{
                if(self.valueOfCell){
                    self.imageLayer=[self getImageLayerWithName:[NSString stringWithFormat:@"%lu",(unsigned long)self.valueOfCell]];
                }else{
                    self.imageLayer=nil;
                }
            }
             self.layer.borderColor=[MineSweeperPaletteFactory borderCellBackgroundColorWithIndex:0].CGColor;
           
            
            
        }else{
            self.layer.borderColor=[MineSweeperPaletteFactory borderCellFrontColorWithIndex:0].CGColor;
            CAShapeLayer *frontLayer=[CAShapeLayer layer];
            frontLayer.path=CGPathCreateWithRect ( CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), nil );
            frontLayer.strokeColor = [UIColor clearColor].CGColor;
            frontLayer.lineWidth = 0.5;
            frontLayer.fillColor=[MineSweeperPaletteFactory frontCellColorWithIndex:0].CGColor;
            self.imageLayer=frontLayer;
            
        }
    }
}





@end
