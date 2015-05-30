//
//  UICellDeckView.m
//  MineSwapper
//
//  Created by Eugene on 3/19/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//
#import "UICellView.h"
#import "UICellDeckView.h"
@interface UICellDeckView()
@property (nonatomic) CGPoint sizeOfCell;
@property (nonatomic) int rows;
@property (nonatomic) int columns;

@end
@implementation UICellDeckView
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
        // NSLog(@"%Lf %f",x,_sizeOfCell.x);
    
    }
    
    
    return _sizeOfCell;
}
-(void)drawCell{
    
    
    
    
}
-(void) drawDeckOfCells{
   // NSLog(@"%f %f",self.sizeOfCell.y*self.columns,self.bounds.size.width);
    double x=self.sizeOfCell.x;
    double y=self.sizeOfCell.y;
    for(int i=1;i<=self.columns;i++){
        for(int n=1;n<=self.rows;n++){
            CGRect frame;
            frame.origin=CGPointZero;
            frame.size=CGSizeMake(x, y);
            frame.origin.x=x*(i-1);
            frame.origin.y=y*(n-1);
            Point position={i,n};
            UICellView *cellView=[[UICellView alloc] initWithFrame:frame andPosition:position];
            cellView.backgroundColor=[UIColor whiteColor];
           [self addSubview:cellView];
            [self.arrayOfCells addObject:cellView];
        }
    }
}



-(UIColor*) randomColor{
    
    switch (arc4random()%5) {
        case 0:
            return [UIColor greenColor];
            break;
        case 1:
            return [UIColor blueColor];
            break;
        case 2:
            return [UIColor orangeColor];
            break;
        case 3:
            return [UIColor redColor];
            break;
        case 4:
            return [UIColor purpleColor];
            break;
            
    }
    
    return [UIColor blackColor];
    
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
        [self drawDeckOfCells];
    }
}

-(void) calculateProbableSizesOfCell{
    for(int i=1;i<=20;i++){
        for(int n=1;n<=20;n++){
            float width=self.frame.size.width/i;
            float height=self.frame.size.height/n;
            if(height>20 && width>20){
            if(height-width>0){
                if((height-width)<0.6){
                    [self.arrayOfSuggestionsSizesOfCells addObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:i],[NSNumber numberWithInt:n], nil]];
                }
            }else{
                if((height-width)>-0.6){
                    [self.arrayOfSuggestionsSizesOfCells addObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:i],[NSNumber numberWithInt:n], nil]];
                }
            }}
        }
    }
}

@end