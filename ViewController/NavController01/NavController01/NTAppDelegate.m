//
//  NTAppDelegate.m
//  NavController01
//
//  Created by 潇翔 汪 on 14-3-17.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTAppDelegate.h"

@implementation NTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     @{NSForegroundColorAttributeName: [UIColor blackColor]}
                                                forState:UIControlStateNormal];
    
    UIImage* im = [UIImage imageNamed:@"linen.png"];
    CGSize sz = CGSizeMake(5,34);
    UIGraphicsBeginImageContextWithOptions(sz, NO, 0);
    [im drawAtPoint:CGPointMake(-55,-55)];
    UIImage* im2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    im2 = [im2 resizableImageWithCapInsets:UIEdgeInsetsMake(0,0,0,0) resizingMode:UIImageResizingModeTile];
    [(UIBarButtonItem*)[UIBarButtonItem appearance] setBackgroundImage:im2 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    return YES;
}


@end
