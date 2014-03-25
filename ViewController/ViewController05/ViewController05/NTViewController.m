//
//  NTViewController.m
//  ViewController05
//
//  Created by 潇翔 汪 on 14-3-14.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTViewController.h"

@interface NTViewController ()
@property (nonatomic, strong) UIView* blackRect;
@property (nonatomic, strong) NSArray* blackRectConstraintsOnscreen;
@property (nonatomic, strong) NSArray* blackRectConstraintsOffscreen;
@end

@implementation NTViewController
#define which 2
#if which == 1
-(UIView*)blackRect
{
    if (!self->_blackRect) {
        if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
            return nil;
        }
        CGRect f  = self.view.bounds;
        f.size.width /= 3.0;
        f.origin.x = -f.size.width;
        UIView* br = [[UIView alloc]initWithFrame:f];
        br.backgroundColor = [UIColor blackColor];
        self.blackRect = br;
    }
    return self->_blackRect;
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    UIView* v = self.blackRect;
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        if (!v.superview) {
            // show
            [self.view addSubview:v];
            CGRect f = v.frame;
            f.origin.x = 0;
            v.frame = f;
        }
    }else{
        if (v.superview) {
            //hide
            CGRect f = v.frame;
            f.origin.x -= f.size.width;
            v.frame =f;
        }
    }
}
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        [self.blackRect removeFromSuperview];
    }
}
#elif which == 2
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView* br = [UIView new];
    br.translatesAutoresizingMaskIntoConstraints = NO;
    br.backgroundColor = [UIColor blackColor];
    [self.view addSubview:br];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[br]|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:@{@"br":br}]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:br
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0/3.0
                                                           constant:0]];
    
    NSArray* marrOn = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[br]"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:@{@"br":br}];
    
    NSArray* marrOff = @[
                         [NSLayoutConstraint constraintWithItem:br
                                                      attribute:NSLayoutAttributeRight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self.view
                                                      attribute:NSLayoutAttributeLeft
                                                     multiplier:1
                                                       constant:0]
                         ];
    self.blackRectConstraintsOnscreen = marrOn;
    self.blackRectConstraintsOffscreen = marrOff;
}

-(void)updateViewConstraints
{
     NSLog(@"updateviewconstraints %i", self.interfaceOrientation);
    [self.view removeConstraints:self.blackRectConstraintsOnscreen];
    [self.view removeConstraints:self.blackRectConstraintsOffscreen];
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        [self.view addConstraints:self.blackRectConstraintsOnscreen];
    }else{
        [self.view addConstraints:self.blackRectConstraintsOffscreen];
    }
    [super updateViewConstraints];
}

#endif



@end
