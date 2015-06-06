//
//  UICellView.m
//  MineSwapper
//
//  Created by Eugene on 3/15/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "UICellView.h"

@interface UICellView()
@property (nonatomic,readwrite) Point position;
@property (strong,nonatomic) UIImageView *Image;


@end
@implementation UICellView



-(instancetype)initWithFrame:(CGRect)frame andPosition:(Point)position{
    
    self=[super initWithFrame:frame];
    if(self){
        self.position=position;
        self.isHidden=NO;
        self.isFlag=NO;
        [self addSubview:self.Image];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGesture];
        UILongPressGestureRecognizer *pressGesture=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlePressGesture:)];
        [self addGestureRecognizer:pressGesture];
    }
    return self;
}

-(void) handleTapGesture:(UITapGestureRecognizer *)sender{
    
    if(!self.isHidden && !self.isFlag){
        
        if(self.isBomb){
            
            self.backgroundColor=[UIColor redColor];
        }
        
        if(self.controllerDelegate){
            [self.controllerDelegate touchedCell:self.position];
        }
    }
}

-(void) handlePressGesture:(UILongPressGestureRecognizer *)sender{
    if(sender.state==UIGestureRecognizerStateBegan){
        if(self.controllerDelegate){
            [self.controllerDelegate flagedCell:self.position];
        }
    }
}

/*-(UIImageView*) ImageValue{
    if(!_ImageValue){
         _ImageValue=[[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _ImageValue;
}*/




-(UIImageView*) Image{
    if(!_Image){
        _Image=[[UIImageView alloc] initWithFrame:self.bounds];
        _Image.image=[UIImage imageNamed:@"front"];
        self.layer.borderColor=[UIColor whiteColor].CGColor;
        self.layer.borderWidth=self.frame.size.width*0.03;
    }
    return _Image;
}


-(void) updateImage{
    if(self.isFlag){
        _Image.image=[UIImage imageNamed:@"flag"];
        self.layer.borderColor=[UIColor blackColor].CGColor;
    }else{
        if(self.isHidden){
            if(self.isBomb){
                _Image.image=[UIImage imageNamed:@"bomb"];
            }else{
                _Image.image=[UIImage imageNamed:[NSString stringWithFormat:@"%lu",(unsigned long)self.valueOfCell]];
            }
             self.layer.borderColor=[UIColor blackColor].CGColor;
            //[self startCellDisappearAnimation];
            
            
        }else{
            self.layer.borderColor=[UIColor whiteColor].CGColor;
            _Image.image=[UIImage imageNamed:@"front"];
                      
        }
    }
}

-(void) startCellDisappearAnimation{
    //Начальное и конечное значения радиуса маски
    CGFloat initialRadius = 1.0f;
    CGFloat finalRadius = self.Image.bounds.size.width;
    
    //Создаём слой, который будет содержать маску
    CAShapeLayer *revealShape = [CAShapeLayer layer];
    revealShape.bounds = self.Image.bounds;
    //Закрашиваем черным — подойдет любой цвет, кроме прозрачного
    revealShape.fillColor = [UIColor blackColor].CGColor;
    CGColorRef pixelColor = [[UIColor blackColor] CGColor];
   // revealShape.backgroundColor=(__bridge CGColorRef)((__bridge id)pixelColor);
       //Собственно фигура, которая будем служить маской: начальная и конечная
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMidX(self.Image.bounds) - initialRadius,
                                                                                 CGRectGetMidY(self.Image.bounds) - initialRadius, initialRadius * 2, initialRadius * 2)
                                                         cornerRadius:initialRadius];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRoundedRect:self.Image.bounds
                                                       cornerRadius:finalRadius];
   // revealShape.path = startPath.CGPath;
    revealShape.position = CGPointMake(CGRectGetMidX(self.Image.bounds) - initialRadius,
                                       CGRectGetMidY(self.Image.bounds) - initialRadius);
     revealShape.backgroundColor=(__bridge CGColorRef)([UIColor blackColor]);
    //Итак, теперь на изображение наложена маска, и видна будет лишь та его часть, которая совпадает с маской
    self.Image.layer.mask = revealShape;
    //self.ImageValue.layer.mask.opacity=0;
    
    //Теперь анимация. Мы анимируем свойство path — это граф, описывающий фигуру, в нашем случае окружность. Анимация осуществит плавный переход от маленькой окружности до большой
    CABasicAnimation *revealAnimationPath = [CABasicAnimation animationWithKeyPath:@"path"];
    revealAnimationPath.fromValue = (__bridge id)(startPath.CGPath);
    revealAnimationPath.toValue = (__bridge id)(endPath.CGPath);
    revealAnimationPath.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    revealAnimationPath.duration = 0.5f;
    revealAnimationPath.repeatCount = 1.0f;
    //Для этой анимации мы также установим начальное время, так как она должна начаться лишь когда половина обрамляющей окружности уже прорисована
    revealAnimationPath.delegate = self;
    //Так как анимация стартует с задержкой, нужно удостовериться, что свойство hidden у картинки изменится только когда маска уже применена, т.е. когда начнётся анимация маски
    dispatch_time_t timeToShow = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC));
    dispatch_after(timeToShow, dispatch_get_main_queue(), ^{
       // self.ImageValue.hidden = NO;
        self.Image.layer.mask.backgroundColor= pixelColor;
    });
    
    revealShape.path = endPath.CGPath;
   
    [revealShape addAnimation:revealAnimationPath forKey:@"revealAnimation"];
    
}

-(void) setIsHidden:(BOOL)isHidden{
    _isHidden=isHidden;
    [self updateImage];
}

-(void) setIsFlag:(BOOL)isFlag{
    _isFlag=isFlag;
    [self updateImage];
    
}


-(void)updateUI{
   
    [self updateImage];
   
}





@end
