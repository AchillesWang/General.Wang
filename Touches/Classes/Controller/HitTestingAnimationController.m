//
//  HitTestingAnimationController.m
//  Touches
//
//  Created by 潇翔 汪 on 14-2-26.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "HitTestingAnimationController.h"

@interface HitTestingAnimationController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation HitTestingAnimationController
{
    CGPoint _oldButtonCenter;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self->_oldButtonCenter = self.button.center; // so we can test repeatedly
}
- (IBAction)start:(id)sender {
    NSLog(@"you tapped Start");
    CGPoint goal = CGPointMake(100,400);
    self.button.center = self->_oldButtonCenter;
    
#define which 2 // try 2; no diff, just proving it's the same for both ways of animating
    
#if which == 1
    
    UIViewAnimationOptions opt = UIViewAnimationOptionAllowUserInteraction;
    [UIView animateWithDuration:10 delay:0 options:opt animations:^{
        self.button.center = goal;
    } completion:nil];
    
#elif which == 2
    
    CABasicAnimation* ba = [CABasicAnimation animationWithKeyPath:@"position"];
    ba.duration = 10;
    ba.fromValue = [NSValue valueWithCGPoint:self->_oldButtonCenter];
    ba.toValue = [NSValue valueWithCGPoint:goal];
    [self.button.layer addAnimation:ba forKey:nil];
    self.button.layer.position = goal;
    
#endif
    

}
- (IBAction)tapme:(id)sender {
    NSLog(@"tap! (the button's action method)");
}

@end
