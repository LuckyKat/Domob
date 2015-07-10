#import "LNDomob.h"


@implementation LNDomob

- (void)pluginInitialize
{
    NSLog(@"plugin initialize");
    videoManager = [[IndependentVideoManager alloc] initWithPublisherID:@"96ZJ2RsQzeNxTwTCsB"
                                                   andUserID:nil];
    videoManager.delegate = self;
    
}

- (void) showVideoWall:(CDVInvokedUrlCommand*)command
{
    NSLog(@"show video wall");
    playVideoCB = [command callbackId];
    
    _totalPoint = 0;
    _consumedPoint = 0;
    _currentPoint = 0;
    playingCompleted = NO;
    errorMessage = @"";
    
    [videoManager presentIndependentVideoWithViewController:self.viewController];
}

- (void) checkVideoAvailable:(CDVInvokedUrlCommand*)command
{
    NSLog(@"check video available");
    [self.commandDelegate runInBackground:^{
        checkVideoCB = [command callbackId];
        [videoManager checkVideoAvailable];
    }];
}

#pragma mark - Manager Delegate
- (void)ivManagerDidStartLoad:(IndependentVideoManager *)manager {
    NSLog(@"ivManagerDidStartLoad");
}


- (void)ivManagerDidFinishLoad:(IndependentVideoManager *)manager {
    NSLog(@"ivManagerDidFinishLoad");
}


- (void)ivManager:(IndependentVideoManager *)manager
failedLoadWithError:(NSError *)error {
    NSLog(@"failedLoadWithError");
}


- (void)ivManagerCompletePlayVideo:(IndependentVideoManager *)manager{
    NSLog(@"ivManagerCompletePlayVideo");
    playingCompleted = YES;
   
}


- (void)ivManagerWillPresent:(IndependentVideoManager *)manager {
    NSLog(@"ivManagerWillPresent");
}


- (void)ivManagerDidClosed:(IndependentVideoManager *)manager {
    NSLog(@"ivManagerDidClosed");
    [self.commandDelegate runInBackground:^{
        NSDictionary *dict = @{@"completed": [NSNumber numberWithBool:playingCompleted],
                               @"error" : errorMessage,
                               @"totalPoint": _totalPoint,
                               @"consumedPoint": _consumedPoint,
                               @"currentPoint": _currentPoint};
        
        CDVPluginResult* result = [CDVPluginResult
                                   resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
        
        [self.commandDelegate sendPluginResult:result callbackId:checkVideoCB];
    }];
}


- (void)ivCompleteIndependentVideo:(IndependentVideoManager *)manager
                    withTotalPoint:(NSNumber *)totalPoint
                     consumedPoint:(NSNumber *)consumedPoint
                      currentPoint:(NSNumber *)currentPoint {
    
    NSLog(@"CompleteVideoOfferWithTotalpoint:%@ consumedPoint:%@ currentPoint:%@",totalPoint,consumedPoint,currentPoint);
    _totalPoint = totalPoint;
    _consumedPoint = consumedPoint;
    _currentPoint = currentPoint;
}


- (void)ivManagerUncompleteIndependentVideo:(IndependentVideoManager *)manager
                                  withError:(NSError *)error {
    
    NSLog(@"UncompleteVideoOfferWithError:%@",error);
    errorMessage = [error description];
}  // Dispose of any resources that can be recreated.


- (void)ivManager:(IndependentVideoManager *)manager
isIndependentVideoAvailable:(BOOL)available {
    
    if (available) {
        NSLog(@"available");
    }
    else {        
        NSLog(@"unavailable");
    }
    
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* result = [CDVPluginResult
                                   resultWithStatus:CDVCommandStatus_OK messageAsBool:available];
        
        [self.commandDelegate sendPluginResult:result callbackId:checkVideoCB];
    }];

}


@end