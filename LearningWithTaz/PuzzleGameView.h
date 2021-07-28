//
//  PuzzleGameView.h
//  Slizzle
//
//  Created by Myron  J. Wells on 1/10/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.//

//  A Model Class to make a puzzle board. A 3x3 board example :
//  1   2   3
//  4   5   6
//  7   8   0
//

#import <UIKit/UIKit.h>

#define SHUFFLE_TIMES   100     // amount of shuffling 
#define BOARD_SIZE      4       // size of the board 

@class PuzzleGame;

@protocol PuzzleGameDelegate;

@interface PuzzleGameView : UIView {
    CGFloat _tileWidth;
    CGFloat _tileHeight;
    
    id <PuzzleGameDelegate> _delegate;
    PuzzleGame *_board;
    NSMutableArray *_tiles;
    
    UIImageView *_draggedTile;
    int _direction;
}

@property CGFloat tileWidth;
@property CGFloat tileHeight;
@property (nonatomic, assign) IBOutlet id <PuzzleGameDelegate> delegate;
@property (nonatomic, retain) PuzzleGame *board;
@property (nonatomic, retain) NSMutableArray *tiles;

/*
 Initialize this view with image, size of the board, and frame size in the controller. This initializer can be used when you make this using code not from IB. (image, size, frame)
 
*/
- (id)initWithImage:(UIImage *)image andSize:(NSInteger)size withFrame:(CGRect)frame;

/*
 Method to start playing the puzzle. This should be used when you initiliazed the board with IB (image, size)
 
*/
- (void)playWithImage:(UIImage *)image andSize:(NSInteger)size;

/*
 Shuffle the board (SHUFFLE_TIMES) times, and then draw the puzzle board.
 
*/
- (void)play;

@end

@protocol PuzzleGameDelegate
/*
 This delegate method is fired when the puzzle board is finished
 
*/
- (void)puzzleBoardDidFinished:(PuzzleGameView *)board;

/*
 This delegate method is fired when a tile is moved
 
*/
- (void)puzzleBoard:(PuzzleGameView *)board emptyTileDidMovedTo:(CGPoint)tilePoint;
@end
