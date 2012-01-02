//
//  KarmaViewController.m
//  Karma
//
//

#import "KarmaViewController.h"
#import "FaceView.h"

@interface KarmaViewController()

@property (nonatomic, weak) IBOutlet FaceView *faceView;

@end

@implementation KarmaViewController : UIViewController

@synthesize karmaness = _karmaness;
@synthesize faceView = _faceView;

-(void) setKarmaness : (int) karmaness
{
    _karmaness = karmaness;
    // never call drawRect directly
    [self.faceView setNeedsDisplay];
}

- (void) setFaceView:(FaceView *)faceView
{
    _faceView = faceView;
    NSLog(@"setFaceView was called");
    NSLog(@"\n");
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)];
    
    [self.faceView addGestureRecognizer:pinchRecognizer];
    NSLog(@"added UIPinchGestureRecognizer");
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
