//
//  MathGameViewController.m
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 11/9/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#define GESTURE_SCORE_THRESHOLD         0.7f


#import "MathGameViewController.h"
#import "MathGameGlyphDetectorView.h"



@interface MathGameViewController ()
@property (nonatomic, strong) MathGameGlyphDetectorView *gestureDetectorView;





@end

@implementation MathGameViewController
@synthesize formatter;
@synthesize answer;
@synthesize convertAnswer;





#define TIMER_LENGTH      15


-(instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self !=nil)
    {
        
        
        //create the game controller
        self.mainvc = [[MainSceneViewController alloc]init];
        
        
        
    }
    return self;
}





-(void)animateEndGame {
    
    
    self.finalScoreLabel.text = [NSString stringWithFormat:@"%i", self.gameScore];
        
    switch(self.modeNum)
    {
        case(1):
            self.finalAddingScore = [self.finalScoreLabel.text intValue];

    if(self.finalAddingScore > self.highscore) {
        [self saveScore];
    }
            break;
        case(2):
            self.finalSubtractingScore = [self.finalScoreLabel.text intValue];

            if(self.finalSubtractingScore > self.highscore) {
                [self saveScore];
            }
            break;
        case(3):
            self.finalDivideScore = [self.finalScoreLabel.text intValue];

            if(self.finalDivideScore > self.highscore) {
                [self saveScore];
            }
            break;
        case(4):
            self.finalMultiplyScore = [self.finalScoreLabel.text intValue];

            if(self.finalMultiplyScore > self.highscore) {
                [self saveScore];
            }
            break;
    }
    [UIView animateWithDuration:0.3 animations:^{self.finalScoreView.frame = self.view.frame;} completion:^(BOOL finished){
       
    }];
}






