//
//  UIGameResultsView.m
//  MineSwapper
//
//  Created by Eugene on 5/23/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "UIGameResultsView.h"
@interface UIGameResultsView()
@property (strong,nonatomic) UILabel *resultLabel;
@property (strong,nonatomic) UILabel *resultBestScoreLabel;
@property (strong,nonatomic) UILabel *resultScoreLabel;
@property (strong,nonatomic) UILabel *scoreLabel;
@property (strong,nonatomic) UIButton *submitButton;
@property (strong,nonatomic) NSArray *arrayOfResults;
@end
@implementation UIGameResultsView
-(instancetype) initWithScore:(NSUInteger) score{
    self=[super initWithFrame:[[UIScreen mainScreen] bounds]];
    
    return self;
}
-(void) initilizeViewUI{
    
    [self.options addSubview:self.submitButton];
    [self.options addSubview:self.resultLabel];
    [self.options addSubview:self.scoreLabel];
    [self.options addSubview:self.resultBestScoreLabel];
    [self.options addSubview:self.resultScoreLabel];
   
}
-(void) setScore:(NSUInteger)score{
    
    _score=score;
    
    self.resultScoreLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)score];
    [self checkResultsWithScore:score];
    [self writeRusult:score];
}

-(NSArray*) arrayOfResults{
    
    if(!_arrayOfResults){
        
        _arrayOfResults=@[@"Awesome!",@"Cool!",@"Nice!",@"Not bad",@"Try better"];
        
    }
    
    return _arrayOfResults;
}

-(UIButton*)submitButton{
    
    if(!_submitButton){
        _submitButton=[[UIButton alloc] initWithFrame:[self getRectBoundsWithNumberInView:3.5]];
        [ _submitButton addTarget:self action:@selector(submitOptions) forControlEvents:UIControlEventTouchUpInside];
        [ _submitButton setBackgroundColor:[UIColor blackColor]];
        [_submitButton setTitle:@"Submit" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.titleLabel.textColor=[UIColor whiteColor];
        _submitButton.layer.cornerRadius=5;
        _submitButton.titleLabel.font=[UIFont fontWithName:@"Futura" size:_submitButton.frame.size.height*0.6];
    }
    
    
    return _submitButton;
    
}

-(UILabel*) resultLabel{
    if(!_resultLabel){
        CGRect frame=CGRectMake(self.options.frame.size.width*0.1, self.options.frame.size.width*0.05, self.options.frame.size.width*0.8, self.options.frame.size.height*0.2);
        _resultLabel=[[UILabel alloc] initWithFrame:frame];
        _resultLabel.font=[UIFont fontWithName:@"Futura" size:_submitButton.frame.size.height*0.6];
        _resultLabel.textAlignment=NSTextAlignmentCenter;
        _resultLabel.text=@"Nice";
    }
    
    return  _resultLabel;
}

-(UILabel*) resultScoreLabel{
    if(!_resultScoreLabel){
        CGRect frame=CGRectMake(self.options.frame.size.width*0.1, self.options.frame.size.width*0.1+self.options.frame.size.height*0.25, self.options.frame.size.width*0.8, self.options.frame.size.height*0.2);
        _resultScoreLabel=[[UILabel alloc] initWithFrame:frame];
         _resultScoreLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.score];
        _resultScoreLabel.font=[UIFont fontWithName:@"Futura" size:_submitButton.frame.size.height*0.8];
        _resultScoreLabel.textAlignment=NSTextAlignmentCenter;
    }
    return  _resultScoreLabel;
}

-(UILabel*) scoreLabel{
    if(!_scoreLabel){
        CGRect frame=CGRectMake(self.options.frame.size.width*0.1, self.options.frame.size.width*0.1+self.options.frame.size.height*0.1, self.options.frame.size.width*0.8, self.options.frame.size.height*0.2);
        _scoreLabel=[[UILabel alloc] initWithFrame:frame];
        _scoreLabel.font=[UIFont fontWithName:@"Futura" size:_submitButton.frame.size.height*0.4];
        _scoreLabel.textAlignment=NSTextAlignmentCenter;
        _scoreLabel.text=@"Your score";
    }
    
    return  _scoreLabel;
}

-(UILabel*) resultBestScoreLabel{
    if(!_resultBestScoreLabel){
        CGRect frame=CGRectMake(self.options.frame.size.width*0.1, self.options.frame.size.width*0.1+self.options.frame.size.height*0.4, self.options.frame.size.width*0.8, self.options.frame.size.height*0.2);
        _resultBestScoreLabel=[[UILabel alloc] initWithFrame:frame];
        _resultBestScoreLabel.font=[UIFont fontWithName:@"Futura" size:_submitButton.frame.size.height*0.35];
        _resultBestScoreLabel.textAlignment=NSTextAlignmentCenter;
        _resultBestScoreLabel.text=@"New Best!";
    }
    
    return  _resultBestScoreLabel;
}

-(void) checkResultsWithScore:(NSUInteger) score{
    if(score>100000){
        self.resultLabel.text=[self.arrayOfResults objectAtIndex:0];
    }else if(score>50000){
        self.resultLabel.text=[self.arrayOfResults objectAtIndex:1];
    }else if (score>30000){
        self.resultLabel.text=[self.arrayOfResults objectAtIndex:2];
    }else if (score>20000){
        self.resultLabel.text=[self.arrayOfResults objectAtIndex:3];
    }else if (score>10000){
        self.resultLabel.text=[self.arrayOfResults objectAtIndex:4];
    }

    
}

-(void) writeRusult:(NSUInteger) score{
    
     NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if(!standardUserDefaults){
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lu",(unsigned long)score] forKey:@"highScore"];
    }else{
        NSString *highScore=[standardUserDefaults objectForKey:@"highScore"];
        if(score>[highScore intValue]){
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lu",(unsigned long)score] forKey:@"highScore"];
        }else{
            self.resultBestScoreLabel.text=[NSString stringWithFormat:@"Your best %@",highScore];
        }
    }
}

-(void) submitOptions{
    
    [self showViewWithAnimation:!self.hidden];
}

@end
