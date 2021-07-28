//
//  GameData.m
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 12/5/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import "GameData.h"

@implementation GameData

//custom setter - keep the score positive
-(void)setPoints:(int)points
{
    _points = MAX(points, 1);
}
@end
