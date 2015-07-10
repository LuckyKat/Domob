#import <Cordova/CDV.h>
#import "IndependentVideoManager.h"

@interface LNDomob : CDVPlugin<IndependentVideoManagerDelegate> {
	IndependentVideoManager *videoManager;
    NSString *checkVideoCB;
    NSString *playVideoCB;
    BOOL playingCompleted;
    NSString* errorMessage;
    NSNumber *_totalPoint;
    NSNumber *_consumedPoint;
    NSNumber *_currentPoint;
}

- (void) showVideoWall:(CDVInvokedUrlCommand*)command;

- (void) checkVideoAvailable:(CDVInvokedUrlCommand*)command;

@end