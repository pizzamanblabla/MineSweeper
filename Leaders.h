//
//  Leaders.h
//  MineSwapper
//
//  Created by Eugene on 5/11/15.
//  Copyright (c) 2015 Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Leaders : NSManagedObject

@property (nonatomic, retain) NSString * playerName;
@property (nonatomic, retain) NSNumber * score;

@end
