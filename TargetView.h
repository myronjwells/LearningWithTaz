//
//  TargetView.h
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 12/4/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TargetView : UIImageView
@property (strong, nonatomic, readonly) NSString* letter;
@property (assign, nonatomic) BOOL isMatched;

-(instancetype)initWithLetter:(NSString*)letter andSideLength:(float)sideLength;
@end
