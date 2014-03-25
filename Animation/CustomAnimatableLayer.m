//
//  CustomAnimatableLayer.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-17.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "CustomAnimatableLayer.h"

@interface CustomAnimatableLayer ()

@property CGFloat thickness;

@end

@implementation CustomAnimatableLayer

@dynamic thickness;


+(BOOL)needsDisplayForKey:(NSString *)key
{
    
    if ([key isEqualToString:@"thickness"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

-(void)drawInContext:(CGContextRef)ctx
{
//    NSLog(@"%@",[self valueForKey:@"thickness"]);
    CGRect r = CGRectInset(self.bounds, 20, 20);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextFillRect(ctx, r);
    CGContextSetLineWidth(ctx, self.thickness);
    CGContextStrokeRect(ctx, r);
}

@end