-(void)setTimer
{
    self.secondsCount = TIMER_LENGTH;
    self.gameCountDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    
}
- (void)mathGameGlyphDetectorView:(MathGameGlyphDetectorView*)theView glyphDetected:(WTMGlyph *)glyph withScore:(float)score
{
    //Reject detection when quality too low
    //More info: http://britg.com/2011/07/17/complex-gesture-recognition-understanding-the-score/
    
    
    
    if (score < GESTURE_SCORE_THRESHOLD)
        return;
    else if([glyph.name isEqualToString:convertAnswer])
    {
        NSLog(@"WOOOOOOOO!HOOOOOO!~~~");
        
       
                       
        self.gameScore += self.gamePoints;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score:%i",self.gameScore];
       
               

        
        self.gestureDetectorView.userInteractionEnabled = NO;
        
        
        [self viewDidAppear:YES];
        
    }
    
}
-(void)saveScore {
    
    switch(self.modeNum)
    {
        
        case(1):
            [[NSUserDefaults standardUserDefaults]setInteger:self.finalAddingScore forKey:@"AddingHighScore"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            break;
        case(2):
            [[NSUserDefaults standardUserDefaults]setInteger:self.finalSubtractingScore forKey:@"SubtractingHighScore"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            break;
        case(3):
            [[NSUserDefaults standardUserDefaults]setInteger:self.finalDivideScore forKey:@"DivideHighScore"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            break;
        case(4):
            [[NSUserDefaults standardUserDefaults]setInteger:self.finalMultiplyScore forKey:@"MultiplyHighScore"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            break;
            
    }
    
}



-(void)timerRun
{
    self.secondsCount--;
    int seconds = self.secondsCount;
    
    NSString *timerOutput = [NSString stringWithFormat:@"%i",seconds];
    self.timerLabel.text = timerOutput;
    
    
    [self endOfGame];
    
    
    self.finalScoreView.userInteractionEnabled = YES;
   

    
}

-(void)endOfGame
{
    
    
    if(self.secondsCount == 0)
    {
        [self.gameCountDownTimer invalidate];
        
        self.gameCountDownTimer = nil;
        
        NSLog(@"THE FINAL_CURRENT SCORE IS %d!!!!!!!!!!!!!",self.gameScore);
        
        
        
        
        
        //The code underneath stops all interactive actions int the view.
        
               self.finalScoreView.hidden = NO;
        
        [self.gestureDetectorView.myPath removeAllPoints];
        [self.gestureDetectorView setNeedsDisplay];
        self.gestureDetectorView.userInteractionEnabled = NO;
        self.gestureDetectorView.enableDrawing = NO;
        
       
        
        [self animateEndGame];
           
        
       
        
        
    }
    

}



- (void)viewDidLoad
{
    
 
    
    [self setTimer];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score:0"];
    self.gameScore = 0;
    
    
     
    [super viewDidLoad];
    switch(self.modeNum) {
        case(1):
    self.highscore = [[NSUserDefaults standardUserDefaults]integerForKey:@"AddingHighScore"];
    self.highScoreLabel.text = [NSString stringWithFormat:@"Highscore: %i",self.highscore];
            break;
        case(2):
            self.highscore = [[NSUserDefaults standardUserDefaults]integerForKey:@"SubtractingHighScore"];
            self.highScoreLabel.text = [NSString stringWithFormat:@"Highscore: %i",self.highscore];
            break;
        case(3):
            self.highscore = [[NSUserDefaults standardUserDefaults]integerForKey:@"DivideHighScore"];
            self.highScoreLabel.text = [NSString stringWithFormat:@"Highscore: %i",self.highscore];
            break;
        case(4):
            self.highscore = [[NSUserDefaults standardUserDefaults]integerForKey:@"MultiplyHighScore"];
            self.highScoreLabel.text = [NSString stringWithFormat:@"Highscore: %i",self.highscore];
            break;
    }
    
   
}


-(void)setUpMathGame {
    
    int randomNum1 = arc4random()%self.num1;
    int randomNum2 = arc4random()%self.num2;
    
    self.showArithmatic.text = [NSString stringWithFormat:@"%d %@ %d",  MAX(randomNum1,randomNum2), self.oper, MIN(randomNum2,randomNum1)];
    
    //////////////////////////////////////////////////////////////////
  
    //////////////////////////////////////////////////////////////////
    
    //While loop goes here that says while answer does not equal decimal/floating number
    switch (self.modeNum)
    {
        case(1):
           self.answer = [NSNumber numberWithInt:(randomNum1 + randomNum2)];
            break;
        case(2):
            self.answer = [NSNumber numberWithInt:(MAX(randomNum1, randomNum2) - MIN(randomNum1, randomNum2))];
            NSLog(@"The answer is: %@",self.answer);
            break;
        case(3):
            //if((MAX(randomNum1, randomNum2))%(MIN(randomNum1, randomNum2))==0)
            //{
               self.answer = [NSNumber numberWithInt:(MAX(randomNum1,randomNum2) / MIN(randomNum1,randomNum2))];
            NSLog(@"The answer is: %@",self.answer);
            break;
            //}
            //else
            //{
                //[self setUpMathGame];
            //}
            
        case(4):
            self.answer = [NSNumber numberWithInt:(randomNum1 * randomNum2)];
            break;
            
    }

    self.showArithmatic.text = [NSString stringWithFormat:@"%d %@ %d",  MAX(randomNum1,randomNum2), self.oper, MIN(randomNum2,randomNum1)];
}




- (void)viewDidAppear:(BOOL)animated
{
    
        
        
    
    
   
    
    [self setUpMathGame];
    [super viewDidAppear:animated];
    
    
    self.formatter = [[NSNumberFormatter alloc]init];
    [self.formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    self.convertAnswer = [formatter stringForObjectValue:answer];
    
    
    
    self.gestureDetectorView = [[MathGameGlyphDetectorView alloc] initWithFrame:self.view.bounds];
    self.gestureDetectorView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.gestureDetectorView.delegate = self;
    for(int i = 0; i< self.jsontemplates.count; i++) {
        
        int index = i;
    [self.gestureDetectorView loadTemplatesWithNames:[self.jsontemplates objectAtIndex:index], nil];
    }
    [self.view addSubview:self.gestureDetectorView];
    
        
}

                                                     
                                

- (IBAction)exitButton:(UIButton *)sender
{

    //Create exit later once I create main page
}

- (IBAction)playAgainButton:(UIButton *)sender
{
    
    
    self.finalScoreView.hidden = YES;
    [self viewDidLoad];
    [self viewDidAppear:YES];
    
}



- (void)viewDidUnload
{
    
    [self.gestureDetectorView removeFromSuperview];
    self.gestureDetectorView.delegate = nil;
    self.gestureDetectorView = nil;
    [super viewDidUnload];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
