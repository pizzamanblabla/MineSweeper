//
//  UIScoreLabel.m
//  MineSwapper
//
//  Created by Eugene on 6/20/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import "UIScoreLabel.h"
@interface UIScoreLabel()
@property (nonatomic) NSNumber *to;
@property (nonatomic) NSNumber *from;
@property (nonatomic) int startTime;

@end
@implementation UIScoreLabel

- (void)animateFrom:(NSNumber *)aFrom toNumber:(NSNumber *)aTo {
    self.from = aFrom; 
    self.to = aTo;
    
    self.text = [self.from stringValue];
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(animateNumber:)];
    
    self.startTime = CACurrentMediaTime();
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)animateNumber:(CADisplayLink *)link {
    static float DURATION = 2.0;
    float dt = ([link timestamp] - self.startTime) / DURATION;
    if (dt >= 1.0) {
        self.text = [self.to stringValue];
        [link removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        return;
    }
    
    float current = ([self.to floatValue] - [self.from floatValue]) * dt + [self.from floatValue];
    self.text = [NSString stringWithFormat:@"%li", (long)current];
}

@end
