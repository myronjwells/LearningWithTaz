//
//  PuzzleBoardViewController.m
//  Slize
//
//  Created by Myron  J. Wells on 1/06/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import "PuzzleGameViewController.h"

@implementation PuzzleGameViewController
@synthesize board;
@synthesize startButton;



#pragma mark - View lifecycle



-(void)setTimer
{
    self.secondsCount = 0;
    self.gameCountDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    
}

-(void)timerRun
{
    
    self.secondsCount++;
    
    
    
    NSString *timerOutput = [NSString stringWithFormat:@" %02.f : %02i", round(self.secondsCount / 60), self.secondsCount % 60 ];
    
    
    self.timeLabel.text = timerOutput;
    
    
}




- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    
    
       self.bestTime = [[NSUserDefaults standardUserDefaults]integerForKey:@"BestTime"];
    
    self.bestTimeLabel.text = [NSString stringWithFormat:@" %02.f : %02i", round(self.bestTime / 60), self.bestTime % 60 ];
    
    

    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    self.view.frame = frame;
    
    // set the image
    
   UIImage *_image = [UIImage imageNamed:@"ff.png"];
    image = _image;
    
    // show the full image first in the view
     
    UIImageView *fullImage = [[UIImageView alloc] initWithImage:image];
    fullImage.frame = board.bounds;
    [board addSubview:fullImage];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(puzzleBoardDidFinished:) name:@"DoFinishPuzzle" object:nil];
    
    
}




- (void)viewDidUnload {
    [self setBoard:nil];
    [self setStartButton:nil];

    boardSize = nil;
    [super viewDidUnload];
}


/*
 This delegate method is fired when the puzzle board is finished

*/
- (void)puzzleBoardDidFinished:(PuzzleGameView *)puzzleBoard {
        
        
    // add the full image with 0.0 alpha in view
    
    if(self.bestTime == 0)
    {
        self.finalTime = self.secondsCount;
        NSLog(@"Saving the first highscore which is: %i",self.finalTime);
        [self saveTime];
    }
    
    
    if(self.secondsCount!=0){
        self.finalTime = self.secondsCount;
        NSLog(@"seconds is: %i",self.secondsCount);
        
        
        if(self.finalTime<self.bestTime) {
        
        self.bestTime = self.finalTime;
        NSLog(@"bestTime! is: %i",self.bestTime);
        [self saveTime];
        }
        

    }
    [self.gameCountDownTimer invalidate];
    self.gameCountDownTimer = nil;
    
    self.bestTimeLabel.text = [NSString stringWithFormat:@" %02.f : %02i", round(self.bestTime / 60), self.bestTime % 60 ];
    
    
    UIImageView *fullImage = [[UIImageView alloc]initWithImage:image];
    fullImage.frame = board.bounds;
    fullImage.alpha = 0.0;
    [board addSubview:fullImage];
    
    [UIView animateWithDuration:.4 
                     animations:^{
                         // set the alpha of full image to 1.0
                         
                         fullImage.alpha = 1.0;                    
                     } 
                     completion:^(BOOL finished){
                         // set the view interaction and set the label text
                         
                         NSLog(@"Congrats! You finish this %d x %d puzzle with %d steps", (boardSize.selectedSegmentIndex+3), (boardSize.selectedSegmentIndex+3), step);
                         [board setUserInteractionEnabled:NO];
                         [startButton setTitle:@"Start" forState:UIControlStateNormal];
                     }];    
}

-(void)saveTime {
    
    
    [[NSUserDefaults standardUserDefaults]setInteger:self.finalTime forKey:@"BestTime"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
}


- (void)puzzleBoard:(PuzzleGameView *)board emptyTileDidMovedTo:(CGPoint)tilePoint {
    // You can add some cool sound effects here
    
    step += 1;
}

#pragma mark - IB Actions

- (IBAction)start:(id)sender {
    
    //reset timer 
    
    [self.gameCountDownTimer invalidate];
    self.gameCountDownTimer = nil;
    self.secondsCount=0;
    // reset steps
    step = 0;
    
    // begin timer
    [self setTimer];

    
    
    // set the view so that it can interact with touches
    
    [board setUserInteractionEnabled:YES];
    
    // set the label text to 'reset'
    
    [startButton setTitle:@"Reset" forState:UIControlStateNormal];
    
    // initialize the board, lets play!
        [board playWithImage:image andSize:(boardSize.selectedSegmentIndex+3)];
}

@end
