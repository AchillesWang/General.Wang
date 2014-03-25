//
//  BaseView.m
//  Touches
//
//  Created by 潇翔 汪 on 14-2-20.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //把方块变小
    //    self.layer.transform = CATransform3DMakeScale(0.6, 0.6, 1);
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.fromValue = [NSValue valueWithCATransform3D:self.layer.transform];
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1)];
    anim.duration = 0.15;
    self.layer.transform = CATransform3DMakeScale(0.6, 0.6, 1);
    [self.layer addAnimation:anim forKey:nil];
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //还原
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.fromValue = [NSValue valueWithCATransform3D:self.layer.transform];
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    anim.duration = 0.15;
    self.layer.transform = CATransform3DIdentity;
    [self.layer addAnimation:anim forKey:nil];
    
}
@end
