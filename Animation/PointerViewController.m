//
//  PointerViewController.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-12.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "PointerViewController.h"
#import "PointerView.h"
#import "PointerLayer.h"
@interface PointerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textf;

@property (weak, nonatomic) IBOutlet PointerView *pointView;

@end

@implementation PointerViewController

- (IBAction)dismiss:(id)sender {
    [self dismissController];
}
- (IBAction)doArrow:(id)sender {
    
    PointerLayer* p = (PointerLayer*)self.pointView.layer;
    CALayer* arrow = p.arrow;
    switch ([_textf.text integerValue]) {
        case 1:
        {
            arrow.transform = CATransform3DRotate(arrow.transform, M_PI/10, 0, 0, 1);
            break;
        }
        case 2:
        {
            [CATransaction setAnimationDuration:0.8];
            arrow.transform = CATransform3DRotate(arrow.transform, M_PI/10, 0, 0, 1);
            break;
        }
        case 3:
        {
            //动画贝塞尔(动画运动曲线)
            CAMediaTimingFunction* clunk = [CAMediaTimingFunction functionWithControlPoints:0.9 :0.1 :0.7 :0.9];
            [CATransaction setAnimationTimingFunction:clunk];
            arrow.transform = CATransform3DRotate(arrow.transform, M_PI/10, 0, 0, 1);
            break;
        }
        case 4:
        {
            [CATransaction setCompletionBlock:^{
                NSLog(@"%@",@"done");
            }];
            CATransform3D startValue = arrow.transform;
            CATransform3D endValue = CATransform3DRotate(startValue, M_PI/4.0, 0, 0, 1);
            [CATransaction setDisableActions:YES];
            arrow.transform = endValue;
            
            CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform"];
            anim.duration = 0.8f;
            CAMediaTimingFunction* clunk =[CAMediaTimingFunction functionWithControlPoints:0.5 :0.9 :0.1 :0.8];
            anim.timingFunction = clunk;
            anim.fromValue = [NSValue valueWithCATransform3D:startValue];
            anim.toValue = [NSValue valueWithCATransform3D:endValue];
            [arrow addAnimation:anim forKey:nil];
            break;
        }
        case 5:
        {
            [CATransaction setDisableActions:YES];
            arrow.transform = CATransform3DRotate(arrow.transform, M_PI/4.0, 0, 0, 1);
            
            CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform"];
            anim.duration = 0.8;
            CAMediaTimingFunction* clunk =
            [CAMediaTimingFunction functionWithControlPoints:.9 :.1 :.7 :.9];
            anim.timingFunction = clunk;
            [arrow addAnimation:anim forKey:nil];
            break;
        }
        case 6:
        {
            //抖动效果1
            CATransform3D nowValue = arrow.transform;
            CATransform3D startValue = CATransform3DRotate(nowValue, M_PI/40.0, 0, 0, 1);
            CATransform3D endValue = CATransform3DRotate(nowValue, -M_PI/40.0, 0, 0, 1);
            
            CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform"];
            anim.duration = 0.5;
            anim.timingFunction =
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            anim.repeatCount = 100;
            anim.autoreverses = YES;
            anim.fromValue = [NSValue valueWithCATransform3D:startValue];
            anim.toValue = [NSValue valueWithCATransform3D:endValue];
            // ask for the explicit animation
            [arrow addAnimation:anim forKey:nil];
            break;
        }
        case 7:
        {
            //抖动效果2
            CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform"];
            anim.duration = 0.05;
            anim.timingFunction =
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            anim.repeatCount = 3;
            anim.autoreverses = YES;
            anim.additive = YES;
            anim.valueFunction =
            [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
            anim.fromValue = @(M_PI/40);
            anim.toValue = @(-M_PI/40);
            [arrow addAnimation:anim forKey:nil];
            break;
        }
        case 8:
        {
            NSMutableArray* values = [NSMutableArray array];
            [values addObject: @0.0f];
            int direction = 1;
            for (int i = 20; i < 60; i += 5, direction *= -1) { // alternate directions
                [values addObject: @(direction*M_PI/(float)i)];
            }
            [values addObject: @0.0f];
            CAKeyframeAnimation* anim =
            [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            anim.values = values;
            anim.additive = YES;
            anim.valueFunction =
            [CAValueFunction functionWithName: kCAValueFunctionRotateZ];
            [arrow addAnimation:anim forKey:nil];
            break;
        }
        case 9:
        {
            //动画组
            // capture current value, set final value
            CGFloat rot = M_PI/4.0;
            [CATransaction setDisableActions:YES];
            CGFloat current =
            [[arrow valueForKeyPath:@"transform.rotation.z"] floatValue];
            [arrow setValue: @(current + rot)
                 forKeyPath:@"transform.rotation.z"];

            // first animation (rotate and clunk)
            CABasicAnimation* anim1 = [CABasicAnimation animationWithKeyPath:@"transform"];
            anim1.duration = 0.8;
            CAMediaTimingFunction* clunk =
            [CAMediaTimingFunction functionWithControlPoints:.9 :.1 :.7 :.9];
            anim1.timingFunction = clunk;
            anim1.fromValue = @(current);
            anim1.toValue = @(current + rot);
            anim1.valueFunction =
            [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
            
            // second animation (waggle)
            NSMutableArray* values = [NSMutableArray array];
            [values addObject: @0.0f];
            int direction = 1;
            for (int i = 20; i < 60; i += 5, direction *= -1) { // alternate directions
                [values addObject: @(direction*M_PI/(float)i)];
            }
            [values addObject: @0.0f];
            CAKeyframeAnimation* anim2 =
            [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            anim2.values = values;
            anim2.duration = 0.25;
            anim2.beginTime = anim1.duration;
            anim2.additive = YES;
            anim2.valueFunction =
            [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
            
            // group
            CAAnimationGroup* group = [CAAnimationGroup animation];
            group.animations = @[anim1, anim2];
            group.duration = anim1.duration + anim2.duration;
            [arrow addAnimation:group forKey:nil];
            break;
        }
        case 0:
        {
            [CATransaction setAnimationDuration:0];
            arrow.transform = CATransform3DIdentity;
            break;
        }
        default:
            break;
    }
}

@end
