//
//  TileView.h
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 12/3/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TileView;

@protocol TileDragDelegateProtocol <NSObject>
-(void)tileView:(TileView*)tileView didDragToPoint:(CGPoint)pt;
@end

@interface TileView : UIImageView

@property (weak, nonatomic) id<TileDragDelegateProtocol> dragDelegate;
@property (strong, nonatomic, readonly) NSString* letter;
//holds bool indicating whether tile has been correctly matched to target of screen.
@property (assign, nonatomic) BOOL isMatched;

@property (strong,nonatomic) UIImage *img;
@property (strong, nonatomic) UILabel *lblChar;


//setup an instance of TileView class with a given letter and tile size.
-(instancetype)initWithLetter:(NSString*)letter andSideLength:(float)sideLength;
-(void)randomize;


@end
