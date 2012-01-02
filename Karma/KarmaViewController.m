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

@synthesize karma = _karma;
@synthesize faceView = _faceView;

-(void) setKarma : (int) karma
{
    _karma = karma;
    // never call drawRect directly
    [self.faceView setNeedsDisplay];
}



@end
