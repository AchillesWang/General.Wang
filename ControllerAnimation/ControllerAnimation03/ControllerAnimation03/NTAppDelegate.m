//
//  NTAppDelegate.m
//  ControllerAnimation03
//
//  Created by 潇翔 汪 on 14-3-19.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTAppDelegate.h"

@interface NTAppDelegate ()<UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning>



@end


@implementation NTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
     [(UINavigationController*)self.window.rootViewController setDelegate:self];
    return YES;
}
							
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush)
        return self;
    return nil;
}
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* vc1 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* vc2 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* con = [transitionContext containerView];
    
    CGRect r2end = [transitionContext finalFrameForViewController:vc2];
    
    UIView* v2 = vc2.view;
    UIView* v1 = vc1.view;
    [con addSubview:v2];
    
    v2.frame = r2end;
    v2.alpha = 0 ;
    NSLog(@"%@",NSStringFromCGAffineTransform(v1.transform));
    [UIView animateWithDuration:0.6 animations:^{
        v2.alpha = 1;
        v1.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        v1.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:YES];
    }];
}
@end
