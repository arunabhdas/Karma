//
//  KarmaViewController.m
//  Karma
//
//

#import "KarmaViewController.h"
#import "FaceView.h"

@interface KarmaViewController() <FaceViewDataSource>

@property (nonatomic, weak) IBOutlet FaceView *faceView;

@end

@implementation KarmaViewController : UIViewController

@synthesize karmaness = _karmaness;
@synthesize faceView = _faceView;

-(void) setKarmaness : (int) karmaness
{
    _karmaness = karmaness;
    NSLog(@"SetKarmaness was called %d", _karmaness);
    // never call drawRect directly
    [self.faceView setNeedsDisplay];
}

- (void) setFaceView:(FaceView *)faceView
{
    _faceView = faceView;
    NSLog(@"setFaceView was called");
    NSLog(@"\n");
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)];
    
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleKarmaGesture:)];
    
    
    
    [self.faceView addGestureRecognizer:pinchRecognizer];
    
    [self.faceView addGestureRecognizer:panRecognizer];
    
    
    NSLog(@"added UIPinchGestureRecognizer");
    self.faceView.dataSource = self;
    
        
}

- (void) handleKarmaGesture : (UIPanGestureRecognizer *) gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded ))
    {
        CGPoint translation = [gesture translationInView:self.faceView];
        self.karmaness = self.karmaness - translation.y /2;
        [gesture setTranslation:CGPointZero inView:self.faceView];
    }

}

- (float) smileForFaceView:(FaceView *)sender
{
    return (self.karmaness - 50) / 50.0;
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
