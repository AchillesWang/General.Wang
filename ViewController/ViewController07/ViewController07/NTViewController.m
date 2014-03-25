//
//  NTViewController.m
//  ViewController07
//
//  Created by 潇翔 汪 on 14-3-17.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTViewController.h"
#import "NTSecondController.h"

@interface NTViewController ()

@end

@implementation NTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(screenRotated:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}
- (void)screenRotated:(NSNotification *)n
{
    NSLog(@"serf,1:%@",self);
    UIDeviceOrientation r = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation r2 = (UIInterfaceOrientation)r;
    if (UIDeviceOrientationIsLandscape(r)& !self.presentedViewController) {
        [[UIApplication sharedApplication] setStatusBarOrientation:r2 animated:YES];
        UIViewController* vc = [NTSecondController new];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:vc
                           animated:YES
                         completion:nil];
    }else if (UIDeviceOrientationPortrait == r){
        [[UIApplication sharedApplication]
         setStatusBarOrientation:r2 animated:YES];
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"Done");
        }];
        NSLog(@"serf,2:%@",self);
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)supportedInterfaceOrientations
{
    return 0;
}



@end
