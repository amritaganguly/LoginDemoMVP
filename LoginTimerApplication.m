//
//  FCTimerApplication.m
//  FitCheck
//
//  Created by MM-iMac on 18/05/15.
//  Copyright (c) 2015 MM-iMac. All rights reserved.
//

#import "LoginTimerApplication.h"


@implementation LoginTimerApplication

//here we are listening for any touch. If the screen receives touch, the timer is reset
-(void)sendEvent:(UIEvent *)event
{
    [super sendEvent:event];
    
    if (!myidleTimer)
    {
        [self resetIdleTimer];
    }
    
    NSSet *allTouches = [event allTouches];
    if ([allTouches count] > 0)
    {
        UITouchPhase phase = ((UITouch *)[allTouches anyObject]).phase;
        if (phase == UITouchPhaseBegan)
        {
            [self resetIdleTimer];
        }
        
    }
}
//as labeled...reset the timer
-(void)resetIdleTimer
{
    if (myidleTimer)
    {
        [myidleTimer invalidate];
    }
    //convert the wait period into minutes rather than seconds
    double timeout = kApplicationTimeoutInMinutes ;
    myidleTimer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(idleTimerExceeded) userInfo:nil repeats:NO];
    
}
//if the timer reaches the limit as defined in kApplicationTimeoutInMinutes, post this notification
-(void)idleTimerExceeded
{
    if (myidleTimer)
    {
        [myidleTimer invalidate];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kApplicationDidTimeoutNotification object:nil];
}

@end
