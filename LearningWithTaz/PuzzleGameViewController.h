//
//  PuzzleBoardViewController.h
//  Slize
//
//  Created by Myron  J. Wells on 1/06/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PuzzleGameView.h"

@interface PuzzleGameViewController : UIViewController <PuzzleGameDelegate> {
    UIImage *image;
    PuzzleGameView *board;
    UIButton *startButton;
    IBOutlet UISegmentedControl *boardSize;
    
    NSInteger step;
}

@property (nonatomic, retain) IBOutlet PuzzleGameView *board;
@property (nonatomic, retain) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestTimeLabel;

@property (nonatomic) NSTimer* gameCountDownTimer;
@property (nonatomic) int secondsCount;
@property (readwrite) int  finalTime;
@property (readwrite) int bestTime;
@property (nonatomic) int defaultTime;

- (IBAction)start:(id)sender;

@end
