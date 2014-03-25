//
//  HitView_Layer.m
//  Touches
//
//  Created by 潇翔 汪 on 14-2-26.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "HitView_Layer.h"

@implementation HitView_Layer

-(void)awakeFromNib {
    CALayer* lay = [CALayer layer];
    lay.frame = self.layer.bounds;
    [self.layer addSublayer:lay];
    UITapGestureRecognizer* t = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:t];
}
- (void) tap {
    NSLog(@"tap");
}

- (void)drawRect:(CGRect)rect
{
    CALayer* lay = [self.layer.sublayers lastObject];
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGRect r = CGRectInset(self.bounds, 30, 30);
    CGContextSaveGState(con);
    CGContextTranslateCTM(con, self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    CGContextRotateCTM(con, (M_PI/10.0));
    CGContextTranslateCTM(con, -self.bounds.size.width/2.0, -self.bounds.size.height/2.0);
    CGContextFillEllipseInRect(con, r);
    CGContextRestoreGState(con);
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    lay.contents = (id)im.CGImage;
}

-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [self pointInside:point withEvent:event];
    if (!inside) {
        return nil;
    }
    //以下不太明白需要理解
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    CALayer* lay = [self.layer.sublayers lastObject];
    [lay renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    unsigned char pixel[1] = {0};
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 1, nil, (CGBitmapInfo)kCGImageAlphaOnly);
    UIGraphicsPushContext(context);
    [im drawAtPoint:CGPointMake(-point.x, -point.y)];
    UIGraphicsPopContext();
    CGContextRelease(context);
    CGFloat alpha = pixel[0]/255.0;
    BOOL transparent = alpha<0.01;
    return (transparent ? nil : self);
}
@end
