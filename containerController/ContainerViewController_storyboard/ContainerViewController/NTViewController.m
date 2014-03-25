//
//  NTViewController.m
//  ContainerViewController
//
//  Created by 潇翔 汪 on 14-3-25.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTViewController.h"

@interface NTViewController ()

@end

@implementation NTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"did load %@ %@", self.view, [self childViewControllers]);
}
//
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"embed"]) {
//        NSLog(@"%@ %@ %@", segue.identifier, segue.sourceViewController, segue.destinationViewController);
//        NSLog(@"%d", [segue.destinationViewController isViewLoaded]);
//        NSLog(@"%@", [segue.sourceViewController childViewControllers]);
//        NSLog(@"%@", [self childViewControllers]);
//    }
//}
//-(void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    NSLog(@"did appear %@ %@", self.view, [self childViewControllers]);
//}
@end
