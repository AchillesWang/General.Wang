//
//  TransitionViewController.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-12.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "TransitionViewController.h"
#import "MyView.h"


@interface TransitionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *aImageView;
@property (weak, nonatomic) IBOutlet MyView *aRectView;
@property (weak, nonatomic) IBOutlet UILabel *aLabel;

@property (weak, nonatomic) IBOutlet UIView *innerView;
@property (weak, nonatomic) IBOutlet UIView *outerView;
@property (weak, nonatomic) IBOutlet UIButton *aButton;

@end

@implementation TransitionViewController


-(void) animate{
    NSUInteger opts = UIViewAnimationOptionTransitionFlipFromBottom;
    [UIView transitionWithView:self.aImageView duration:0.8 options:opts animations:^{
        self.aImageView.image = [UIImage imageNamed:@"hehe.gif"];
    } completion:^(BOOL finished) {
        
    }];
    self.aRectView.reverse = !self.aRectView.reverse ;
    [UIView transitionWithView:self.aRectView duration:0.8 options:opts animations:^{
        [self.aRectView setNeedsDisplay];
    } completion:^(BOOL finished) {
        
    }];
    UILabel* lab2 = [[UILabel alloc] initWithFrame:self.aLabel.frame];
    lab2.text = ([self.aLabel.text isEqualToString:@"Hello"] ? @"Howdy" : @"Hello");
    [lab2 sizeToFit];
    
    [UIView transitionFromView:self.aLabel toView:lab2 duration:2 options:opts completion:^(BOOL finished) {
        self.aLabel = lab2;
    }];
    
    opts = UIViewAnimationOptionTransitionFlipFromBottom | UIViewAnimationOptionAllowAnimatedContent;
    [UIView transitionWithView:self.outerView duration:1 options:opts
                    animations:^{
                        
                        CGRect f = self.innerView.frame;
                        f.size.width = self.outerView.frame.size.width;
                        f.origin.x = 0;
                        self.innerView.frame = f;
                        
                        
                    } completion:nil];
}

- (IBAction)startAnimation:(id)sender {
    [self animate];
}
- (IBAction)dismiss:(id)sender {
    [self dismissController];
}

@end
