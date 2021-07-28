//
//  Level.h
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 12/3/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject
@property (assign, nonatomic)int timeToSolve;
@property (strong, nonatomic) NSArray* gameImages;
@property (assign, nonatomic) int pointsPerTile;

+(instancetype)levelWithNum:(int)levelNum;
@end
