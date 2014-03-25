//
//  CustomAnimatableView.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-17.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "CustomAnimatableView.h"
#import "CustomAnimatableLayer.h"


@implementation CustomAnimatableView


+(Class)layerClass
{
    return [CustomAnimatableLayer class];
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code
}


@end
