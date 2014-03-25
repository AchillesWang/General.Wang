//
//  PointerView.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-12.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "PointerView.h"
#import "PointerLayer.h"
@implementation PointerView

+(Class)layerClass
{
    return [PointerLayer class];
};

@end
