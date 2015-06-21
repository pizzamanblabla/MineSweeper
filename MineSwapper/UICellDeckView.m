//
//  UICellDeckView.m
//  MineSwapper
//
//  Created by Eugene on 3/19/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//
#import "UICellView.h"
#import "UICellDeckView.h"
#import "MineSweeperPaletteFactory.h"
@interface UICellDeckView()
@property (nonatomic) CGPoint sizeOfCell;
@property (nonatomic) int rows;
@property (nonatomic) int columns;

@end
@implementation UICellDeckView

#pragma mark - init methods

-(instancetype)initWithQuantityOfCellsHorizotal:(int) rows QuantityOfCellsVertical:(int) columns{
 
    self=[super init];
    
    if(self){
        self.rows=rows;
        self.columns=columns;
        
        [self drawDeckOfCells];
       
    }
    
    return self;
}


-(NSMutableArray*) arrayOfSuggestionsSizesOfCells{
    if(!_arrayOfSuggestionsSizesOfCells){
        _arrayOfSuggestionsSizesOfCells=[[NSMutableArray alloc] init];
    }
    
    return _arrayOfSuggestionsSizesOfCells;
    
}

#pragma mark - properties methods

-(NSMutableArray*) arrayOfCells{
    
    if(!_arrayOfCells){
        
        _arrayOfCells=[[NSMutableArray alloc] init];
    }
    
    return _arrayOfCells;
}

-(CGPoint) sizeOfCell{
    
    if(!_sizeOfCell.x || !_sizeOfCell.y){
        _sizeOfCell.x=self.bounds.size.width/self.columns;
        _sizeOfCell.y=self.bounds.size.height/self.rows;
    }
    
    return _sizeOfCell;
}

#pragma mark - drawing cells methods

-(void) drawDeckOfCells{
    
    double x=floor(self.sizeOfCell.x);
    double y=floor(self.sizeOfCell.y);
 
     NSLog(@"height %f width %f",y,x);
    for(int i=1;i<=self.columns;i++){
        for(int n=1;n<=self.rows;n++){
            CGRect frame;
            frame.origin=CGPointZero;
            frame.size=CGSizeMake(x, y);
            frame.origin.x=x*(i-1);
            frame.origin.y=y*(n-1);
            Point position={i,n};
            UICellView *cellView=[[UICellView alloc] initWithFrame:CGRectIntegral(frame) andPosition:position];
            cellView.backgroundColor=[UIColor whiteColor];
            [self addSubview:cellView];
            [self.arrayOfCells addObject:cellView];
        }
    }
}




-(void) adjustView{
    
    float width=floor(self.sizeOfCell.x)*self.columns;
    float height=floor(self.sizeOfCell.y)*self.rows;
    float offsetHeight=self.frame.size.height-height;
    float offsetWidth=self.frame.size.width-width;
    CGRect frame=self.frame;
    self.frame=CGRectMake([[UIScreen mainScreen] bounds].origin.x+offsetWidth/2, ([[UIScreen mainScreen] bounds].size.height-frame.size.height)+offsetHeight, frame.size.width, frame.size.height);
}

-(void) drawDeckOfCellsWithQuantityOfCellsHorizotal:(int) rows QuantityOfCellsVertical:(int) columns{
    
    NSArray *viewsToRemove = [self subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    self.arrayOfCells=nil;
    _sizeOfCell.x=0;
    _sizeOfCell.y=0;
    if(self){
        self.rows=rows;
        self.columns=columns;
        [self adjustView];
        [self drawDeckOfCells];
    }
}

-(void) calculateProbableSizesOfCell{
    for(int i=6;i<=25;i++){
        for(int n=6;n<=25;n++){
            float width=self.frame.size.width/i;
            float height=self.frame.size.height/n;
            if(height>27 && width>27){
                if(height-width>0){
                    if((height-width)<0.8){
                        [self.arrayOfSuggestionsSizesOfCells addObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:i],[NSNumber numberWithInt:n], nil]];
                    }
                }else{
                    if((height-width)>-0.8){
                        [self.arrayOfSuggestionsSizesOfCells addObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:i],[NSNumber numberWithInt:n], nil]];
                    }
                }
            }
        }
    }
}

@end
