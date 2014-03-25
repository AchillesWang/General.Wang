//
//  HitTestingViewController.m
//  Touches
//
//  Created by 潇翔 汪 on 14-2-25.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "HitTestingViewController.h"

@interface HitTestingViewController ()

@end

@implementation HitTestingViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.tag = 1001;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)dooButton:(id)sender {
    NSLog(@"%@", @"button tap!");
}

- (IBAction)tapped1:(UITapGestureRecognizer *)g {
    CGPoint p = [g locationOfTouch:0 inView:g.view];
    NSLog(@"1、%@",NSStringFromClass(g.view.class));
    UIView* v = [g.view hitTest:p withEvent:nil];
    NSLog(@"2、%@",NSStringFromClass(v.class));
//    NSLog(@"v.c:%@,%d,%ld",g.view.class,[v isKindOfClass:[UIImageView class]],v.tag);
    if (v && [v isKindOfClass:[UIImageView class]]) {
        NSLog(@"YES");
        // warning: autolayout breaks this animation (don't get me started)
        // the workaround is to use full-on Core Animation
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionAutoreverse
                         animations:^{
                             v.transform = CGAffineTransformMakeScale(1.1, 1.1);
                         } completion:^ (BOOL b) {
                             v.transform = CGAffineTransformIdentity;
                         }];
    }
}


@end
