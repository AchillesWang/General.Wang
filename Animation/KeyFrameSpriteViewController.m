//
//  KeyFrameSpriteViewController.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-14.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "KeyFrameSpriteViewController.h"

@interface KeyFrameSpriteViewController ()

@property (nonatomic, strong) CALayer* sprite;

@property (nonatomic, strong) NSArray* images;

@end

@implementation KeyFrameSpriteViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSMutableArray* arr = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(24,24), YES, 0);
        [[UIImage imageNamed: @"sprites.png"]
         drawAtPoint:CGPointMake(-i*24,-7*24)];
        UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [arr addObject: (id)im.CGImage];
    }
    //    for (int i = 9; i >= 5; i--) {
    //        UIGraphicsBeginImageContextWithOptions(CGSizeMake(24,24), YES, 0);
    //        [[UIImage imageNamed: @"sprites.png"]
    //         drawAtPoint:CGPointMake(-i*24,-7*24)];
    //        UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    //        UIGraphicsEndImageContext();
    //        [arr addObject: (id)im.CGImage];
    //    }
    self.images = [arr copy];
    self.sprite = [CALayer new];
    self.sprite.frame = CGRectMake(30,30,24,24);
    self.sprite.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer:self.sprite];
    self.sprite.contents = self.images[0];
}

- (IBAction)do:(id)sender {
    CAKeyframeAnimation* anim = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    anim.values = self.images;
    anim.keyTimes = @[@0,
                      @0.1,
                      @0.2,
                      @0.3,
                      @0.4,
                      @0.5,
                      @0.6,
                      @0.7,
                      @0.8,
                      @0.9,
                      @1];
    anim.calculationMode = kCAAnimationCubic;
    anim.duration = 2.5;
    anim.repeatCount = HUGE_VALF;
    
    CABasicAnimation* anim2 = [CABasicAnimation animationWithKeyPath:@"position"];
    anim2.duration = 10;
    anim2.toValue = [NSValue valueWithCGPoint: CGPointMake(350,30)];
    
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.animations = @[anim, anim2];
    group.duration = 10;
    
    [self.sprite addAnimation:group forKey:nil];
}

- (IBAction)dismiss:(id)sender {
    [self dismissController];
}

@end
