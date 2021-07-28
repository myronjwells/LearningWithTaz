//
//  MathGameGlyphDetectorView.h
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 11/16/13.
//  Copyright (c) 2013 com.m/Users/Myron/Desktop/Developer/LearningWithTaz/LearningWithTaz/MathGameGlyphDetectorView.hyronwells. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTMGlyphDetector.h"
#import "WTMDetectionResult.h"
#import "MathGameViewController.h"

@class MathGameGlyphDetectorView;

@protocol MathGameGlyphDetectorViewDelegate <NSObject>

@optional
-(void)mathGameGlyphDetectorView:(MathGameGlyphDetectorView*)theView glyphDetected:(WTMGlyph *)glyph withScore:(float)score;

@end
@interface MathGameGlyphDetectorView : UIView
@property (nonatomic, strong) id delegate;
@property (nonatomic, assign) BOOL enableDrawing;
@property (nonatomic, strong) UIBezierPath *myPath;
@property (nonatomic) UITouch *touch;
- (void)loadTemplatesWithNames:(NSString*)firstTemplate, ... NS_REQUIRES_NIL_TERMINATION;

- (NSString *)getGlyphNamesString;
@end
