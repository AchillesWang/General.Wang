//
//  FouthTouchesView.m
//  Touches
//
//  Created by 潇翔 汪 on 14-2-24.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.//

#import "FouthTouchesView.h"

@implementation FouthTouchesView
{
    BOOL _decidedDirection;
    BOOL _horiz;
    BOOL _decidedTap;
    BOOL _drag;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    //未决定
    self->_decidedTap = NO;
    NSUInteger ct  = [(UITouch*)touches.anyObject tapCount];
    if (ct == 2) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self
                                                 selector:@selector(singleTap)
                                                   object:nil];
        self->_decidedTap = YES;
        self->_drag = NO;
        return;
    }
    self->_decidedDirection = NO;
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self->_decidedTap && !self->_drag) {
        //如果是点击
        return;
    }
    [self.superview bringSubviewToFront:self];
    UITouch* t = touches.anyObject;
    self->_decidedTap = YES;
    self->_drag = YES;
    CGPoint then = [t previousLocationInView:self.superview];
    CGPoint now = [t locationInView:self.superview];
    CGFloat deltaX = then.x-now.x;
    CGFloat deltaY = then.y - now.y;
    //决定方向
    if (!self->_decidedDirection) {
        self->_horiz = (fabs(deltaX)>=fabs(deltaY));
    }
    CGPoint c = self.center;
    if (self->_horiz) {
        c.x -= deltaX;
    }else{
        c.y -= deltaY;
    }
    self.center = c;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self->_decidedTap||!self->_drag) {
        NSUInteger ct = [(UITouch*)touches.anyObject tapCount];
        if (ct == 1) {
            [self performSelector:@selector(singleTap) withObject:nil
                       afterDelay:0.3];
        }
        if (ct == 2) {
            NSLog(@"double tap");
        }
    }
}
-(void)singleTap
{
    NSLog(@"single tap");
}
@end
