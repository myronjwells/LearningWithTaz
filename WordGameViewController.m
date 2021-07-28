//
//  WordGameViewController.m
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 12/3/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import "WordGameViewController.h"
#import "Level.h"

#import "MainSceneViewController.h"

#import "config.h"

//<UIActionSheetDelegate> declares that the class conforms to the UIActionSheetDelegate protocol.
@interface WordGameViewController ()

//timer variables
@property(nonatomic) int secondsLeft;
@property (nonatomic,weak) NSTimer* timer;
@property (nonatomic)int secondsCount;
@property (nonatomic) NSTimer *gameCountDownTimer;
@property (assign, nonatomic) int value;

@end

@implementation WordGameViewController
{
    int endValue;
    double delta;
}


#pragma mark - Game manu


//app initilaizes itself from its storyboarde

-(instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self !=nil)
    {
        
        
        //create the game controller
        self.controller = [[WordGame alloc]init];
        
        
        

    }
    return self;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
    
}

int wgGamePoints = 0;

-(void)setScoreLabel {
    
    
    wgGamePoints = self.controller.points;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Points:%i",wgGamePoints];
    self.scoreLabel.font = [UIFont fontWithName:@"Marker Felt" size:11];
}




- (IBAction)exitGame:(id)sender {

    


    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Exit Game?" message:@"Are you sure you would like to exit the game?" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:@"Exit", nil];
     
     [alert show];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1)
    {
        [self performSegueWithIdentifier:@"segue.modal.alert" sender:self];
    }
}


-(void)setTimer
{
    self.secondsCount = self.controller.level.timeToSolve;
    self.gameCountDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    
}

-(void)timerRun
{
    self.secondsCount--;
    int seconds = self.secondsCount;
    
    NSString *timerOutput = [NSString stringWithFormat:@" %02.f : %02i", round(seconds / 60), seconds % 60 ];

    self.timerLabel.text = timerOutput;
    
    
    [self endOfGame];
    
}


-(void)endOfGame {
    if(self.secondsCount==0) {
        
        [self.gameCountDownTimer invalidate];
        self.gameCountDownTimer = nil;
        
        self.view.userInteractionEnabled = NO;
        self.timesUpScreen.hidden = NO;
        self.timesUpLabel.hidden = NO;
        
        //here sleep(2) the game then perform a segue to a nother viewcontroller that presents the points
        
        sleep(1);
        [self performSegueWithIdentifier:@"segue.modal.congrats" sender:self];
        
    }
}
    
    
    
    


    


                 
         
- (void)viewDidLoad
{
   
    
    self.mainView.userInteractionEnabled = YES;
    
    Level* level1 = [Level levelWithNum:1];
    NSLog(@"gameImages: %@", level1.gameImages);
    
    
    //add one layer for all game elements
    //1 Create new view with dimensons of the screen
    UIView* gameLayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
  
   
    
    [self.view addSubview: gameLayer];
    
    
   
    
  
    
    //2 Add new view to the gameView property of WordGame.h

    self.controller.gameView = gameLayer;
       self.controller.level = level1;
    
    
    [self.controller dealRandomImage];
    
    UIImage* pictures = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",self.controller.image]];
    [[self imageView]setImage:pictures];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setImages) name:@"DoSetImages" object:nil];
    [self setTimer];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setScoreLabel) name:@"DoSetScoreLabel" object:nil];
    
    //Allows the combination of IB with coded view
    [self.view insertSubview:gameLayer belowSubview:self.exitButton];
        [super viewDidLoad];
    
   	// Do any additional setup after loading the view.
    

}




-(void)setImages
{
    UIImage* pictures = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",self.controller.image]];
    [[self imageView]setImage:pictures];
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
