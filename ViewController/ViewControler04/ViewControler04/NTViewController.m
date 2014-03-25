//
//  NTViewController.m
//  ViewControler04
//
//  Created by 潇翔 汪 on 14-3-14.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTViewController.h"

@interface NTViewController ()

@end

@implementation NTViewController
{
    BOOL _shouldRotate;
}
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

-(NSUInteger)supportedInterfaceOrientations
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    NSLog(@"supported, device %i", orientation);
    if (orientation) {
        NSLog(@"supported self %i", self.interfaceOrientation);
    }
    return UIInterfaceOrientationMaskAll;
}
#if 0
-(BOOL)shouldAutorotate
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    NSLog(@"should, device %i", orientation);
    if (orientation) {
        NSLog(@"should self %i", self.interfaceOrientation);
    }
    return self->_shouldRotate;
}
#endif
/*
    MARK:(RotateToInterfaceOrientation & LayoutSubview & updateViewConstraints执行顺序)
    MARK:|------1、willRotateToInterfaceOrientation:duration:
    MARK:|-----2、updateViewConstraints( UIView会调用updateConstraints )
    MARK:|----3、viewWillLayoutSubviews( UIView会调用layoutSubviews )
    MARK:|---4、viewDidLayoutSubviews
    MARK:|--5、willAnimateRotationToInterfaceOrientation:duration:
    MARK:|-6、didRotateFromInterfaceOrientation:
 */

//MARK:----------分割线----------


/*
    MARK:(RotateToInterfaceOrientation执行顺序)
    MARK:   |-1、willRotateToInterfaceOrientation
    MARK:   |--2、willAnimateRotationToInterfaceOrientation
    MARK:   |---3、didRotateFromInterfaceOrientation
 
 */
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
/*
 MARK:(LayoutSubview&updateViewConstraints执行顺序)
 MARK:   |-1、updateViewConstraints
 MARK:   |--2、viewWillLayoutSubviews
 MARK:   |---3、viewDidLayoutSubviews
 
 */
-(void)updateViewConstraints {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [super updateViewConstraints];
}
-(void)viewWillLayoutSubviews {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

-(void)viewDidLayoutSubviews {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


@end
