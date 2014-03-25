//
//  NTViewController.m
//  ControllerAnimation03
//
//  Created by 潇翔 汪 on 14-3-19.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTViewController.h"
#import "NTDetailController.h"


@interface NTViewController ()

@end

@implementation NTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Push" style:UIBarButtonItemStylePlain target:self action:@selector(doPush:)];
    self.navigationItem.rightBarButtonItem = addButton;
}
- (void) doPush: (id) sender {
    //    NSLog(@"%@", [self.view.window performSelector:@selector(recursiveDescription)]);
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        [[segue destinationViewController] setDetailItem:[NSDate date]];
    }
}

@end
