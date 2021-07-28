//
//  TutorialModelController.m
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 1/26/14.
//  Copyright (c) 2014 com.myronwells. All rights reserved.
//


#import "TutorialModelController.h"

#import "TutorialDataViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */



@implementation TutorialModelController


int buttonTag = 0;

- (id)init
{
    
    
    self = [super init];
    if (self) {
        
        
        // Create the data model.
        NSLog(@"Tag %i",buttonTag);
        if(buttonTag==1)
        {
            
        
        _pageData = [[NSArray alloc] initWithObjects:
                     [UIImage imageNamed:@"one.png"],
                     [UIImage imageNamed:@"two.png"],
                     [UIImage imageNamed:@"three.png"],
                     [UIImage imageNamed:@"four.png"],
                     [UIImage imageNamed:@"five.png"],
                     [UIImage imageNamed:@"six.png"],
                     nil];
        }
    if(buttonTag==2)
{
    
    
    _pageData = [[NSArray alloc] initWithObjects:
                 [UIImage imageNamed:@"two.png"],
                 [UIImage imageNamed:@"one.png"],
                 [UIImage imageNamed:@"three.png"],
                 [UIImage imageNamed:@"four.png"],
                 [UIImage imageNamed:@"five.png"],
                 [UIImage imageNamed:@"six.png"],
                 nil];
}
        if(buttonTag==3)
        {
            
            
            _pageData = [[NSArray alloc] initWithObjects:
                         [UIImage imageNamed:@"three.png"],
                         [UIImage imageNamed:@"two.png"],
                         [UIImage imageNamed:@"one.png"],
                         [UIImage imageNamed:@"four.png"],
                         [UIImage imageNamed:@"five.png"],
                         [UIImage imageNamed:@"six.png"],
                         nil];
        }
        if(buttonTag==4)
        {
            
            
            _pageData = [[NSArray alloc] initWithObjects:
                         [UIImage imageNamed:@"four.png"],
                         [UIImage imageNamed:@"two.png"],
                         [UIImage imageNamed:@"three.png"],
                         [UIImage imageNamed:@"one.png"],
                         [UIImage imageNamed:@"five.png"],
                         [UIImage imageNamed:@"six.png"],
                         nil];
        }
        if(buttonTag==5)
        {
            
            
            _pageData = [[NSArray alloc] initWithObjects:
                         [UIImage imageNamed:@"five.png"],
                         [UIImage imageNamed:@"two.png"],
                         [UIImage imageNamed:@"three.png"],
                         [UIImage imageNamed:@"four.png"],
                         [UIImage imageNamed:@"one.png"],
                         [UIImage imageNamed:@"six.png"],
                         nil];
        }



    }
    return self;
}

- (TutorialDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    TutorialDataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataViewController.dataObject = self.pageData[index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(TutorialDataViewController *)viewController
{
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(TutorialDataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(TutorialDataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
