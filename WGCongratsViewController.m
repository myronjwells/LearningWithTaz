//
//  WGCongratsViewController.m
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 1/30/14.
//  Copyright (c) 2014 com.myronwells. All rights reserved.
//

#import "WGCongratsViewController.h"
#import "WordGameViewController.h"

@interface WGCongratsViewController ()

@end

@implementation WGCongratsViewController




- (void)viewDidLoad

{
    
    
    
    self.finalPointLabel.text = [NSString stringWithFormat:@"%i",wgGamePoints];
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}


@end
