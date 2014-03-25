//
//  AppDelegate.m
//  Constraints
//
//  Created by 潇翔 汪 on 14-2-28.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController* mainController = [UIViewController new];
    self.window.rootViewController = mainController;
    
    [self _addViewToView:mainController.view];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)_addViewToView:(UIView*)view
{
    UIView* v1 = [[UIView alloc] initWithFrame:CGRectMake(100, 111, 132, 194)];
    v1.backgroundColor = [UIColor colorWithRed:1 green:.4 blue:1 alpha:1];
    UIView* v2 = [UIView new];
    v2.backgroundColor = [UIColor colorWithRed:.5 green:1 blue:0 alpha:1];
    UIView* v3 = [UIView new];
    v3.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    [view addSubview: v1];
    [v1 addSubview: v2];
    [v1 addSubview: v3];
    v2.translatesAutoresizingMaskIntoConstraints = NO;
    v3.translatesAutoresizingMaskIntoConstraints = NO;
#if 0
    //约束2
    [v1 addConstraint:[NSLayoutConstraint constraintWithItem:v2
                                                   attribute:NSLayoutAttributeLeft
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:v1
                                                   attribute:NSLayoutAttributeLeft
                                                  multiplier:1
                                                    constant:0]];
    
    [v1 addConstraint:[NSLayoutConstraint constraintWithItem:v2
                                                   attribute:NSLayoutAttributeRight
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:v1
                                                   attribute:NSLayoutAttributeRight
                                                  multiplier:1
                                                    constant:0]];
    [v1 addConstraint:[NSLayoutConstraint constraintWithItem:v2
                                                   attribute:NSLayoutAttributeTop
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:v1
                                                   attribute:NSLayoutAttributeTop
                                                  multiplier:1
                                                    constant:0]];
    [v2 addConstraint:[NSLayoutConstraint constraintWithItem:v2
                                                   attribute:NSLayoutAttributeHeight
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:nil
                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1
                                                    constant:20]];
    //约束3
    [v3 addConstraint:[NSLayoutConstraint constraintWithItem:v3
                                                   attribute:NSLayoutAttributeWidth
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:nil
                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1
                                                    constant:50]];
    [v3 addConstraint:[NSLayoutConstraint constraintWithItem:v3
                                                   attribute:NSLayoutAttributeHeight
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:nil
                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1
                                                    constant:50]];
    [v1 addConstraint:[NSLayoutConstraint constraintWithItem:v3
                                                   attribute:NSLayoutAttributeRight
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:v1
                                                   attribute:NSLayoutAttributeRight
                                                  multiplier:1
                                                    constant:0]];
    [v1 addConstraint:[NSLayoutConstraint constraintWithItem:v3
                                                   attribute:NSLayoutAttributeBottom
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:v1
                                                   attribute:NSLayoutAttributeBottom
                                                  multiplier:1
                                                    constant:0]];
#else
    NSDictionary* vs = NSDictionaryOfVariableBindings(v2,v3);
    
    [v1 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v2]|"
                                                               options:0
                                                               metrics:nil
                                                                 views:vs]];
    [v1 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v2(20)]"
                                                               options:0
                                                               metrics:nil
                                                                 views:vs]];
    [v1 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[v3(50)]|"
                                                               options:0
                                                               metrics:nil
                                                                 views:vs]];
    [v1 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v3(70)]|"
                                                               options:0
                                                               metrics:nil
                                                                 views:vs]];

#endif
    double delayInSeconds = 5.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        CGRect r = v1.bounds;
        r.size.width += 40;
        r.size.height -= 50;
        v1.bounds =r;
    });
}
@end
