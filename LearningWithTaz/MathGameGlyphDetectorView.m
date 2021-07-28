//
//  MathGameGlyphDetectorView.m
//  LearningWithTaz
//
//  Created by Myron  J. Wells on 11/16/13.
//  Copyright (c) 2013 com.myronwells. All rights reserved.
//

#import "MathGameGlyphDetectorView.h"




@interface MathGameGlyphDetectorView() <WTMGlyphDelegate>

@property (nonatomic, strong) WTMGlyphDetector *glyphDetector;
@property (nonatomic, strong) NSMutableArray *glyphNamesArray;
@property (nonatomic) MathGameViewController *ctrl;

@end


@implementation MathGameGlyphDetectorView
@synthesize delegate;
@synthesize myPath;
@synthesize enableDrawing;
@synthesize glyphDetector;
@synthesize glyphNamesArray;
@synthesize touch;
@synthesize ctrl;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initGestureDetector];
        
        self.backgroundColor = [UIColor clearColor];
        self.enableDrawing = YES;
        
        self.myPath = [[UIBezierPath alloc]init];
        self.myPath.lineCapStyle = kCGLineCapRound;
        self.myPath.miterLimit = 0;
        self.myPath.lineWidth = 10;
    }
    return self;
}




- (void)initGestureDetector
{
    self.glyphDetector = [WTMGlyphDetector detector];
    self.glyphDetector.delegate = self;
    self.glyphDetector.timeoutSeconds = 1;
    
    if (self.glyphNamesArray == nil)
        self.glyphNamesArray = [[NSMutableArray alloc] init];
}




#pragma mark - Public interfaces

- (NSString *)getGlyphNamesString
{
    if (self.glyphNamesArray == nil || [self.glyphNamesArray count] <= 0)
        return @"";
    
    return [self.glyphNamesArray componentsJoinedByString: @", "];
}

- (void)loadTemplatesWithNames:(NSString*)firstTemplate, ...
{
    va_list args;
    va_start(args, firstTemplate);
    for (NSString *glyphName = firstTemplate; glyphName != nil; glyphName = va_arg(args, id))
    {
        if (![glyphName isKindOfClass:[NSString class]])
            continue;
        
        [self.glyphNamesArray addObject:glyphName];
        
        NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:glyphName ofType:@"json"]];
        [self.glyphDetector addGlyphFromJSON:jsonData name:glyphName];
    }
    va_end(args);
}


- (void)glyphDetected:(WTMGlyph *)glyph withScore:(float)score
{
    //Simply forward it to my parent
    if ([self.delegate respondsToSelector:@selector(mathGameGlyphDetectorView:glyphDetected:withScore:)])
        [self.delegate mathGameGlyphDetectorView:self glyphDetected:glyph withScore:score];
    
    [self performSelector:@selector(clearDrawingIfTimeout) withObject:nil afterDelay:1.0f];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
        
    
    BOOL hasTimeOut = [self.glyphDetector hasTimedOut];
    if (hasTimeOut) {
        NSLog(@"Gesture detector reset");
        [self.glyphDetector reset];
        
        if (self.enableDrawing) {
            [self.myPath removeAllPoints];
            //This is not recommended for production, but it's ok here since we don't have a lot to draw
            [self setNeedsDisplay];
        }
    }

    self.touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self.glyphDetector addPoint:point];
    
    [super touchesBegan:touches withEvent:event];
    
    if (!self.enableDrawing)
        return;
    
    [self.myPath moveToPoint:point];
   
    


}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
        
    self.touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self.glyphDetector addPoint:point];
    
    [super touchesMoved:touches withEvent:event];
    
    if (!self.enableDrawing)
        return;
    
    [self.myPath addLineToPoint:point];
    
    //This is not recommended for production, but it's ok here since we don't have a lot to draw
    [self setNeedsDisplay];
    
    

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self.glyphDetector addPoint:point];
    [self.glyphDetector detectGlyph];
    
    [super touchesEnded:touches withEvent:event];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.



- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (!self.enableDrawing)
        return;
    
    [[UIColor blueColor] setStroke];
    [self.myPath strokeWithBlendMode:kCGBlendModeNormal alpha:0.5];
    

}

- (void)clearDrawingIfTimeout
{
    if (!self.enableDrawing)
        return;
    
    BOOL hasTimeOut = [self.glyphDetector hasTimedOut];
    if (!hasTimeOut)
        return;
    
    [self.myPath removeAllPoints];
    
    //This is not recommended for production, but it's ok here since we don't have a lot to draw
    [self setNeedsDisplay];
}


@end
