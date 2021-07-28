//
//  TutorialDataViewController.m
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 1/26/14.
//  Copyright (c) 2014 com.myronwells. All rights reserved.
//

#import "TutorialDataViewController.h"

@interface TutorialDataViewController ()

@end

@implementation TutorialDataViewController

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.dataContent.image = self.dataObject;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

@end
