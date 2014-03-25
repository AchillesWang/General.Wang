//
//  ThirdTouchesView.m
//  Touches
//
//  Created by 潇翔 汪 on 14-2-20.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "ThirdTouchesView.h"

@implementation ThirdTouchesView
{
    NSTimeInterval _time;
}
#if 0
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSUInteger ct = [(UITouch*)touches.anyObject tapCount];
    if (ct == 2) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self
                                                 selector:@selector(singleTap)
                                                   object:self];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSUInteger ct = [(UITouch*)touches.anyObject tapCount];
    if (ct == 1)
        [self performSelector:@selector(singleTap) withObject:nil afterDelay:0.3];
    if (ct == 2)
        NSLog(@"double tap");
}
#else
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self->_time = [(UITouch*)touches.anyObject timestamp];
    [self performSelector:@selector(touchWasLong)
               withObject:nil afterDelay:0.4];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSTimeInterval diff = event.timestamp - self->_time;
    if (diff < 0.4) {
        NSLog(@"short");
        [NSObject cancelPreviousPerformRequestsWithTarget:self
                                                 selector:@selector(touchWasLong)
                                                   object:nil];
    }
}
- (void) touchWasLong {
    NSLog(@"long");
}
#endif
-(void)singleTap
{
    NSLog(@"singleTap");
}
@end
