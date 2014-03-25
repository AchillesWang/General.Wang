//
//  GrounpedAnimationViewController.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-17.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "GroupedAnimationViewController.h"
@interface GroupedAnimationViewController ()
/**
 *  这是一条船
 */
@property (strong,nonatomic) UIView* boatView;

@end

@implementation GroupedAnimationViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.boatView = [[UIView alloc] initWithFrame:CGRectMake(254, 28, 56, 38)];
    [self.view addSubview:self.boatView];
    self.boatView.layer.contents        = (id)[UIImage imageNamed:@"boat.gif"].CGImage;
    self.boatView.layer.contentsGravity = kCAGravityResizeAspectFill;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)dimiss:(id)sender {
    [self dismissController];
}
- (IBAction)doAnimation:(id)sender {
    [self animate];
}
-(void)animate
{
    //获得动画曲线
    CGFloat h             = 200;
    CGFloat v             = 75;
    CGMutablePathRef path = CGPathCreateMutable();
    int leftright         = 1;
    CGPoint next          = self.boatView.layer.position;
    CGPoint pos;
    CGPathMoveToPoint(path, nil, next.x, next.y);
    for (int i = 0 ; i < 6; i++) {
        pos       = next;
        leftright *= -1;
        next      = CGPointMake(pos.x+h*leftright, pos.y+v);
        CGPathAddCurveToPoint(path, nil, pos.x, pos.y+30, next.x, next.y-30, next.x, next.y);
    }
    //动画1-沿着曲线
    CAKeyframeAnimation* anim1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim1.path                 = path;
    anim1.calculationMode      = kCAAnimationPaced;
    //动画2-转反向
    //这个数组和上面的i，以及下面的（animationGroup.duration）要对应
    NSArray* revs  = @[@0.0f,
                       @M_PI,
                       @0.0f,
                       @M_PI,
                       @0.0f,
                       @M_PI];
    CAKeyframeAnimation* anim2 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    anim2.values               = revs;
    anim2.valueFunction        = [CAValueFunction functionWithName:kCAValueFunctionRotateY];
    anim2.calculationMode      = kCAAnimationDiscrete;//因为我是独立的
    //动画3-摇摆
    NSArray* pitches = @[@0.0f,
                         @(M_PI/70),
                         @0.0f,
                         @(-M_PI/70),
                         @0.0f];
    CAKeyframeAnimation* anim3 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    anim3.values        = pitches;
    anim3.repeatCount   = HUGE_VALF;
    anim3.duration      = 0.5;
    anim3.additive      = YES;
    anim3.valueFunction = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
    
    //动画组
    CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[anim1,anim2,anim3];
    animationGroup.duration   = 12;
    [self.boatView.layer addAnimation:animationGroup forKey:nil];
    [CATransaction setDisableActions:YES];
    self.boatView.layer.position = next;
}

@end
