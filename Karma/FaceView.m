//
//  FaceView.m
//  Karma
//
//

#import "FaceView.h"

@implementation FaceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
#define DEFAULT_SCALE 0.90

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
    size *= DEFAULT_SCALE;
    
    // set the line width
    CGContextSetLineWidth(context, 5.0);
    
    // create the color
    UIColor *mycolor= [UIColor colorWithRed:100.0/255.0 green:101.0/255.0 blue:102.0/255.0 alpha:1.0];
    
    // set the color
    [mycolor setStroke];
    
    [self drawCircleAtPoint:midPoint withRadius:size inContext:context];
    
// eye height, width, radius
#define EYE_H 0.35
#define EYE_V 0.35
#define EYE_RADIUS 0.10
    
    // draw eyes (2 circles)
    
    // no nose
    
    // draw mouth
}
 
 @end
