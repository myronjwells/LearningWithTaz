//
//  TutorialRootViewController.h
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 1/26/14.
//  Copyright (c) 2014 com.myronwells. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MathModes.h"

extern NSString* skipToSegueName;
@interface TutorialRootViewController : UIViewController <UIPageViewControllerDelegate,UIActionSheetDelegate>
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (weak, nonatomic) IBOutlet UIView *rootSubView;
@property (strong, nonatomic) MathModes* mode;
@property (nonatomic) int mathSegueCheck;


@end


