//
//  WordGame.h
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 12/3/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Level.h"
#import "TileView.h"
#import "TargetView.h"



@class WordGameViewController;

typedef void (^CallbackBlock)();
@interface WordGame : NSObject <TileDragDelegateProtocol>

//the view to add game elements to
@property (weak, nonatomic) UIView* gameView;

@property(nonatomic) NSString *image;

//the current level
@property (strong, nonatomic) Level* level;

@property (nonatomic) NSInteger points;

//display a new image/word on the screen
-(void)dealRandomImage;


@end
