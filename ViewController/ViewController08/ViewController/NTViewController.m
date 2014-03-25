//
//  NTViewController.m
//  ViewController
//
//  Created by 潇翔 汪 on 14-3-17.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTViewController.h"
#include "NTSecondController.h"


@interface NTViewController ()

@end

@implementation NTViewController


- (IBAction)presenterd:(id)sender {
    NTSecondController* vc = [NTSecondController new];
    //modalTransitionStyle 是当你推出一个视图时的动画
    //self.view.window.backgroundColor 为什么要修改它呢？因为当你使用UIModalTransitionStyleFlipHorizontal
    //这类动画时window的颜色将会呈现
//    typedef NS_ENUM(NSInteger, UIModalTransitionStyle) {
//        UIModalTransitionStyleCoverVertical = 0,      默认动画
//        UIModalTransitionStyleFlipHorizontal,         水平翻转
//        UIModalTransitionStyleCrossDissolve,          一闪而过
//        UIModalTransitionStylePartialCurl,            翻页
//    };
    
//    vc.modalPresentationStyle = UIModalPresentationFormSheet;表现风格决定了一个模态呈现视图控制器屏幕上显示。在iPhone和iPod touch，模态视图控制器总是呈现全屏，但是在iPad上有几种不同的显示选项
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    self.view.window.backgroundColor = [UIColor orangeColor];
    [self presentViewController:vc animated:YES completion:^{
        NSLog(@"completion");
    }];
}


-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    NSLog(@"1、here");
    [super dismissViewControllerAnimated:flag completion:completion];
};
@end
