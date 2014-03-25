//
//  NTViewController.m
//  Controller01
//
//  Created by 潇翔 汪 on 14-3-13.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTViewController.h"

@interface NTViewController ()

@end

@implementation NTViewController
#define which 3

#if which == 1
-(void)loadView
{
    UIView* v = [UIView new];
    v.backgroundColor = [UIColor greenColor];
    self.view = v;
    
    UILabel* lb = [UILabel new];
    [v addSubview:lb];
    lb.text = @"Hello,World!";
    lb.autoresizingMask = (
                           UIViewAutoresizingFlexibleTopMargin |
                           UIViewAutoresizingFlexibleLeftMargin |
                           UIViewAutoresizingFlexibleBottomMargin |
                           UIViewAutoresizingFlexibleRightMargin
                           );
    [lb sizeToFit];
    lb.center = CGPointMake(CGRectGetMidX(v.bounds), CGRectGetMidY(v.bounds));
    lb.frame = CGRectIntegral(lb.frame);
}
#elif which ==2
-(void)loadView
{
    UIView* v = [UIView new];
    v.backgroundColor = [UIColor greenColor];
    self.view = v;
    UILabel* label = [UILabel new];
    [v addSubview:label];
    label.text = @"Hello, World!";
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:label
                              attribute:NSLayoutAttributeCenterX
                              relatedBy:0
                              toItem:self.view
                              attribute:NSLayoutAttributeCenterX
                              multiplier:1
                              constant:0]];
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:label
                              attribute:NSLayoutAttributeCenterY
                              relatedBy:0
                              toItem:self.view
                              attribute:NSLayoutAttributeCenterY
                              multiplier:1
                              constant:0]];
//    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:label
//                                                          attribute:NSLayoutAttributeCenterX
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.view
//                                                          attribute:NSLayoutAttributeCenterY
//                                                         multiplier:1
//                                                           constant:0]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:label
//                                                          attribute:NSLayoutAttributeCenterX
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.view
//                                                          attribute:NSLayoutAttributeCenterY
//                                                         multiplier:1
//                                                           constant:0]];
}

#elif which == 3
-(void)loadView
{
    UIView * v = [UIView new];
    self.view = v;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    UIView* v = self.view;
    v.backgroundColor = [UIColor greenColor];
    UILabel* label = [UILabel new];
    [v addSubview:label];
    label.text = @"Hello,你妹!";
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:label
                              attribute:NSLayoutAttributeCenterY
                              relatedBy:0
                              toItem:self.view
                              attribute:NSLayoutAttributeCenterY
                              multiplier:1
                              constant:0]];
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:label
                              attribute:NSLayoutAttributeLeft
                              relatedBy:0
                              toItem:self.view
                              attribute:NSLayoutAttributeLeft
                              multiplier:1
                              constant:100]];
}
#endif

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
