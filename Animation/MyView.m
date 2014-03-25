//
//  MyView.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-12.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "MyView.h"

@implementation MyView


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect f         = CGRectInset(self.bounds, 10, 10);
    CGContextRef con = UIGraphicsGetCurrentContext();
    if (self.reverse) {
        CGContextStrokeEllipseInRect(con, f);
    }else{
        CGContextStrokeRect(con, f);
    }
}


@end
