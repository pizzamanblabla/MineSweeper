//
//  ViewController.m
//  MineSwapper
//
//  Created by Eugene on 3/7/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "ViewController.h"
#import "UICellDeckView.h"
#import "UICellView.h"
#import "MineSweeperGame.h"
#import "MineSwapperCell.h"
#import "UIOptionsView.h"
#import "UIGameResultsView.h"
#import "UITimerView.h"

@interface ViewController ()
@property (strong,nonatomic) MineSweeperGame *game;
@property (strong,nonatomic) NSTimer *gameTimer;
@property (strong,nonatomic) UITimerView *timerLabel;
@property (strong,nonatomic) UIButton *refreshButton;
@property (nonatomic) float width;
@property (nonatomic) float heigth;
@property (nonatomic) Point tochedPoint;
@property (nonatomic) BOOL isGameOver;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstrait;
@property (strong,nonatomic) UIOptionsView *options;
@property (strong,nonatomic) UIGameResultsView *results;
@end

@implementation ViewController
const float STANDART_OFFSET=0.05;
#pragma mark Properties
/*
-(UIGameResultsView*) results{
    
    _results=[[UIGameResultsView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    return _results;
}
*/

-(UILabel*) timerLabel{
    
    if(!_timerLabel){
        
        //float height=40;
         float height=self.view.frame.size.height*0.1-self.view.frame.size.height*0.035;
        float width=height*2;
        float x=self.view.frame.size.width*0.5-width/2;
        float y=self.view.frame.size.height*STANDART_OFFSET;
        CGPoint point={x,y};
        CGSize size={width,height};
        CGRect options={point,size};
        _timerLabel=[[UITimerView alloc] initWithFrame:options];
        _timerLabel.text=@"0";
        _timerLabel.font=[UIFont fontWithName:@"Futura" size:_timerLabel.frame.size.height*0.8];
        _timerLabel.textAlignment=NSTextAlignmentRight;
        
    }
    return _timerLabel;
}


-(UIButton*) refreshButton{
    
    if(!_refreshButton){
         float height=self.view.frame.size.height*0.1-self.view.frame.size.height*0.035;
        float width=height;
        float x=self.timerLabel.frame.origin.x-width-self.view.frame.size.width*0.02;
        float y=self.view.frame.size.height*STANDART_OFFSET;
        CGPoint point={x,y};
        CGSize size={width,height};
        CGRect options={point,size};
        UIImage *backgroundImage=[UIImage imageNamed:@"refresh"];
         _refreshButton=[[UIButton alloc] initWithFrame:options];
        [_refreshButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        [_refreshButton addTarget:self.options action:@selector(submitOptions) forControlEvents:UIControlEventTouchUpInside];
        _refreshButton.hidden=YES;
        
    }
    return _refreshButton;
}





#pragma mark Controller

-(void) updateViewWithRows:(int) rows andColumns:(int) columns Bombs:(int)bombs updateModel:(BOOL) update{
    self.game=nil;
    self.isGameOver=NO;
    self.game=[[MineSweeperGame alloc ] initWithRows:rows Columns:columns Bombs:bombs];
    [self.cells drawDeckOfCellsWithQuantityOfCellsHorizotal:columns QuantityOfCellsVertical:rows];
    if(update){
        [self updateUIModel];
    }
}




-(void)updateUIModel{
    
    for( UICellView* cell in self.cells.arrayOfCells){
        
        MineSwapperCell* modelCell=[self.game.cellsDeck getCellByPosition:cell.position];
        if(!cell.controllerDelegate){
            cell.controllerDelegate=self;
        }
        if(modelCell){
        cell.isFlag=modelCell.isFlag;
        cell.valueOfCell=modelCell.cellValue;
        cell.isBomb=modelCell.isBomb;
        cell.isHidden=modelCell.isShown;
        }else{
            cell.isHidden=NO;
        }
        [cell updateUI];
    }
}



-(void) touchedCell:(Point) position{
     if(!self.isGameOver){
         if(!self.gameTimer){
             self.gameTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timer) userInfo:nil repeats:YES];

         }
         [self.game openCellsAroundWithPosition:position];
         [self updateUIModel];
         self.isGameOver=[self.game ckeckIsGameOver];
         if(self.isGameOver){
             [self.gameTimer invalidate];
            
             NSUInteger score=[self.game calculateScore:[self.timerLabel.text intValue]];
             self.results.score=score;
             [self.results showViewWithAnimation:NO];
            self.gameTimer=nil;
             self.refreshButton.hidden=NO;
         }
     }
}




