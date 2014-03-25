//
//  NTAppDelegate.m
//  ControllerAnimation02
//
//  Created by 潇翔 汪 on 14-3-18.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTAppDelegate.h"

@interface NTAppDelegate ()<UITabBarControllerDelegate,UIViewControllerAnimatedTransitioning,UIGestureRecognizerDelegate,UIViewControllerInteractiveTransitioning>

@property (nonatomic, strong) id <UIViewControllerContextTransitioning> context;
@property BOOL interacting;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer* rightEdger;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer* leftEdger;

@property CGRect r1end;
@property CGRect r2start;
@end

@implementation NTAppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UITabBarController* tbc = (UITabBarController*)self.window.rootViewController;
    tbc.delegate = self;
    
    UIScreenEdgePanGestureRecognizer* sep = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    sep.edges = UIRectEdgeRight;
    [tbc.view addGestureRecognizer:sep];
    sep.delegate = self;
    self.rightEdger = sep;
    
    sep = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    sep.edges = UIRectEdgeLeft;
    [tbc.view addGestureRecognizer:sep];
    sep.delegate = self;
    self.leftEdger = sep;
    return YES;
}
//MARK:----手势将要开始识别，
-(BOOL)gestureRecognizerShouldBegin:(UIScreenEdgePanGestureRecognizer *)g {
    UITabBarController* tbc = (UITabBarController*)self.window.rootViewController;
    BOOL result = NO;
    if (g == self.rightEdger){
        //当你点击最后一个无法在向后移动
        result = (tbc.selectedIndex < tbc.viewControllers.count - 1);
    }else{
        //当你在第一个标签时无法向前移动
        result = (tbc.selectedIndex > 0);
    }
    return result;
}

-(void)pan:(UIScreenEdgePanGestureRecognizer*)g
{
    UIView* v = g.view;
    if (g.state == UIGestureRecognizerStateBegan) {  //手势识别状态开始
        self.interacting = YES;
        UITabBarController* tbc = (UITabBarController*)self.window.rootViewController;
        if (g == self.rightEdger)
            tbc.selectedIndex = tbc.selectedIndex + 1;//切换到下一个页面
        else
            tbc.selectedIndex = tbc.selectedIndex - 1;//切换到上一个页面
    }else if(g.state == UIGestureRecognizerStateChanged){ //手势识别状态 改变
        CGPoint delta = [g translationInView:v];
        CGFloat percent = fabs(delta.x/v.bounds.size.width); //获得运动的百分比
        //过度的上下文
        id <UIViewControllerContextTransitioning> transitionContext = self.context;
        UIViewController* vc1 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController* vc2 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        //视图动画起始位置
        CGRect r1start = [transitionContext initialFrameForViewController:vc1];
        //视图动画起终止位置
        CGRect r2end = [transitionContext finalFrameForViewController:vc2];
        UIView* v1 = vc1.view;
        UIView* v2 = vc2.view;
        CGRect r1end = self.r1end;
        CGRect r2start = self.r2start;
        
        r1start.origin.x += (r1end.origin.x - r1start.origin.x)*percent;
        v1.frame = r1start;
        
        r2start.origin.x += (r2end.origin.x - r2start.origin.x)*percent;
        v2.frame = r2start;
        [transitionContext updateInteractiveTransition:percent];
        
    }else if(g.state == UIGestureRecognizerStateEnded){ //手势识别结束
        CGPoint delta = [g translationInView: v];
        CGFloat percent = fabs(delta.x/v.bounds.size.width); //一共移动距离的百分比
        
        id <UIViewControllerContextTransitioning> transitionContext = self.context;
        UIViewController* vc1 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController* vc2 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        CGRect r1start = [transitionContext initialFrameForViewController:vc1];
        CGRect r2end = [transitionContext finalFrameForViewController:vc2];
        UIView* v1 = vc1.view;
        UIView* v2 = vc2.view;
        CGRect r1end = self.r1end;
        CGRect r2start = self.r2start;
        
        if (percent>=0.3) {  //移动的比率超过50%(过一半了)
            [UIView animateWithDuration:0.2 animations:^{
                v1.frame = r1end;
                v2.frame = r2end;
            } completion:^(BOOL finished) {
                [transitionContext finishInteractiveTransition];
                [transitionContext completeTransition:YES];
                self.interacting = NO;
            }];
        }else{
            //返回原来的位置
            [UIView animateWithDuration:0.2 animations:^{
                v1.frame = r1start;
                v2.frame = r2start;
            } completion:^(BOOL finished) {
                [transitionContext cancelInteractiveTransition];
                [transitionContext completeTransition:NO];
                self.interacting = NO;
            }];
        }
    }else if (g.state == UIGestureRecognizerStateCancelled){ //手势取消
        id <UIViewControllerContextTransitioning> transitionContext = self.context;
        
        UIViewController* vc1 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController* vc2 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        CGRect r1start = [transitionContext initialFrameForViewController:vc1];
        // CGRect r2end = [transitionContext finalFrameForViewController:vc2];
        UIView* v1 = vc1.view;
        UIView* v2 = vc2.view;
        // CGRect r1end = self.r1end;
        CGRect r2start = self.r2start;
        v1.frame = r1start;
        v2.frame = r2start;
        [self.context cancelInteractiveTransition];
        [transitionContext completeTransition:NO];
        self.interacting = NO;
    }
}
-(id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return self.interacting ? self : nil;
}

-(id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return self.interacting ? self : nil;
}

-(void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // store transition context so the gesture recognizer can get at it
    self.context = transitionContext;
    // set up initial conditions
    UIViewController* vc1 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* vc2 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* con = [transitionContext containerView];
    CGRect r1start = [transitionContext initialFrameForViewController:vc1];
    CGRect r2end = [transitionContext finalFrameForViewController:vc2];
    // UIView* v1 = vc1.view;
    UIView* v2 = vc2.view;
    
    // which way we are going depends on which vc is which
    // the most general way to express this is in terms of index number
    UITabBarController* tbc = (UITabBarController*)self.window.rootViewController;
    int ix1 = [tbc.viewControllers indexOfObject:vc1];
    int ix2 = [tbc.viewControllers indexOfObject:vc2];
    int dir = ix1 < ix2 ? 1 : -1;
    CGRect r = r1start;
    r.origin.x -= r.size.width * dir;
    CGRect r1end = r;
    r = r2end;
    r.origin.x += r.size.width * dir;
    CGRect r2start = r;
    
    v2.frame = r2start;
    [con addSubview:v2];
    
    // record initial conditions so the gesture recognizer can get at them
    self.r1end = r1end;
    self.r2start = r2start;
//    NSLog(@"r1start:%@",NSStringFromCGRect(r1start));
//    NSLog(@"r1end:%@",NSStringFromCGRect(r1end));
//    NSLog(@"r2start:%@",NSStringFromCGRect(r2start));
//    NSLog(@"r2end:%@",NSStringFromCGRect(r2end));
}
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return 0.4;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
@end
