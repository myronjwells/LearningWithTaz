//
//  TileView.m
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 12/3/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import "TileView.h"
#import "config.h"

@implementation TileView
{
    int _xOffset, _yOffset;
}

//1 override this by making it fil everytime by USING NSAssert
- (id)initWithFrame:(CGRect)frame
{
    NSAssert(NO, @"Use initWithLetter:andSideLength instead");
    return nil;
}

//2 create new tile for a given letter
-(instancetype)initWithLetter:(NSString*)letter andSideLength:(float)sideLength
{
    //the tile background (WILL SET THIS LATER)
     _img = [UIImage imageNamed:@"tile.png"];
    
    //create a new object
    self = [super initWithImage:_img];
    
    if (self != nil) {
        
        //3 resize the tile based on screen size
        float scale = sideLength/_img.size.width;
        self.frame = CGRectMake(0,0,_img.size.width*scale, _img.size.height*scale);
        
        //more initialization here
        
        //add a letter on top
        _lblChar = [[UILabel alloc] initWithFrame:self.bounds];
        _lblChar.textAlignment = NSTextAlignmentCenter;
        _lblChar.textColor = [UIColor whiteColor];
        _lblChar.backgroundColor = [UIColor clearColor];
        _lblChar.text = [letter uppercaseString];
        _lblChar.font = [UIFont fontWithName:@"Verdana-Bold" size:78.0*scale];
        [self addSubview: _lblChar];
        
        //begin in unmatched state
        self.isMatched = NO;
        
        //save the letter
        _letter = letter;
       
        // enable user interaction
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

-(void)randomize
{
    //1
    //set random rotation of the tile
    //anywhere between -0.2 and 0.3 radians
    float rotation = randomf(0,50) / (float)100 - 0.2;
    self.transform = CGAffineTransformMakeRotation( rotation );
    
    //2
    //move randomly upwards
    int yOffset = (arc4random() % 10) - 10;
    self.center = CGPointMake(self.center.x, self.center.y + yOffset);
}

#pragma mark - dragging the tile
//1 When touch is detected, get its location in superview. calculate and store distance from touch to the tile's center.
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    _xOffset = pt.x - self.center.x;
    _yOffset = pt.y - self.center.y;
}

//2 When finger moves, the tile move to that location but the location is adjusted to the stored values in xOffset and yOffset.
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    self.center = CGPointMake(pt.x - _xOffset, pt.y - _yOffset);
}

//3 When the finger lifts up, call touchedMoved again to make sure the tiles position is set to touchs final location.
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
    if (self.dragDelegate) {
        [self.dragDelegate tileView:self didDragToPoint:self.center];
    }
}
@end
