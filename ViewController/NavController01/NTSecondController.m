//
//  NTSecondController.m
//  NavController01
//
//  Created by 潇翔 汪 on 14-3-17.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTSecondController.h"

@interface NTSecondController ()<UINavigationControllerDelegate>

@end

@implementation NTSecondController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Second";
        UIBarButtonItem* b = [[UIBarButtonItem alloc]
                              initWithImage:[UIImage imageNamed:@"files.png"]
                              style:UIBarButtonItemStylePlain target:nil action:nil];
        // can have both left bar buttons and back bar button
        self.navigationItem.leftBarButtonItem = b;
        self.navigationItem.leftItemsSupplementBackButton = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
