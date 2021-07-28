//
//  WordGame.m
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 12/3/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import "WordGame.h"
#import "TileView.h"
#import "TargetView.h"
#import "config.h"
#import "WordGameViewController.h"






@implementation WordGame
{
    
   
    //tile lists
    NSMutableArray* _tiles;
    NSMutableArray* _targets;
    
    
}
@synthesize image;

-(instancetype)init
{
    self = [super init];
    if (self != nil) {
        //initialize
       self.points = MAX(_points, 0);
    }
    return self;
}

//fetches a random image, deals the letter tiles and creates the targets


-(void)setRecursiveUserInteraction:(BOOL)value
{
    self.gameView.userInteractionEnabled = value; for (UIView* view in [self.gameView subviews]) {
        [self setRecursiveUserInteraction:YES];
    }
    
}



-(void)dealRandomImage
{
   
    
    //1
    NSAssert(self.level.gameImages, @"no level loaded");
    
    //2 random image
    int randomIndex = arc4random()%[self.level.gameImages count];
    
    image = self.level.gameImages[ randomIndex ];
    NSString* shuffledWord = [self shuffleWord:image];
    
    //3
    int imagelen = [image length];
    
    
    //4
    NSLog(@"image[%i]: %@", imagelen, image);
    
    //calculate the tile size
    float tileSide = ceilf(kScreenWidth*0.6 /(float)imagelen) - kTileMargin;
    
    //get the left margin for first tile
    float xOffset = (kScreenHeight - imagelen * (tileSide + kTileMargin))/4;
    
    //adjust for tile center (instead of the tile's origin)
    xOffset += tileSide/2;
    
    // initialize target list
    _targets = [NSMutableArray arrayWithCapacity: imagelen];
    
    // create targets
    for (int i=0;i<imagelen;i++) {
        NSString* letter = [image substringWithRange:NSMakeRange(i, 1)];
        
        if (![letter isEqualToString:@" "]) {
            TargetView* target = [[TargetView alloc] initWithLetter:letter andSideLength:tileSide];
            target.center = CGPointMake(xOffset + i*(tileSide + kTileMargin), kScreenHeight/1.5);
            
            [self.gameView addSubview:target];
            [_targets addObject: target];
        }
    }
    //1 initialize tile list
    _tiles = [NSMutableArray arrayWithCapacity: imagelen];
    
    //2 create tiles
    for (int i=0;i<imagelen;i++)
    {
        NSString* letter = [shuffledWord substringWithRange:NSMakeRange(i, 1)];
        
        //3
        if (![letter isEqualToString:@" "])
        {
            TileView* tile = [[TileView alloc] initWithLetter:letter andSideLength:tileSide];
            //Change the divided numbers to adjust where the tiles are on the screen(will probably need to do this when testing on actual device
            tile.center = CGPointMake(xOffset + i*(tileSide + kTileMargin), kScreenHeight/3.6*3);
            [tile randomize];
            
            tile.dragDelegate = self;
            //4
            [self.gameView addSubview:tile];
            [_tiles addObject: tile];
        }
    }
   
}



//a tile was dragged, check if matches a target
-(void)tileView:(TileView*)tileView didDragToPoint:(CGPoint)pt
{
    TargetView* targetView = nil;
    
    for (TargetView* tv in _targets) {
        if (CGRectContainsPoint(tv.frame, pt)) {
            targetView = tv;
            break;
        }
    }
    //1 check if target was found
    if (targetView!=nil) {
        
        
        //2 check if letter matches
        if ([targetView.letter isEqualToString: tileView.letter]) {
            
            //3
            [self placeTile:tileView atTarget:targetView];
            
            //more stuff to do on success here
            
            
            //give points
            self.points += self.level.pointsPerTile;
            
            //NOTE:IMPORTANT! had to communicate with the score label here by calling a delegate notification to talk between nsobject and view controller.
            [[NSNotificationCenter defaultCenter]postNotificationName:@"DoSetScoreLabel" object:nil userInfo:nil];
            //check for finished game
            [self checkForSuccess];
            
            
            
            
        } else {
            //4
            
            //1
            //visualize the mistake
            [tileView randomize];
            
            //2
            [UIView animateWithDuration:0.35
                                  delay:0.00
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 tileView.center = CGPointMake(tileView.center.x + randomf(-20, 20),
                                                               tileView.center.y + randomf(20, 30));
                             } completion:nil];
            
            //more stuff to do on failure here
            //take out points
            self.points -= self.level.pointsPerTile/2;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"DoSetScoreLabel" object:nil userInfo:nil];
        }
    }

}

-(void)placeTile:(TileView*)tileView atTarget:(TargetView*)targetView
{
    //1
    targetView.isMatched = YES;
    tileView.isMatched = YES;
    
    //2
    tileView.userInteractionEnabled = NO;
    
    //3
    [UIView animateWithDuration:0.35
                          delay:0.00
                        options:UIViewAnimationOptionCurveEaseOut
     //4
                     animations:^{
                         tileView.center = targetView.center;
                         tileView.transform = CGAffineTransformIdentity;
                     }
     //5
                     completion:^(BOOL finished){
                         targetView.hidden = YES;
                     }];
}

-(void)checkForSuccess
{
    for (TargetView* t in _targets) {
        //no success, bail out
        if (t.isMatched==NO) return;
    }
    
    NSLog(@"Game Over!");
    [self clearBoard];
    [self dealRandomImage];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DoSetImages" object:nil userInfo:nil];
   
}

//Fisher Yates Shuffle method
- (NSString *)shuffleWord:(NSString *)set
{
// Create a copy of the original set
    NSMutableString *newSet;
    newSet = [NSMutableString stringWithString:set];
    // Loop backwards through members of the set
    for (int i = ([set length] - 1); i > 0; i--) {
        /* Choose a random number (0 <= rand <= i)
         Because i constantly decreases, the number
         of elements we can swap with becomes smaller
         as we loop */
        int rand = (arc4random() % (i + 1));
        //Select the elements at rand and i
        NSString *lastChar = [NSString stringWithFormat:@"%c",[newSet characterAtIndex:i]];
        NSString *randChar = [NSString stringWithFormat:@"%c",[newSet characterAtIndex:rand]];
        // Swap the elements
        [newSet replaceCharactersInRange:NSMakeRange(rand, 1) withString:lastChar];
        [newSet replaceCharactersInRange:NSMakeRange(i, 1) withString:randChar];
        
    }
     NSLog(@"shuffle word is %@",newSet);
    return newSet;
}

//clear the tiles and targets
-(void)clearBoard
{
    [_tiles removeAllObjects];
    [_targets removeAllObjects];
    
    for (UIView *view in self.gameView.subviews) {
        [view removeFromSuperview];
    }
}
@end
