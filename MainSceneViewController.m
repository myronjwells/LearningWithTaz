//
//  MainSceneViewController.m
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 12/25/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import "MainSceneViewController.h"
#import "MathGameViewController.h"
#import "DrawingGameViewController.h"
#import "TutorialModelController.h"
#import "TutorialRootViewController.h"   
#import <QuartzCore/CoreAnimation.h>
#import "config.h"

@interface MainSceneViewController ()
@property (weak, nonatomic) IBOutlet UIButton *drawingButton;
@property (weak, nonatomic) IBOutlet UIButton *mathButton;
@property (weak, nonatomic) IBOutlet UIButton *memoryButton;
@property (weak, nonatomic) IBOutlet UIButton *spellingButton;
@property (weak, nonatomic) IBOutlet UIButton *puzzleButton;
@property (weak, nonatomic) IBOutlet UIImageView *tazImage;
@property (nonatomic) CGPoint drawPoint0,mathPoint0,memPoint0,spellPoint0,puzzPoint0,tazPoint0;


@end

@implementation MainSceneViewController



- (IBAction)mathButtonAction:(id)sender
{
        
    [self performSegueWithIdentifier:@"segue.modal.mathAction" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier]isEqualToString:@"segue.modal.mathAction"]) {
        
        self.trvc = segue.destinationViewController;

     
        buttonTag = 2;
        skipToSegueName = [NSString stringWithFormat:@"segue.skipToMath"];

        
        
    }
    
if([[segue identifier]isEqualToString:@"segue_drawingGame"])
{
   
    self.trvc = segue.destinationViewController;

    
    buttonTag = 1;
    
    
    
    skipToSegueName = [NSString stringWithFormat:@"segue.skipToDraw"];
    
}
    if([[segue identifier]isEqualToString:@"segue.puzzlegame"]) {
        buttonTag = 5;
        
         
        skipToSegueName = [NSString stringWithFormat:@"segue.skipToPuzzle"];
    }
    if([[segue identifier]isEqualToString:@"segue_wordGame"]) {
        buttonTag = 4;
        
        
        skipToSegueName = [NSString stringWithFormat:@"segue.skipToWord"];
    }
    
    if([[segue identifier]isEqualToString:@"segue_memGame"]) {
        buttonTag = 3;
         
        
        skipToSegueName = [NSString stringWithFormat:@"segue.skipToMem"];
    }
}


- (void)viewDidLoad
{
    
    

    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated {
        
    _drawPoint0 = self.drawingButton.frame.origin;
    
    _mathPoint0 = self.mathButton.frame.origin;
    
    _memPoint0  = self.memoryButton.frame.origin;
    
    _spellPoint0= self.spellingButton.frame.origin;
    
    _puzzPoint0 = self.puzzleButton.frame.origin;
    
    _tazPoint0 = self.tazImage.center;
    
    CGPoint drawPoint1  = { _drawPoint0.x - (kScreenWidth/2.0), _drawPoint0.y };
    CGPoint mathPoint1  = { _mathPoint0.x + (kScreenWidth/2.0)+40,   _mathPoint0.y };
     CGPoint memPoint1  = { _memPoint0.x - (kScreenWidth/2.0),    _memPoint0.y  };
     CGPoint spellPoint1= { _spellPoint0.x + (kScreenWidth/2.0)+40,  _spellPoint0.y};
     CGPoint puzzPoint1 = { _puzzPoint0.x - (kScreenWidth/2.0),   _puzzPoint0.y };
    CGPoint tazPoint1 = {_tazPoint0.x, _tazPoint0.y -80};
    
    [self moveButtonAnimation:self.drawingButton  from:_drawPoint0  to:drawPoint1];
    [self moveButtonAnimation:self.mathButton     from:_mathPoint0  to:mathPoint1];
    [self moveButtonAnimation:self.memoryButton   from:_memPoint0   to:memPoint1];
    [self moveButtonAnimation:self.spellingButton from:_spellPoint0 to:spellPoint1];
    [self moveButtonAnimation:self.puzzleButton   from:_puzzPoint0  to:puzzPoint1];
    
    [self moveSpriteAnimation:self.tazImage from:_tazPoint0 to:tazPoint1];
    
    
    
}
-(void)moveButtonAnimation:(UIButton*)button from:(CGPoint)point0 to:(CGPoint)point1
{
    
    CABasicAnimation *moveButton = [CABasicAnimation animationWithKeyPath:@"position.x"];
    moveButton.fromValue      = @(point0.x);
    moveButton.toValue        = @(point1.x);
    moveButton.duration       = 0.3f;
    moveButton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    
    [button.layer addAnimation:moveButton forKey:@"position.x"];
    button.center = point1;
}

-(void)moveSpriteAnimation:(UIImageView*)sprite from:(CGPoint)point0 to:(CGPoint)point1
{
    CABasicAnimation *moveSprite = [CABasicAnimation animationWithKeyPath:@"position.y"];
    moveSprite.fromValue      = @(point0.y);
    moveSprite.toValue        = @(point1.y);
    moveSprite.duration       = 3.0f;
    moveSprite.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

    [sprite.layer addAnimation:moveSprite forKey:@"position.x"];
    sprite.center = point1;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
