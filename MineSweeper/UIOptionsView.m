//
//  UIOptionsView.m
//  MineSwapper
//
//  Created by Eugene on 4/8/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//
#import "UIMineSweeperSlider.h"
#import "UIOptionsView.h"
#import "PocketSVG+LayerMaker.h"
@interface UIOptionsView()
@property (strong,nonatomic) UISlider *bombSetter;
@property (strong,nonatomic) UISlider *quantityOfCells;
@property (strong,nonatomic) UISlider *quantityOfRowsSetter;
@property (strong,nonatomic) UIButton *submitButton;
@property (strong,nonatomic) UILabel *cellsSetterLabel;
@property (strong,nonatomic) UILabel *bombSetterLabel;
@property (strong,nonatomic) UIView *soundButton;
@property (nonatomic) CAShapeLayer *imageLayer;

@end
@implementation UIOptionsView


-(void) initilizeViewUI{
    
    [self.options addSubview:self.bombSetter];
    [self.options addSubview:self.submitButton];
    [self addSubview:self.soundButton];
    [self initSoundLayer];
    
    
}
-(void) setImageLayer:(CAShapeLayer *)imageLayer{
    if(_imageLayer){
        self.soundButton.layer.sublayers=nil;
        _imageLayer=imageLayer;
        [self.soundButton.layer addSublayer: _imageLayer];
    }else{
        _imageLayer=imageLayer;
        [self.soundButton.layer addSublayer: _imageLayer];
    }
    
    
}

-(void) initSoundLayer{
    NSNumber *sound=[[NSUserDefaults standardUserDefaults] objectForKey:@"sound"];
    
    
    if(!sound){
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"sound"];
        self.imageLayer=[PocketSVG makeShapeLayerWithSVG:@"volume" andFrame:self.soundButton.frame andColor:[MineSweeperPaletteFactory backgroundCellColorWithIndex:PALETTE]];
    }else{
        if([sound intValue]){
            self.imageLayer=[PocketSVG makeShapeLayerWithSVG:@"volume" andFrame:self.soundButton.frame andColor:[MineSweeperPaletteFactory backgroundCellColorWithIndex:PALETTE]];
        }else{
            self.imageLayer=[PocketSVG makeShapeLayerWithSVG:@"novolume" andFrame:self.soundButton.frame andColor:[MineSweeperPaletteFactory backgroundCellColorWithIndex:PALETTE]];
        }
    }

    
    
}


-(void) OnOffSound{
    NSNumber *sound=[[NSUserDefaults standardUserDefaults] objectForKey:@"sound"];
    if(!sound){
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"sound"];
    }else{
        if([sound intValue]){
            [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"sound"];
            self.imageLayer=[PocketSVG makeShapeLayerWithSVG:@"novolume" andFrame:self.soundButton.frame andColor:[MineSweeperPaletteFactory backgroundCellColorWithIndex:PALETTE]];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"sound"];
            self.imageLayer=[PocketSVG makeShapeLayerWithSVG:@"volume" andFrame:self.soundButton.frame andColor:[MineSweeperPaletteFactory backgroundCellColorWithIndex:PALETTE]];
        }
    }
    
}

-(UIView*) soundButton{
    
    if(!_soundButton){
        float height=self.frame.size.height*0.1;
        float offset=self.frame.size.height*0.05;
        CGRect frame=CGRectMake(self.frame.size.width-height-offset, self.frame.size.height-height-offset, height, height);
        _soundButton=[[UIView alloc] initWithFrame:frame];
        _soundButton.backgroundColor=[UIColor clearColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnOffSound)];
        [_soundButton addGestureRecognizer:tapGesture];
    }
    return _soundButton;
}

-(UILabel*) cellsSetterLabel{
    
    if(!_cellsSetterLabel){
        CGRect frame=[self getRectLabelWithView:self.quantityOfCells];
        _cellsSetterLabel=[[UILabel alloc] initWithFrame:frame];
        _cellsSetterLabel.font=[UIFont fontWithName:@"Futura" size:_cellsSetterLabel.frame.size.height*0.9];
        _cellsSetterLabel.textAlignment=NSTextAlignmentCenter;
        _cellsSetterLabel.textColor=[MineSweeperPaletteFactory fontTextColorWithIndex:PALETTE];
        [self.options addSubview:_cellsSetterLabel];
        
    }
    
    return _cellsSetterLabel;
    
}
-(UILabel*) bombSetterLabel{
    
    if(!_bombSetterLabel){
        CGRect frame=[self getRectLabelWithView:self.bombSetter];
        _bombSetterLabel=[[UILabel alloc] initWithFrame:frame];
        _bombSetterLabel.font=[UIFont fontWithName:@"Futura" size:_bombSetterLabel.frame.size.height*0.9];
        _bombSetterLabel.textAlignment=NSTextAlignmentCenter;
        _bombSetterLabel.textColor=[MineSweeperPaletteFactory fontTextColorWithIndex:PALETTE];
        [self.options addSubview:_bombSetterLabel];
        
    }
    return _bombSetterLabel;
}


-(void) setControllerDelegate:(ViewController *)controllerDelegate{
    
    if(!_controllerDelegate){
        _controllerDelegate=controllerDelegate;
         [self.options addSubview:self.quantityOfCells];
    }else{
        _controllerDelegate=controllerDelegate;
       
    }
    
}



