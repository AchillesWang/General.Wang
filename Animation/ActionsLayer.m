//
//  ActionsLayer.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-17.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "ActionsLayer.h"

@implementation ActionsLayer
+(id<CAAction>)defaultActionForKey:(NSString *)event
{
//    NSLog(@"%s",__func__);
    if ([event isEqualToString:@"contents"]) {
        CATransition* tr = [CATransition animation];
        tr.type = kCATransitionPush;
        tr.subtype = kCATransitionFromLeft;
        return tr;
    }
    return [super defaultActionForKey: event];
}

-(id<CAAction>)actionForKey:(NSString *)event {
//    NSLog(@"%s",__func__);
    if ([event isEqualToString:@"position"] &&
        [self valueForKey:@"suppressPositionAnimation"]){   //移动不需要动画
        //复原动画
        [self setValue:nil forKey:@"suppressPositionAnimation"];
        return nil;
    }
        
    return [super actionForKey:event];
}

@end
