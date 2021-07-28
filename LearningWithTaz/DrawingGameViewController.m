//
//  DrawingGameViewController.m
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 11/10/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import "DrawingGameViewController.h"

@interface DrawingGameViewController ()

@end

@implementation DrawingGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    red = 0.0/255.0;
    yellow = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 10.0;
    opacity = 1.0;
    [self noPrimeColors];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


//The last point variable is being initialized to the current touch point variable "The brush is hitting the paper".:
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
    [self noPrimeColors];
    [self noMixColors];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawingImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    //you get the current touch point and then draw a line with CGContextAddLineToPoint from lastPoint to currentPoint. This is suppose to give the appearance of a smoothe curve: 
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    //setting brush size and opacity and brush stroke color:
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, yellow, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    //drawing the path:
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawingImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawingImage setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}


// However, if the mouse was not swiped, then it means user just tapped the screen to draw a single point. In that case, just draw a single point.Once the brush stroke is done,
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // if the mouse was not swiped, then it means user just tapped the screen to draw a single point. Else not and touchesMoved was called.
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawingImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, yellow, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawingImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    //merge the tempDrawImage with mainImage:
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawingImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawingImage.image = nil;
    UIGraphicsEndImageContext();
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ErasePressed:(UIButton *)sender
{
    //removes selected colors
    [self noPrimeColors];
    [self noMixColors];

    
    //Sets the color pallete to white which resembles an erase.
    red = 255.0/255.0;
    yellow = 255.0/255.0;
    blue = 255.0/255.0;
    opacity = 1.0;
    
}

- (IBAction)reset:(id)sender
{
    //resets the main image by setting it to nil
    self.mainImage.image = nil;

}


