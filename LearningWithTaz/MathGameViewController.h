//
//  MathGameViewController.h
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 11/9/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainSceneViewController.h"

//@class MathGameGlyphDetectorView; //used to access properties from MathGameGlyphDetector view
@interface MathGameViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *showArithmatic;
@property (nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIView *finalScoreView;
@property (weak, nonatomic) IBOutlet UILabel *finalScoreLabel;


@property (nonatomic) int num1, num2;
@property (nonatomic, strong) NSString* oper;
@property (nonatomic) int modeNum;
@property (nonatomic, strong) NSArray* jsontemplates;
@property(nonatomic) int gamePoints;
@property (nonatomic) NSNumber *answer;
@property (nonatomic) NSNumberFormatter *formatter;
@property (nonatomic) NSString *convertAnswer;
@property (nonatomic) int gameScore;
@property (nonatomic) int gameHighScore;
@property (nonatomic) NSTimer *gameCountDownTimer;
@property (nonatomic)  int secondsCount;
@property (readwrite) int  finalAddingScore;
@property (readwrite) int  finalSubtractingScore;
@property (readwrite) int  finalMultiplyScore;
@property (readwrite) int  finalDivideScore;
@property (readwrite) int highscore;
@property (readwrite) int savedscore;
@property (strong, nonatomic) id infoRequest;
@property (strong, nonatomic) MainSceneViewController* mainvc;
- (IBAction)exitButton:(UIButton *)sender;
- (IBAction)playAgainButton:(UIButton *)sender;

-(void)setUpMathGame;

@end


