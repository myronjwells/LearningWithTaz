//
//  MathModes.h
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 12/29/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MathModes : NSObject 

@property (assign, nonatomic)int scale1;
@property (assign, nonatomic)int scale2;
@property (strong, nonatomic) NSArray* gestureTemplates;
@property (assign, nonatomic) int points;
@property (assign, nonatomic) NSString* operation;
@property (assign, nonatomic) int numMode;
+(instancetype)ModeWithNum:(int)ModeNum;
@end
