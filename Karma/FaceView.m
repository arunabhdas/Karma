//
//  FaceView.m
//  Karma
//
//

#import "FaceView.h"

@implementation FaceView

@synthesize scale = _scale;

#define DEFAULT_SCALE 0.90

- (CGFloat) scale
{
    if (!_scale)
    {
        NSLog(@"Default value is getting set  %f", _scale);
        return DEFAULT_SCALE;
    }
    else
    {
        NSLog(@"getter was called %f ", _scale);
        return _scale;
        
    }
}

- (void) setScale:(CGFloat)scale
{
    _scale = scale;
    NSLog(@"setter was called %f ", _scale);
    [self setNeedsDisplay];
    
}

- (void) pinch:(UIPinchGestureRecognizer *) gesture
{
    NSLog(@"pinch was called");
    NSLog(@"\n");
    if ((gesture.state == UIGestureRecognizerStateChanged) || 
        (gesture.state == UIGestureRecognizerStateEnded))
    {
        NSLog(@"pinch was called");
        NSLog(@"\n");
        NSLog(@"Value of gesture.scale : %f", gesture.scale);
        
        
        [self setScale:self.scale * gesture.scale];
        gesture.scale = 1; 
    }
    
}
- (void) setup
{
    self.contentMode = UIViewContentModeRedraw;;
}

- (void) awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
        
    }
    return self;
}

- (void) drawCircleAtPoint:(CGPoint) p withRadius:(CGFloat) radius inContext:(CGContextRef) context
{
    // push the context
    UIGraphicsPushContext(context);
    
    CGContextBeginPath(context);
    
    // draw the circle
    CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES);
    
    // stroke the path
    CGContextStrokePath(context);
    
    // pop the context
    UIGraphicsPopContext();
}
// make the size not be right out to the edges


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    // draw face (circle) 
    
    // we need the context for drawing
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint midPoint;
    
    midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
    
    midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    CGFloat size = self.bounds.size.width / 2;
    
    // set the size
    if (self.bounds.size.height < self.bounds.size.width) size = self.bounds.size.height/2;
    
    // scale the size so that it doesn't go all the way to the edge
    NSString *scalevalue = [NSString stringWithFormat:@"%f scalevalue ", self.scale];
    
    NSLog(@"%@", scalevalue);
    size *= self.scale;
    
    // set the line width
    CGContextSetLineWidth(context, 5.0);
    
    // create the color
    UIColor *mycolor= [UIColor colorWithRed:100.0/255.0 green:201.0/255.0 blue:102.0/255.0 alpha:1.0];
    
    // set the color
    [mycolor setStroke];
    
    [self drawCircleAtPoint:midPoint withRadius:size inContext:context];
    
    // draw eyes (2 circles)
    
    // eye height, width, radius
#define EYE_H 0.35
#define EYE_V 0.35
#define EYE_RADIUS 0.10
    
    CGPoint eyePoint;
    
    eyePoint.x = midPoint.x - size * EYE_H;
    eyePoint.y = midPoint.y - size * EYE_V;
    
    [self drawCircleAtPoint:eyePoint withRadius:size * EYE_RADIUS inContext:context];
    
    eyePoint.x += size * EYE_H * 2;
    [self drawCircleAtPoint:eyePoint withRadius:size * EYE_RADIUS inContext:context];
    // no nose
    
    // draw mouth
    
#define MOUTH_H 0.45
#define MOUTH_V 0.40
#define MOUTH_SMILE 0.25
    
    CGPoint mouthStart;
    mouthStart.x = midPoint.x - MOUTH_H * size;
    mouthStart.y = midPoint.y + MOUTH_V * size;
    CGPoint mouthEnd = mouthStart;
    mouthEnd.x += MOUTH_H * size * 2;
    CGPoint mouthCP1 = mouthStart;
    mouthCP1.x += MOUTH_H * size * 2/3;
    CGPoint mouthCP2 = mouthEnd;
    mouthCP2.x -= MOUTH_H * size * 2/3;
    
    float smile = 1.0;
    
    CGFloat smileOffset = MOUTH_SMILE * size * smile;
    mouthCP1.y += smileOffset;
    mouthCP2.y += smileOffset;
    
    // get context
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, mouthStart.x,  mouthStart.y);
    CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP2.y, mouthCP2.x, mouthCP2.y, mouthEnd.x, mouthEnd.y);
    CGContextStrokePath(context);
    
    
}

@end
