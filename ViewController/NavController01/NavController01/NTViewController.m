//
//  NTViewController.m
//  NavController01
//
//  Created by 潇翔 汪 on 14-3-17.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTViewController.h"
#import "NTSecondController.h"

@interface NTViewController ()<UINavigationControllerDelegate>

@end

@implementation NTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)awakeFromNib
{
    self.title = @"first";
    UIBarButtonItem* b = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"key.png"]
                                                          style:UIBarButtonItemStyleBordered
                                                         target:self
                                                         action:@selector(navigate)];
    UIBarButtonItem* b2 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"files.png"]
                                                          style:UIBarButtonItemStyleBordered
                                                         target:nil
                                                         action:nil];
    self.navigationItem.rightBarButtonItems = @[b, b2];
    
    b = [[UIBarButtonItem alloc] initWithTitle:@"你好"
                                         style:UIBarButtonItemStylePlain
                                        target:nil
                                        action:nil];
    self.navigationItem.backBarButtonItem = b;
    
    
}

-(void) navigate {
    NTSecondController* v2c = [[NTSecondController alloc] init];
    [self.navigationController pushViewController:v2c animated:YES];
}

-(NSUInteger)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
