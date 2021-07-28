//
//  TutorialModelController.h
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 1/26/14.
//  Copyright (c) 2014 com.myronwells. All rights reserved.
//

#import <Foundation/Foundation.h>

extern int buttonTag;

@class TutorialDataViewController;


@interface TutorialModelController : NSObject <UIPageViewControllerDataSource>


@property (readwrite,strong, nonatomic) NSArray *pageData;




- (TutorialDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(TutorialDataViewController *)viewController;

@end
