//
//  SecondTouchesView.m
//  Touches
//
//  Created by 潇翔 汪 on 14-2-20.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "SecondTouchesView.h"

@implementation SecondTouchesView
{
    BOOL _decided;
    BOOL _horiz;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self->_decided = NO;
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superview bringSubviewToFront:self];
    UITouch* t = touches.anyObject;
    CGPoint then = [t previousLocationInView:self.superview];
    CGPoint now = [t locationInView:self.superview];
    CGFloat deltaX = then.x - now.x;
    CGFloat deltaY = then.y - now.y;
    if (!self->_decided) {
        self->_decided = YES;
        
        self->_horiz = (fabs(deltaX)>=fabs(deltaY));
    }
    CGPoint c = self.center;
    if (self->_horiz) {
        c.x -=  deltaX;
    }else{
        c.y -= deltaY;
    }
    self.center = c;
}

@end
