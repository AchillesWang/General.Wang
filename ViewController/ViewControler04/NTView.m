//
//  NTView.m
//  ViewControler04
//
//  Created by 潇翔 汪 on 14-3-14.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTView.h"
#define TEST 1
@implementation NTView

#if TEST

-(void)layoutSubviews
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [super layoutSubviews];
}

-(void)updateConstraints {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [super updateConstraints];
}

#endif
@end
