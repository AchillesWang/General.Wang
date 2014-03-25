//
//  MyView.m
//  Constraints3
//
//  Created by 潇翔 汪 on 14-3-4.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "MyView.h"


@interface MyView ()
/**
 *  名字
 */
@property (nonatomic,copy) NSString* name;

@end

@implementation MyView



-(NSString*)description
{
    return [[super description] stringByAppendingFormat:@" %@", self.name];
}

-(void)updateConstraints
{
    [super updateConstraints];
    NSLog(@"%@ %@", self, NSStringFromSelector(_cmd));
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"%@ %@", self, NSStringFromSelector(_cmd));
}
-(void)layoutSublayersOfLayerNOT:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    NSLog(@"%@ %@", self, NSStringFromSelector(_cmd));
}
@end
