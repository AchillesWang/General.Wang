//
//  PointerLayer.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-12.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "PointerLayer.h"

@interface PointerLayer ()


@end

@implementation PointerLayer
{
    BOOL _didSetup;
}

-(void)setup
{
    NSLog(@"setup");
    //the gradient
    CAGradientLayer* g = [CAGradientLayer new];
    g.contentsScale = [UIScreen mainScreen].scale;
    g.frame = self.bounds;
    g.colors = @[(id)[UIColor blackColor].CGColor,
                 (id)[UIColor redColor].CGColor];
    g.locations = @[@0.0f,
                    @1.0f];
    [self addSublayer:g];
    
    //圆盘
    CAShapeLayer* circle = [CAShapeLayer new];
    circle.contentsScale = [UIScreen mainScreen].scale;
    circle.lineWidth = 2.0;
    circle.fillColor = [UIColor whiteColor].CGColor;
    circle.strokeColor = [UIColor grayColor].CGColor;
    CGMutablePathRef p = CGPathCreateMutable();
    CGPathAddEllipseInRect(p, nil, CGRectInset(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*2), 3, 3));
    circle.path = p;
    [self addSublayer:circle];
    circle.bounds = self.bounds;
    circle.position = CGPointMake(CGRectGetMidX(self.bounds),
                                  CGRectGetMidY(self.bounds));
    [self mask:circle];
    //文字
    NSArray* pts = @[@"0",@"200",@"400"];
    for (int i=0; i<pts.count; i++) {
        CATextLayer* t = [CATextLayer new];
        t.contentsScale = [UIScreen mainScreen].scale;
        t.string = pts[i];
        t.fontSize = 20;
        CGSize size = [t.string sizeWithAttributes:@{NSFontAttributeName:(id)t.font}];
        t.bounds = CGRectMake(0, 0, size.width, size.height);
        t.foregroundColor = [self getColorWith:i].CGColor;
        t.position = CGPointMake(CGRectGetMidX(circle.bounds),
                                 self.bounds.size.height);
        CGFloat vert = CGRectGetMidY(circle.bounds) / CGRectGetHeight(t.bounds);
        t.anchorPoint = CGPointMake(0.5, vert*2);
        [circle addSublayer:t];
        
        
        [self textPosition:t num:i];
    }
    //arrow
    CALayer* arrow = [CALayer new];
    arrow.contentsScale = [UIScreen mainScreen].scale;
    arrow.bounds = CGRectMake(0, 0, 30, 80);
//    arrow.position = CGPointMake(CGRectGetMidX(circle.bounds),
//                                 CGRectGetMidY(circle.bounds)+10
//                                 );
    arrow.position = CGPointMake(CGRectGetMidX(circle.bounds), 100);
    arrow.delegate = self;
    [circle addSublayer:arrow];
    [arrow setNeedsDisplay];
    self.arrow = arrow;
    arrow.anchorPoint = CGPointMake(0.5 ,1);
}
- (void) drawLayer:(CALayer *)layer inContext:(CGContextRef)con {
    
    NSLog(@"drawLayer:inContext: for arrow");
    
    // punch triangular hole in context clipping region
    CGContextMoveToPoint(con, 5, layer.bounds.size.height);
    CGContextAddLineToPoint(con, 15, layer.bounds.size.height-10);
    CGContextAddLineToPoint(con, 25, layer.bounds.size.height);
    CGContextClosePath(con);
    CGContextAddRect(con, CGRectMake(0,0,layer.bounds.size.width,layer.bounds.size.height));
    CGContextEOClip(con);
    
    
    // draw a black (by default) vertical line, the shaft of the arrow
    CGContextMoveToPoint(con, 15, layer.bounds.size.height);
    CGContextAddLineToPoint(con, 15, 20);
    CGContextSetLineWidth(con, 10);
    CGContextStrokePath(con);
    
    // draw a patterned triangle, the point of the arrow
    CGColorSpaceRef sp = CGColorSpaceCreatePattern(nil);
    CGContextSetFillColorSpace (con, sp);
    CGColorSpaceRelease (sp);
    CGPatternCallbacks callback = {
        0, drawStripes, nil
    };
    CGAffineTransform tr = CGAffineTransformIdentity;
    CGPatternRef patt = CGPatternCreate(nil,
                                        CGRectMake(0,0,4,4),
                                        tr,
                                        4, 4,
                                        kCGPatternTilingConstantSpacingMinimalDistortion,
                                        true,
                                        &callback);
    CGFloat alph = 1.0;
    CGContextSetFillPattern(con, patt, &alph);
    CGPatternRelease(patt);
    CGContextMoveToPoint(con, 0, 20);
    CGContextAddLineToPoint(con, 15, 0);
    CGContextAddLineToPoint(con, 30, 20);
    CGContextFillPath(con);
    
}
void drawStripes (void *info, CGContextRef con) {
    // assume 4 x 4 cell
    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
    CGContextFillRect(con, CGRectMake(0,0,4,4));
    CGContextSetFillColorWithColor(con, [[UIColor blueColor] CGColor]);
    CGContextFillRect(con, CGRectMake(0,0,4,2));
}
-(void)textPosition:(CALayer*) layer num:(int)num
{
    switch (num) {
        case 0:
            layer.affineTransform = CGAffineTransformMakeRotation(-M_PI/180*70);
            break;
        case 1:
            
            break;
        case 2:
            layer.affineTransform = CGAffineTransformMakeRotation(M_PI/180*70);
            break;
            
        default:
            break;
    }
}
- (void) mask: (CALayer*) layer {
    CAShapeLayer* mask = [CAShapeLayer new];
    CGMutablePathRef p2 = CGPathCreateMutable();
    CGPathAddRect(p2, nil, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
    mask.path = p2;
    layer.mask = mask;
    CGPathRelease(p2);
}
-(void)layoutSublayers
{
    if (!_didSetup) {
        _didSetup = YES;
        [self setup];
    }
}

-(UIColor*)getColorWith:(int)num
{
    switch (num) {
        case 0:
            return [UIColor greenColor];
        case 1:
            return [UIColor orangeColor];
        case 2:
            return [UIColor redColor];
        default:
            return [UIColor blackColor];
    }
};
@end
