//
//  WordGameViewController.h
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 12/3/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordGame.h"
extern int wgGamePoints;
@interface WordGameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic) NSTimer* countdownTimer;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (retain, nonatomic) UIView* mainView;
@property (weak, nonatomic) IBOutlet UIView *timesUpScreen;
@property (weak, nonatomic) IBOutlet UILabel *timesUpLabel;
@property(strong, nonatomic) WordGame* controller;

@property (weak, nonatomic) IBOutlet UIButton *exitButton;

@end
