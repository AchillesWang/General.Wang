//
//  FirstTouchesView.m
//  Touches
//
//  Created by 潇翔 汪 on 14-2-20.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "FirstTouchesView.h"

@implementation FirstTouchesView




//重写touchesMoved方法
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //把知己调节到最前
    [self.superview bringSubviewToFront:self];
    UITouch* t = touches.anyObject;
    CGPoint loc = [t locationInView:self.superview];
    CGPoint oldp = [t previousLocationInView:self.superview];
    CGFloat deltaX = loc.x  - oldp.x;
    CGFloat deltaY = loc.y - oldp.y;
    CGPoint c  = self.center;
    c.x += deltaX;
    c.y += deltaY;
    self.center =c;
}


@end
