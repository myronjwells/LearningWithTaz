//
//  MainSceneViewController.h
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 12/25/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TutorialModelController.h"
#import "TutorialRootViewController.h"

@interface MainSceneViewController : UIViewController <UIActionSheetDelegate> 


@property (strong, nonatomic) TutorialModelController* tutmc;
@property (strong, nonatomic) TutorialRootViewController* trvc;
@property (nonatomic) int indexNum;
@end
