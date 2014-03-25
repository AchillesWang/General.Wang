//
//  GestureRecognizersDelegateController.m
//  Touches
//
//  Created by 潇翔 汪 on 14-2-25.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "GestureRecognizersDelegateController.h"

@interface GestureRecognizersDelegateController ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *v;
@property (strong, nonatomic) UILongPressGestureRecognizer* longPressGR;

@end

@implementation GestureRecognizersDelegateController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIPanGestureRecognizer* p = [[UIPanGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(dragging:)];
    _longPressGR= [[UILongPressGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(longPress:)];
    [self.v addGestureRecognizer:p];
    [self.v addGestureRecognizer:_longPressGR];
    _longPressGR.numberOfTapsRequired =1;
    p.delegate = self;
}

-(void)dragging:(UIPanGestureRecognizer*)p
{
//    NSLog(@"%s",__func__);
    UIView* vv = p.view;
    if (p.state == UIGestureRecognizerStateBegan ||
        p.state == UIGestureRecognizerStateChanged) {
        CGPoint delta = [p translationInView: vv.superview];
        CGPoint c = vv.center;
        c.x += delta.x; c.y += delta.y;
        vv.center = c;
        [p setTranslation: CGPointZero inView: vv.superview];
    }
}

-(void)longPress:(UILongPressGestureRecognizer*)lp
{
//    NSLog(@"%s",__func__);
    if (lp.state == UIGestureRecognizerStateBegan) {
        CABasicAnimation* anim =
        [CABasicAnimation animationWithKeyPath: @"transform"];
        anim.toValue =
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.1)];
        anim.fromValue =
        [NSValue valueWithCATransform3D:CATransform3DIdentity];
        anim.repeatCount = HUGE_VALF;
        anim.autoreverses = YES;
        [lp.view.layer addAnimation:anim forKey:nil];
    }
    if (lp.state == UIGestureRecognizerStateEnded ||
        lp.state == UIGestureRecognizerStateCancelled) {
        [lp.view.layer removeAllAnimations];
    }
    
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.longPressGR.state == UIGestureRecognizerStatePossible ||self.longPressGR.state == UIGestureRecognizerStateFailed) {
        return NO;
    }
    return YES;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
@end
