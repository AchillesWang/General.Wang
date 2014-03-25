//
//  HistView.m
//  Touches
//
//  Created by 潇翔 汪 on 14-2-25.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "HistView.h"

@implementation HistView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
//    NSLog(@"%@",event);
#if 1
    NSLog(@"hitTest");
    UIView* result = [super hitTest:point withEvent:event];
    if (result)
        return result;
    for (UIView* sub in [self.subviews reverseObjectEnumerator]) {
        CGPoint pt = [self convertPoint:point toView:sub];
        result = [sub hitTest:pt withEvent:event];
        if (result)
            return result;
    }
    return nil;
#else
    return [super hitTest:point withEvent:event];
#endif
}

@end