-(void) flagedCell:(Point) position{
    if(!self.isGameOver){
        [self.game flagCellWithPosition:position];
        [self updateUIModel];
        self.isGameOver=[self.game ckeckIsGameOver];
        if(self.isGameOver){
            
            [self.gameTimer invalidate];
            self.gameTimer=nil;
           NSUInteger score=[self.game calculateScore:[self.timerLabel.text intValue]];
             self.results.score=score;
            [self.results showViewWithAnimation:NO];

            self.results.hidden=NO;
            self.refreshButton.hidden=NO;

        }
    }
}



-(void) showOptions{
    BOOL isHidden=!self.options.hidden;
    [self.options showViewWithAnimation:isHidden];
    [self.options updateViewWithModel:NO];
}


-(void) timer{
    
    int labelValue=[self.timerLabel.text intValue];
    labelValue++;
    self.timerLabel.text=[NSString stringWithFormat:@"%d",labelValue];
    
    
}
-(void) setStartGameOptions{
    
    self.timerLabel.backgroundColor=[UIColor whiteColor];
    self.refreshButton.hidden=YES;
    self.timerLabel.text=@"0";
    [self.gameTimer invalidate];
    self.gameTimer=nil;
    
}

-(void) initializeUI{
    
    self.topConstrait.constant=[[UIScreen mainScreen] bounds].size.height*0.1;
    [self createOptionsButton];
    [self createLeadersButton];
    [self.cells calculateProbableSizesOfCell];
    self.options=[[UIOptionsView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.options.controllerDelegate=self;
    self.results=[[UIGameResultsView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.results.hidden=YES;
    [self.view addSubview:self.results];
    [self.view addSubview:self.options];
    [self createGameTimer];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    }

- (void)viewDidAppear:(BOOL)animated {
    [self initializeUI];
   }
#pragma mark Create UI Elements
-(void) createOptionsButton{
    
   float height=self.view.frame.size.height*0.1-self.view.frame.size.height*0.04;
    float width=height;
    float x=self.view.frame.size.width*STANDART_OFFSET;
    float y=self.view.frame.size.height*STANDART_OFFSET;
    CGPoint point={x,y};
    CGSize size={width,height};
    CGRect options={point,size};
    UIImage *backgroundImage=[UIImage imageNamed:@"options"];
    UIButton *optionsButton=[[UIButton alloc] initWithFrame:options];
    [optionsButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [optionsButton addTarget:self action:@selector(showOptions) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:optionsButton];
}

-(void) createLeadersButton{
    float height=self.view.frame.size.height*0.1-self.view.frame.size.height*0.04;
    float width=height;
    float x=self.view.frame.size.width-self.view.frame.size.width*STANDART_OFFSET-width;
    float y=self.view.frame.size.height*STANDART_OFFSET;
    CGPoint point={x,y};
    CGSize size={width,height};
    CGRect options={point,size};
    UIImage *backgroundImage=[UIImage imageNamed:@"leaders"];
    UIButton *optionsButton=[[UIButton alloc] initWithFrame:options];
    [optionsButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [optionsButton addTarget:self action:@selector(showOptions) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:optionsButton];
}


-(void) createGameTimer{
    
    [self.view addSubview:self.timerLabel];
    [self.view addSubview:self.refreshButton];
    self.timerLabel.layer.zPosition=-1;
    self.refreshButton.layer.zPosition=-1;
}
@end
