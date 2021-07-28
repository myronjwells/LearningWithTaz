//
//  DrawingGameViewController.h
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 11/10/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DrawingGameViewController : UIViewController
{
    CGPoint lastPoint;
    CGFloat red;
    CGFloat yellow;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    NSInteger mixingTags;
    BOOL   orangeColor;
    BOOL   purpleColor;
    BOOL   pinkColor;
    BOOL   oliveColor;
    BOOL   greenColor;
    BOOL   lightBlueColor;
    BOOL   darkBlueColor;
    BOOL   greyColor;
    BOOL   darkRedColor;
    BOOL   lightYellowColor;
    
    BOOL mouseSwiped;
    int tapCount;
}



@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *yellowButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *blackButton;
@property (weak, nonatomic) IBOutlet UIButton *whiteButton;

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawingImage;
- (IBAction)ErasePressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *reset;

@property (weak, nonatomic) IBOutlet UIButton *save;

@end