- (IBAction)redButton:(UIButton *)sender
{
    
    NSLog(@"I am red!");
    red = 255.0/255.0;
    yellow = 0.0/255.0;
    blue = 0.0/255.0;
    self.redButton.selected = YES;


    if([self.blueButton isSelected]) {
        NSLog(@"I make purple");
        red = 255.0/255.0;
        yellow = 0.0/255.0;
        blue = 255.0/255.0;
        purpleColor = YES;
        self.blueButton.selected = NO;
        self.redButton.selected = NO;
    }
    if([self.yellowButton isSelected]) {
        NSLog(@"i make orange");
        red = 255.0/255.0;
        yellow = 125.0/255.0;
        blue = 0.0/255.0;
        orangeColor = YES;
        self.yellowButton.selected = NO;
        self.redButton.selected = NO;
    }
    if([self.whiteButton isSelected]) {
        NSLog(@"i make pink");
        red = 255.0/255.0;
        yellow = 163.0/255.0;
        blue = 219.0/255.0;
        pinkColor = YES;
        self.whiteButton.selected = NO;
        self.redButton.selected = NO;
    }
    if([self.blackButton isSelected]) {
        NSLog(@"i make darkred");
        red = 160.0/255.0;
        yellow = 0.0/255.0;
        blue = 0.0/255.0;
        darkRedColor = YES;
        self.blackButton.selected = NO;
        self.redButton.selected = NO;
    }
    
    
 else {
    


if([self.redButton isSelected]) {
    

    if(orangeColor) {
        NSLog(@"I make redOrange");
        red = 255.0/255.0;
        yellow = 80.0/255.0;
        blue = 0.0/255.0;
        [self noPrimeColors];
         self.redButton.selected = YES;
    }
    if(purpleColor) {
        NSLog(@"i make burgundy");
        red = 186.0/255.0;
        yellow = 0.0/255.0;
        blue = 67.0/255.0;
        [self noPrimeColors];
         self.redButton.selected = YES;
    }
    if(greenColor) {
        NSLog(@"i make brown");
        red = 131.0/255.0;
        yellow = 49.0/255.0;
        blue = 0.0/255.0;
        [self noPrimeColors];
         self.redButton.selected = YES;
    }
    if(lightBlueColor) {
        NSLog(@"i make lightpurple");
        red = 184.0/255.0;
        yellow = 91.0/255.0;
        blue = 102.0/255.0;
        [self noPrimeColors];
         self.redButton.selected = YES;
    }
    if(lightYellowColor) {
        NSLog(@"I make lightOrange");
        red = 255.0/255.0;
        yellow = 128.0/255.0;
        blue = 62.0/255.0;
        [self noPrimeColors];
         self.redButton.selected = YES;
    }
    if(darkRedColor) {
        NSLog(@"i make mediumRed");
        red = 207.0/255.0;
        yellow = 0.0/255.0;
        blue = 0.0/255.0;
        [self noPrimeColors];
         self.redButton.selected = YES;
    }
    if(pinkColor) {
        NSLog(@"i make pink/red");
        red = 255.0/255.0;
        yellow = 70.0/255.0;
        blue = 81.0/255.0;
        [self noPrimeColors];
         self.redButton.selected = YES;
    }
    if(greyColor) {
        NSLog(@"i make grey/red");
        red = 203.0/255.0;
        yellow = 100.0/255.0;
        blue = 100.0/255.0;
        [self noPrimeColors];
         self.redButton.selected = YES;
    }
    if(oliveColor) {
        NSLog(@"i make olive/red");
        red = 204.0/255.0;
        yellow = 86.0/255.0;
        blue = 0.0/255.0;
        [self noPrimeColors];
         self.redButton.selected = YES;
    }
    if(darkBlueColor) {
        NSLog(@"i make darkPurple");
        red = 119.0/255.0;
        yellow = 0.0/255.0;
        blue = 74.0/255.0;

        [self noPrimeColors];
         self.redButton.selected = YES;
    }
    
}
 }

    
        
        
        
        
   

    
        
    
}
//Copy this format it is accurate!!
//////////////////////////////////////////////
- (IBAction)blueButton:(UIButton *)sender
{
    
    
    
        NSLog(@"I am blue!");
        red = 0.0/255.0;
        yellow = 0.0/255.0;
        blue = 255.0/255.0;
        self.blueButton.selected = YES;
        //[self noMixColors];
        
    

    
    if([self.redButton isSelected]) {
        NSLog(@"I make purple");
        red = 255.0/255.0;
        yellow = 0.0/255.0;
        blue = 255.0/255.0;

        purpleColor = YES;
        self.redButton.selected = NO;
        self.blueButton.selected = NO;
    }
    if([self.yellowButton isSelected]) {
        NSLog(@"i make green");
        red = 0.0/255.0;
        yellow = 255.0/255.0;
        blue = 0.0/255.0;

        greenColor = YES;
        self.yellowButton.selected = NO;
        self.blueButton.selected = NO;
    }
    if([self.whiteButton isSelected]) {
         NSLog(@"i make lightblue");
        red = 165.0/255.0;
        yellow = 165.0/255.0;
        blue = 250.0/255.0;

        lightBlueColor = YES;
        self.whiteButton.selected = NO;
        self.blueButton.selected = NO;
    }
    if([self.blackButton isSelected]) {
        NSLog(@"i make darkblue");
        red = 0.0/255.0;
        yellow = 0.0/255.0;
        blue = 162.0/255.0;

        darkBlueColor = YES;
        self.blackButton.selected = NO;
        self.blueButton.selected = NO;
        
    } else {
        
    
    
    if([self.blueButton isSelected]) {
        
    
    if(orangeColor) {
        NSLog(@"I make blue/orange");
        red = 186.0/255.0;
        yellow = 60.0/255.0;
        blue = 69.0/255.0;

        [self noPrimeColors];
        self.blueButton.selected = YES;
    }
    ///////*******//
    if(purpleColor) {
        NSLog(@"i make indigo");
        red = 158.0/255.0;
        yellow = 24.0/255.0;
        blue = 255.0/255.0;

        [self noPrimeColors];
        self.blueButton.selected = YES;
       
    }
    if(greenColor) {
        NSLog(@"i make turquois");
        
        red = 0.0/255.0;
        yellow = 141.0/255.0;
        blue = 114.0/255.0;

        [self noPrimeColors];
        self.blueButton.selected = YES;
    }
    if(lightBlueColor) {
        NSLog(@"i make blue/lightBlue");
        red = 72.0/255.0;
        yellow = 73.0/255.0;
        blue = 255.0/255.0;

        [self noPrimeColors];
        self.blueButton.selected = YES;
    }
    if(lightYellowColor) {
        NSLog(@"I make lightGreen");
        red = 127.0/255.0;
        yellow = 238.0/255.0;
        blue = 97.0/255.0;

        [self noPrimeColors];
        self.blueButton.selected = YES;
    }
    if(darkRedColor ) {
        NSLog(@"i make Violet");
        red = 90.0/255.0;
        yellow = 0.0/255.0;
        blue = 90.0/255.0;

        [self noPrimeColors];
        self.blueButton.selected = YES;
    }
    if(pinkColor) {
        NSLog(@"i make pink/blue");
        red = 165.0/255.0;
        yellow = 104.0/255.0;
        blue = 228.0/255.0;

        [self noPrimeColors];
        self.blueButton.selected = YES;
    }
    if(greyColor) {
        NSLog(@"i make grey/blue");
        red = 119.0/255.0;
        yellow = 119.0/255.0;
        blue = 197.0/255.0;

        [self noPrimeColors];
        self.blueButton.selected = YES;
    }
    if(oliveColor) {
        NSLog(@"i make olive/blue");
        red = 107.0/255.0;
        yellow = 109.0/255.0;
        blue = 39.0/255.0;

        [self noPrimeColors];
        self.blueButton.selected = YES;
    }
    if(darkBlueColor) {
        NSLog(@"i make mediumblue");
        red = 76.0/255.0;
        yellow = 73.0/255.0;
        blue = 205.0/255.0;

        [self noPrimeColors];
        self.blueButton.selected = YES;
    }
    }
    }

}
- (IBAction)yellowButton:(UIButton *)sender
{
    
    NSLog(@"I am yellow!");
    red = 255.0/255.0;
    yellow = 246.0/255.0;
    blue = 0.0/255.0;
    self.yellowButton.selected = YES;
    
    if([self.redButton isSelected]) {
        NSLog(@"I make orange");
        red = 255.0/255.0;
        yellow = 125.0/255.0;
        blue = 0.0/255.0;
        orangeColor = YES;
        self.redButton.selected = NO;
        self.yellowButton.selected = NO;
    }
    if([self.blueButton isSelected]) {
        NSLog(@"i make green");
        red = 0.0/255.0;
        yellow = 255.0/255.0;
        blue = 0.0/255.0;
        greenColor = YES;
        self.blueButton.selected = NO;
        self.yellowButton.selected = NO;
    }
    if([self.whiteButton isSelected]) {
        NSLog(@"i make lightyellow");
        red = 255.0/255.0;
        yellow = 254.0/255.0;
        blue = 139.0/255.0;
        lightYellowColor = YES;
        self.whiteButton.selected = NO;
        self.yellowButton.selected = NO;
    }
    if([self.blackButton isSelected]) {
        NSLog(@"i make olive");
        red = 181.0/255.0;
        yellow = 179.0/255.0;
        blue = 0.0/255.0;
        oliveColor = YES;
        self.blackButton.selected = NO;
        self.yellowButton.selected = NO;
    }
    
    else {
        
    
    
    if([self.yellowButton isSelected]) {
    if(orangeColor) {
        NSLog(@"I make yellow/orange");
        red = 255.0/255.0;
        yellow = 205.0/255.0;
        blue = 5.0/255.0;

        [self noPrimeColors];
        self.yellowButton.selected = YES;
    }
    if(purpleColor) {
        NSLog(@"i make brown");
        red = 161.0/255.0;
        yellow = 83.0/255.0;
        blue = 0.0/255.0;

        [self noPrimeColors];
        self.yellowButton.selected = YES;
    }
    if(greenColor) {
        NSLog(@"i make limegreen");
        red = 186.0/255.0;
        yellow = 255.0/255.0;
        blue = 0.0/255.0;

        [self noPrimeColors];
        self.yellowButton.selected = YES;
    }
    if(lightBlueColor) {
        NSLog(@"i make lightGreen");
        red = 195.0/255.0;
        yellow = 224.0/255.0;
        blue = 115.0/255.0;

        [self noPrimeColors];
        self.yellowButton.selected = YES;
    }
    if(lightYellowColor) {
        NSLog(@"I make mediumYellow");
        red = 250.0/255.0;
        yellow = 252.0/255.0;
        blue = 89.0/255.0;

        [self noPrimeColors];
        self.yellowButton.selected = YES;
    }
    if(darkRedColor) {
        NSLog(@"i make darkOrange");
        red = 226.0/255.0;
        yellow = 80.0/255.0;
        blue = 0.0/255.0;

        [self noPrimeColors];
        self.yellowButton.selected = YES;
    }
    if(pinkColor) {
        NSLog(@"i make lightOrange");
        red = 252.0/255.0;
        yellow = 150.0/255.0;
        blue = 110.0/255.0;

        [self noPrimeColors];
        self.yellowButton.selected = YES;
    }
    if(greyColor) {
        NSLog(@"i make grey/yellow");
        red = 215.0/255.0;
        yellow = 214.0/255.0;
        blue = 214.0/255.0;

        [self noPrimeColors];
        self.yellowButton.selected = YES;
    }
    if(oliveColor) {
        NSLog(@"i make olive/yellow");
        red = 209.0/255.0;
        yellow = 207.0/255.0;
        blue = 30.0/255.0;

        [self noPrimeColors];
        self.yellowButton.selected = YES;
    }
    if(darkBlueColor) {
        NSLog(@"i make darkGreen");
        red = 0.0/255.0;
        yellow = 90.0/255.0;
        blue = 0.0/255.0;

        [self noPrimeColors];
        self.yellowButton.selected = YES;
    }
    }
    }

}
- (IBAction)blackButton:(id)sender
{
    
    NSLog(@"I am black!");
    red = 0.0/255.0;
    yellow = 0.0/255.0;
    blue = 0.0/255.0;
    self.blackButton.selected = YES;
    
    if([self.redButton isSelected]) {
        NSLog(@"I make darkred");
        red = 160.0/255.0;
        yellow = 0.0/255.0;
        blue = 0.0/255.0;
        darkRedColor = YES;
        self.redButton.selected = NO;
        self.blackButton.selected = NO;
    }
    if([self.yellowButton isSelected]) {
        NSLog(@"i make olive");
        red = 181.0/255.0;
        yellow = 179.0/255.0;
        blue = 0.0/255.0;
        oliveColor = YES;
        self.yellowButton.selected = NO;
        self.blackButton.selected = NO;
    }
    if([self.whiteButton isSelected]) {
        NSLog(@"i make grey");
        red = 161.0/255.0;
        yellow = 161.0/255.0;
        blue = 161.0/255.0;
        greyColor = YES;
        self.whiteButton.selected = NO;
        self.blackButton.selected = NO;
    }
    if([self.blueButton isSelected]) {
        NSLog(@"i make darkblue");
        red = 0.0/255.0;
        yellow = 0.0/255.0;
        blue = 162.0/255.0;
        darkBlueColor = YES;
        self.blackButton.selected = NO;
        self.blackButton.selected = NO;
    }
    else {
        
       
    
    if([self.blackButton isSelected]) {
    if(orangeColor) {
        NSLog(@"I make burntOrange");
        red = 158.0/255.0;
        yellow = 67.0/255.0;
        blue = 0.0/255.0;
        [self noPrimeColors];
        self.blackButton.selected = YES;
    }
    if(purpleColor) {
        NSLog(@"i make deepPurple");
        red = 140.0/255.0;
        yellow = 0.0/255.0;
        blue = 132.0/255.0;
        [self noPrimeColors];
        self.blackButton.selected = YES;
    }
    if(greenColor) {
        NSLog(@"i make deepGreen");
        red = 0.0/255.0;
        yellow = 92.0/255.0;
        blue = 113.0/255.0;
        [self noPrimeColors];
        self.blackButton.selected = YES;
    }
    if(lightBlueColor) {
        NSLog(@"i make Blue");
        red = 83.0/255.0;
        yellow = 107.0/255.0;
        blue = 196.0/255.0;
        [self noPrimeColors];
        self.blackButton.selected = YES;
    }
    if(lightYellowColor) {
        NSLog(@"I make LightOlive");
        red = 158.0/255.0;
        yellow = 155.0/255.0;
        blue = 79.0/255.0;
        [self noPrimeColors];
        self.blackButton.selected = YES;
    }
    if(darkRedColor) {
        NSLog(@"i make DeepRed");
        red = 109.0/255.0;
        yellow = 0.0/255.0;
        blue = 0.0/255.0;
        [self noPrimeColors];
        self.blackButton.selected = YES;
    }
    if(pinkColor) {
        NSLog(@"i make black/pink");
        red = 171.0/255.0;
        yellow = 94.0/255.0;
        blue = 94.0/255.0;
        [self noPrimeColors];
        self.blackButton.selected = YES;
    }
    if(greyColor) {
        NSLog(@"i make dark grey");
        red = 111.0/255.0;
        yellow = 111.0/255.0;
        blue = 111.0/255.0;
        [self noPrimeColors];
        self.blackButton.selected = YES;
    }
    if(oliveColor) {
        NSLog(@"i make darkOlive");
        red = 89.0/255.0;
        yellow = 84.0/255.0;
        blue = 0.0/255.0;
        [self noPrimeColors];
        self.blackButton.selected = YES;
    }
    if(darkBlueColor) {
        NSLog(@"i make deepBlue");
        red = 0.0/255.0;
        yellow = 0.0/255.0;
        blue = 89.0/255.0;
        [self noPrimeColors];
        self.blackButton.selected = YES;
    }
    }
    }
    
        
       
    

}
- (IBAction)whiteButton:(UIButton *)sender
{
    
    NSLog(@"I am white!");
    red = 255.0/255.0;
    yellow = 255.0/255.0;
    blue = 255.0/255.0;
    self.whiteButton.selected = YES;
    
    if([self.redButton isSelected]) {
        NSLog(@"I make pink");
        red = 255.0/255.0;
        yellow = 163.0/255.0;
        blue = 219.0/255.0;
        self.redButton.selected = NO;
        self.whiteButton.selected = NO;
       
    }
    if([self.yellowButton isSelected]) {
        NSLog(@"i make lightyellow");
        red = 255.0/255.0;
        yellow = 254.0/255.0;
        blue = 139.0/255.0;
        lightYellowColor = YES;
        self.yellowButton.selected = NO;
        self.whiteButton.selected = NO;
    }
    if([self.blueButton isSelected]) {
        NSLog(@"i make lightblue");
        red = 165.0/255.0;
        yellow = 165.0/255.0;
        blue = 250.0/255.0;
        lightBlueColor = YES;
        self.whiteButton.selected = NO;
        self.blueButton.selected = NO;
    }
    if([self.blackButton isSelected]) {
        NSLog(@"i make grey");
        red = 161.0/255.0;
        yellow = 161.0/255.0;
        blue = 161.0/255.0;
        greyColor = YES;
        self.blackButton.selected = NO;
        self.whiteButton.selected = NO;
    }
    
    else {
        
    
    
    if([self.whiteButton isSelected]) {
    if(orangeColor) {
        NSLog(@"I make lightOrange");
        red = 2551.0/255.0;
        yellow = 203.0/255.0;
        blue = 136.0/255.0;
        [self noPrimeColors];
        self.whiteButton.selected = YES;
    }
    if(purpleColor) {
        NSLog(@"i make lightPurple");
        red = 242.0/255.0;
        yellow = 168.0/255.0;
        blue = 245.0/255.0;
        [self noPrimeColors];
        self.whiteButton.selected = YES;
    }
    if(greenColor) {
        NSLog(@"i make lightGreen");
        red = 180.0/255.0;
        yellow = 255.0/255.0;
        blue = 185.0/255.0;
        [self noPrimeColors];
        self.whiteButton.selected = YES;
    }
    if(lightBlueColor) {
        NSLog(@"i make lighterBlue");
        red = 221.0/255.0;
        yellow = 233.0/255.0;
        blue = 255.0/255.0;
        [self noPrimeColors];
        self.whiteButton.selected = YES;
    }
    if(lightYellowColor) {
        NSLog(@"I make lighterYellow");
        red = 255.0/255.0;
        yellow = 255.0/255.0;
        blue = 214.0/255.0;
        [self noPrimeColors];
        self.whiteButton.selected = YES;
    }
    if(darkRedColor) {
        NSLog(@"i make red");
        red = 255.0/255.0;
        yellow = 0.0/255.0;
        blue = 0.0/255.0;
        [self noPrimeColors];
        self.whiteButton.selected = YES;
    }
    if(pinkColor) {
        NSLog(@"i make lightPink");
        red = 255.0/255.0;
        yellow = 217.0/255.0;
        blue = 230.0/255.0;
        [self noPrimeColors];
        self.whiteButton.selected = YES;
    }
    if(greyColor) {
        NSLog(@"i make lightGrey");
        red = 240.0/255.0;
        yellow = 240.0/255.0;
        blue = 240.0/255.0;
        [self noPrimeColors];
        self.whiteButton.selected = YES;
    }
    if(oliveColor) {
        NSLog(@"i make yellow");
        red = 255.0/255.0;
        yellow = 240.0/255.0;
        blue = 0.0/255.0;
        [self noPrimeColors];
        self.whiteButton.selected = YES;
    }
    if(darkBlueColor) {
        NSLog(@"i make blue");
        red = 0.0/255.0;
        yellow = 0.0/255.0;
        blue = 255.0/255.0;
        [self noPrimeColors];
        self.whiteButton.selected = YES;
    }
    }
    }
        
        
    

}

-(void)noMixColors {
    purpleColor = NO;
    greenColor = NO;
    lightBlueColor = NO;
    lightYellowColor = NO;
    oliveColor = NO;
    pinkColor = NO;
    orangeColor = NO;
    darkRedColor = NO;
    darkBlueColor = NO;
    greyColor = NO;
    

}
-(void)noPrimeColors {
    self.yellowButton.selected = NO;
    self.redButton.selected = NO;
    self.blueButton.selected = NO;
    self.whiteButton.selected = NO;
    self.blackButton.selected = NO;
}

@end
