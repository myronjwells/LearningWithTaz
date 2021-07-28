//
//  config.h
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 1/13/14.
//  Copyright (c) 2014 com.myronwells. All rights reserved.
//

#ifndef configed

//UI defines
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//add more definitions here
#define kTileMargin 20

//handy math functions
#define rad2deg(x) x * 180 / M_PI
#define deg2rad(x) x * M_PI / 180
#define randomf(minX,maxX) ((float)(arc4random() % (maxX - minX + 1)) + (float)minX)


#define configed 1
#endif