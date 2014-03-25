//
//  KeyFrameViewController.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-11.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "KeyFrameViewController.h"

@interface KeyFrameViewController ()

@property (weak, nonatomic) IBOutlet UIButton *animationButton;

@property (weak, nonatomic) IBOutlet UIImageView *animationImage;

@end

@implementation KeyFrameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startAniamtion:(UIButton *)sender {
    
    __block CGPoint p = self.animationImage.center;
    _animationButton.enabled  = NO;
    NSUInteger opt = UIViewKeyframeAnimationOptionCalculationModeLinear|UIViewAnimationOptionCurveLinear;
    
    
    CGFloat dur = 0.25;
    
    BTypeAnimations animations = ^{
        _animationImage.alpha = 0.0f;
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:dur animations:^{
            p.x +=150;
            p.y += 50;
            _animationImage.center = p;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.25f relativeDuration:dur animations:^{
            p.x -=150;
            p.y += 50;
            _animationImage.center = p;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5f relativeDuration:dur animations:^{
            p.x +=150;
            p.y += 50;
            _animationImage.center = p;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.75f relativeDuration:dur animations:^{
            p.x -=150;
            p.y += 50;
            _animationImage.center = p;
        }];
    };
    
    BTypeCompletion completion = ^(BOOL finished){
    
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            _animationImage.center = CGPointMake(90, 115);
            _animationImage.alpha = 1.0f;
            _animationButton.enabled = YES;
        });
    };
    
    [UIView animateKeyframesWithDuration:4
                                   delay:0
                                 options:opt
                              animations:animations
                              completion:completion];
}


- (IBAction)dismiss:(id)sender {
    [self dismissController];
}

@end
