//
//  NTSecondController.m
//  ViewController
//
//  Created by 潇翔 汪 on 14-3-17.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTSecondController.h"

@interface NTSecondController ()

@end

@implementation NTSecondController

- (IBAction)diss:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"3、dis completion"); // 2
    }];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.isBeingDismissed) {
        NSLog(@"2、你妹");// 1
    }
    
}
#if 0
-(NSUInteger)supportedInterfaceOrientations {
    NSLog(@"%@", @"presented supported");
    return UIInterfaceOrientationMaskLandscape;
}

//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationLandscapeLeft;
//}
-(void)viewWillLayoutSubviews {
    NSLog(@"%@", @"presented will layout");
}
#endif

@end
