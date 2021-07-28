//
//  TutorialRootViewController.m
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 1/26/14.
//  Copyright (c) 2014 com.myronwells. All rights reserved.
//

#import "TutorialRootViewController.h"

#import "TutorialModelController.h"

#import "TutorialDataViewController.h"
#import "MathGameViewController.h"

@interface TutorialRootViewController () 

@property (nonatomic) int indexNum;
@property (strong, nonatomic) MathGameViewController* mathvc;


@property (readonly, strong, nonatomic) TutorialModelController *modelController;
@end

@implementation TutorialRootViewController

@synthesize modelController = _modelController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    self.indexNum = 0;
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    
    TutorialDataViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    self.pageViewController.dataSource = self.modelController;
    
    [self addChildViewController:self.pageViewController];
    
    //[self.view addSubview:self.pageViewController.view];
    [self.rootSubView addSubview:self.pageViewController.view];
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.rootSubView.bounds;
    self.pageViewController.view.frame = pageViewRect;
    
    [self.pageViewController didMoveToParentViewController:self];
    
    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (TutorialModelController *)modelController
{
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[TutorialModelController alloc] init];
    }
    return _modelController;
}

#pragma mark - UIPageViewController delegate methods

/*
 - (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
 {
 
 }
 */

NSString* skipToSegueName = nil;
- (IBAction)skipToGame:(UIButton *)sender
{
    //BOOL isMathSegue = NO;
     //NSLog(@"INDEX NUM: %d",buttonTag);
    
    if(buttonTag==2) {
    UIActionSheet *mathModeActionSheet = [[UIActionSheet alloc]initWithTitle:@"Title" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add",@"Subtract",@"Division",@"Multiply",@"Random", nil];
    
    
    [mathModeActionSheet showInView:self.view];
    }
    
    else {
    
    
    [self performSegueWithIdentifier:skipToSegueName sender:self];
    }
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:
(NSInteger)buttonIndex {
    
    
    
    
    if(buttonIndex == 0)
    {
        
        
       
        
        self.indexNum = 1;
        
        [self performSegueWithIdentifier:@"segue.skipToMath" sender:self];
    }
    
    if(buttonIndex == 1)
    {
        
        
       
        
        self.indexNum = 2;
        
        [self performSegueWithIdentifier:@"segue.skipToMath" sender:self];
    }
    
    if(buttonIndex == 2)
    {
        
        
       
        
        self.indexNum = 3;
        
        [self performSegueWithIdentifier:@"segue.skipToMath" sender:self];
    }
    
    if(buttonIndex == 3)
    {
        
        
        
        
        self.indexNum = 4;
        
        [self performSegueWithIdentifier:@"segue.skipToMath" sender:self];
    }
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier]isEqualToString:@"segue.skipToMath"]) {
        
                
        self.mathSegueCheck = 1;
        
        self.mathvc = segue.destinationViewController;
        
        self.mode = [MathModes ModeWithNum:self.indexNum];
        
        [self.mathvc setNum1:self.mode.scale1];
        [self.mathvc setNum2:self.mode.scale2];
        [self.mathvc setOper:self.mode.operation];
        [self.mathvc setModeNum:self.mode.numMode];
        [self.mathvc setJsontemplates:self.mode.gestureTemplates];
        [self.mathvc setGamePoints:self.mode.points];
        //buttonTag = 2;
        //skipToSegueName = [NSString stringWithFormat:@"segue.skipToMath"];
        NSLog(@"array:%@, scale1:%d, points:%d, operation:%@",self.mode.gestureTemplates, self.mode.scale1, self.mode.points, self.mode.operation );
        
        
        
    }
}


- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    // Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
    UIViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = @[currentViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    self.pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
}

@end
