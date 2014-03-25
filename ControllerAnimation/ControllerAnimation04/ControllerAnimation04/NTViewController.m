//
//  NTViewController.m
//  ControllerAnimation04
//
//  Created by 潇翔 汪 on 14-3-19.
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doButton:(id)sender {
    
    [self presentViewController:[[NTSecondController alloc] initWithNibName:@"scc" bundle:nil]
                       animated:YES
                     completion:nil];
}



@end