-(UISlider*)bombSetter{
    
    if(!_bombSetter){
        
        _bombSetter=[[UIMineSweeperSlider alloc] initWithFrame:[self getRectBoundsWithNumberInView:0]];
        [ _bombSetter addTarget:self action:@selector(bombUpdate) forControlEvents:UIControlEventValueChanged];
        [ _bombSetter setBackgroundColor:[UIColor clearColor]];
         _bombSetter.minimumValue = 5.0;
         _bombSetter.maximumValue = 50.0;
         _bombSetter.continuous = YES;
         _bombSetter.value = 20.0;
        
        
    }
    
    
    return _bombSetter;
    
}
-(void) bombUpdate{
    int bombs=self.bombSetter.value;
    self.bombSetterLabel.text=[NSString stringWithFormat:@"%d bombs",bombs];
}

-(UISlider*)quantityOfCells{
    
    if(!_quantityOfCells){
        
        _quantityOfCells=[[UIMineSweeperSlider alloc] initWithFrame:[self getRectBoundsWithNumberInView:1.4]];
        [ _quantityOfCells addTarget:self action:@selector(sliderCellsDidChange) forControlEvents:UIControlEventValueChanged];
        [ _quantityOfCells setBackgroundColor:[UIColor clearColor]];
        _quantityOfCells.minimumValue = 0.0;
        if(self.controllerDelegate){
        _quantityOfCells.maximumValue =[self.controllerDelegate.cells.arrayOfSuggestionsSizesOfCells count]-1;
        }
        _quantityOfCells.continuous = YES;
    }
    return _quantityOfCells;
}

-(void) sliderCellsDidChange{
    int columns=self.quantityOfCells.value;
    if(![[self.controllerDelegate.cells.arrayOfSuggestionsSizesOfCells objectAtIndex:columns] isKindOfClass:[NSNull class]]){
        if(self.controllerDelegate){
            NSArray* arraySizes = [self.controllerDelegate.cells.arrayOfSuggestionsSizesOfCells objectAtIndex:columns];
            self.cellsSetterLabel.text=[NSString stringWithFormat:@"%d X %d cells",[[arraySizes objectAtIndex:0] intValue],[[arraySizes objectAtIndex:1] intValue]];
            int bombs=self.bombSetter.value;
       
            self.bombSetter.minimumValue=([[arraySizes objectAtIndex:0] intValue]*[[arraySizes objectAtIndex:1] intValue])*0.1;
            self.bombSetter.maximumValue=([[arraySizes objectAtIndex:0] intValue]*[[arraySizes objectAtIndex:1] intValue])*0.2;
            self.bombSetter.value=([[arraySizes objectAtIndex:0] intValue]*[[arraySizes objectAtIndex:1] intValue])*0.15;
            self.bombSetterLabel.text=[NSString stringWithFormat:@"%d bombs",bombs];
        }
    }
}

-(UIButton*)submitButton{
    
    if(!_submitButton){
        _submitButton=[[UIButton alloc] initWithFrame:[self getRectBoundsWithNumberInView:3.5]];
        [ _submitButton addTarget:self action:@selector(submitOptions) forControlEvents:UIControlEventTouchUpInside];
        [ _submitButton setBackgroundColor:[MineSweeperPaletteFactory buttonColorWithIndex:PALETTE]];
        [_submitButton setTitle:@"Submit" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[MineSweeperPaletteFactory buttonTextColorWithIndex:PALETTE] forState:UIControlStateNormal];
        _submitButton.titleLabel.textColor=[MineSweeperPaletteFactory buttonTextColorWithIndex:PALETTE];
        _submitButton.layer.cornerRadius=5;
        _submitButton.titleLabel.font=[UIFont fontWithName:@"Futura" size:_submitButton.frame.size.height*0.6];
            }
    
    
    return _submitButton;
    
}
-(void) submitOptions{
    [self updateViewWithModel:YES];
    [self showViewWithAnimation:YES];
}

-(void) updateViewWithModel:(BOOL)update{
    [self.controllerDelegate setStartGameOptions];
    int columns=self.quantityOfCells.value;
    if(self.controllerDelegate){
    NSArray* arraySizes = [self.controllerDelegate.cells.arrayOfSuggestionsSizesOfCells objectAtIndex:columns];
    self.cellsSetterLabel.text=[NSString stringWithFormat:@"%d X %d cells",[[arraySizes objectAtIndex:0] intValue],[[arraySizes objectAtIndex:1] intValue]];
    int bombs=self.bombSetter.value;
    if(!update){
        self.bombSetter.minimumValue=([[arraySizes objectAtIndex:0] intValue]*[[arraySizes objectAtIndex:1] intValue])*0.1;
        self.bombSetter.maximumValue=([[arraySizes objectAtIndex:0] intValue]*[[arraySizes objectAtIndex:1] intValue])*0.2;
        self.bombSetter.value=([[arraySizes objectAtIndex:0] intValue]*[[arraySizes objectAtIndex:1] intValue])*0.15;
        int bombs=self.bombSetter.value;
        self.bombSetterLabel.text=[NSString stringWithFormat:@"%d bombs",bombs];
    }
        [self.controllerDelegate updateViewWithRows:[[arraySizes objectAtIndex:0] intValue] andColumns: [[arraySizes objectAtIndex:1] intValue] Bombs:bombs updateModel:update];
    }
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
