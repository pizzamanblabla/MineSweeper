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
#import "UICounterImageView.h"
@interface ViewController ()
@property (strong,nonatomic) MineSweeperGame *game;
@property (strong,nonatomic) NSTimer *gameTimer;
@property (strong,nonatomic) UICounterImageView *timerLabel;
@property (nonatomic) float width;
@property (nonatomic) float heigth;
@property (nonatomic) Point tochedPoint;
@property (nonatomic) BOOL isGameOver;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstrait;
@property (strong,nonatomic) UIOptionsView *options;
@property (strong,nonatomic) UIGameResultsView *results;
@property (strong,nonatomic) UICounterImageView *bombCounter;
@property (strong,nonatomic) UIView *headerView;
@property (strong,nonatomic) UIButton *optionsButton;
@property (strong,nonatomic) UIButton *refreshButton;
@end

@implementation ViewController
const float STANDART_OFFSET=0.05;
#pragma mark Properties
-(UIButton*) refreshButton{
    if(!_refreshButton){
        float heigth=self.headerView.frame.size.height;
        float width=heigth;
        float y=(self.view.frame.size.height*0.1-heigth)/2;
        CGRect frame=CGRectMake(self.headerView.frame.size.width-self.headerView.frame.size.width*STANDART_OFFSET-width, y, width, heigth);
        frame=CGRectIntegral(frame);
        UIImage *backgroundImage=[UIImage imageNamed:@"refresh"];
        _refreshButton=[[UIButton alloc] initWithFrame:frame];
        [_refreshButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        [_refreshButton addTarget:self.options action:@selector(submitOptions) forControlEvents:UIControlEventTouchUpInside];

        
    }
    return _refreshButton;
}
-(UIButton*) optionsButton{
    if(!_optionsButton){
        float heigth=self.headerView.frame.size.height;
        float width=heigth;
        float y=(self.view.frame.size.height*0.1-heigth)/2;
        CGRect frame=CGRectMake(self.headerView.frame.size.width*STANDART_OFFSET, y, width, heigth);
        frame=CGRectIntegral(frame);
        UIImage *backgroundImage=[UIImage imageNamed:@"options"];
         _optionsButton=[[UIButton alloc] initWithFrame:frame];
        [_optionsButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        [_optionsButton addTarget:self action:@selector(showOptions) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _optionsButton;
}
-(UIView*) headerView{
    
    if(!_headerView){
    
        CGRect frame=CGRectMake(0, self.view.frame.size.height*0.03, self.view.frame.size.width, self.view.frame.size.height*0.1-self.view.frame.size.height*0.03);
        _headerView=[[UIView alloc] initWithFrame:frame];
        
    }
    
    return _headerView;
}
-(UICounterImageView*) timerLabel{
    
    if(!_timerLabel){
        
        float heigth=self.headerView.frame.size.height;
        float width=(self.headerView.frame.size.width-self.optionsButton.frame.size.width-self.refreshButton.frame.size.width)*0.5;
        float y=(self.view.frame.size.height*0.1-heigth)/2;
        CGRect frame=CGRectMake(self.headerView.frame.size.width*0.5+self.headerView.frame.size.height*0.5-width, y, width, heigth);
        frame=CGRectIntegral(frame);
        _timerLabel=[[UICounterImageView alloc] initWithFrame:frame andImage:[UIImage imageNamed:@"time"]];
        
    }
    return _timerLabel;
}

-(UICounterImageView*) bombCounter{
    if(!_bombCounter){
        float heigth=self.headerView.frame.size.height;
        float width=(self.headerView.frame.size.width-self.optionsButton.frame.size.width-self.refreshButton.frame.size.width)*0.5;
        float y=(self.view.frame.size.height*0.1-heigth)/2;
        CGRect frame=CGRectMake(self.headerView.frame.size.width*0.5+self.headerView.frame.size.height*0.5, y, width, heigth);
        _bombCounter=[[UICounterImageView alloc] initWithFrame:frame andImage:[UIImage imageNamed:@""]];
        _bombCounter.label.textAlignment=NSTextAlignmentLeft;
       

    }

    return _bombCounter;
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
    self.bombCounter.label.text=[NSString stringWithFormat:@"%d",self.game.cellsDeck.bombs];
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
            
             NSUInteger score=[self.game calculateScore:[self.timerLabel.label.text intValue]];
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
           NSUInteger score=[self.game calculateScore:[self.timerLabel.label.text intValue]];
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
    
    int labelValue=[self.timerLabel.label.text intValue];
    labelValue++;
    self.timerLabel.label.text=[NSString stringWithFormat:@"%d",labelValue];
    
    
}
-(void) setStartGameOptions{
    
    self.timerLabel.backgroundColor=[UIColor whiteColor];
    //self.refreshButton.hidden=YES;
    self.timerLabel.label.text=@"0";
    [self.gameTimer invalidate];
    self.gameTimer=nil;
    
}

-(void) initializeUI{
    
    self.topConstrait.constant=[[UIScreen mainScreen] bounds].size.height*0.1;
    [self.cells calculateProbableSizesOfCell];
    self.options=[[UIOptionsView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.options.controllerDelegate=self;
    self.results=[[UIGameResultsView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.results.hidden=YES;
    
    
    [self.view addSubview:self.headerView];
     [self.headerView addSubview:self.bombCounter];
     [self.headerView addSubview:self.optionsButton];
    [self.headerView addSubview:self.refreshButton];
     [self.headerView addSubview:self.timerLabel];
    
    [self.view addSubview:self.results];
    [self.view addSubview:self.options];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    }

- (void)viewDidAppear:(BOOL)animated {
    [self initializeUI];
   }




@end
