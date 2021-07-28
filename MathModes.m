//
//  MathModes.m
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 12/29/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import "MathModes.h"

@implementation MathModes

+(instancetype)ModeWithNum:(int)ModeNum {
    //1 find .plist file for this level
    NSString* fileName = [NSString stringWithFormat:@"mode%i.plist", ModeNum];
    NSString* modePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    
    //2 load .plist file
    NSDictionary* modeDict = [NSDictionary dictionaryWithContentsOfFile:modePath];
    
    //3 validation
    NSAssert(modeDict, @"level config file not found");
    
    //4 create Level instance
    MathModes* m= [[MathModes alloc] init];
    
    //5 initialize the object from the dictionary
    m.gestureTemplates = modeDict[@"gestureTemplates"];
    m.scale1 = [modeDict[@"scale1"] intValue];
    m.scale2 = [modeDict[@"scale2"] intValue];
    m.points = [modeDict[@"points"]intValue];
    m.operation = modeDict[@"operation"];
    m.numMode = [modeDict[@"numMode"] intValue];
    
    return m;
}

@end
