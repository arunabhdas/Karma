//
//  FaceView.h
//  Karma
//
//

#import <UIKit/UIKit.h>

@class FaceView;

@protocol FaceViewDataSource

- (float) smileForFaceView:(FaceView *) sender;


@end

@interface FaceView : UIView

@property (nonatomic) CGFloat scale;

- (void) pinch:(UIPinchGestureRecognizer *) gesture;

@property (nonatomic, weak) IBOutlet id <FaceViewDataSource> dataSource;

@end
