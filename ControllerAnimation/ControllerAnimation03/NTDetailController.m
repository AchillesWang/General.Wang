//
//  NTDetailController.m
//  ControllerAnimation03
//
//  Created by 潇翔 汪 on 14-3-19.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTDetailController.h"

@interface NTDetailController ()
- (void)configureView;
@end

@implementation NTDetailController

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // NSLog(@"%@", self.navigationController.interactivePopGestureRecognizer);
    
    //    NSLog(@"%@", [self.view.window performSelector:@selector(recursiveDescription)]);
    
}
@end
