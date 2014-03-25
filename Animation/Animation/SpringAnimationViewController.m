//
//  SpringAnimationViewController.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-11.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "SpringAnimationViewController.h"



@interface SpringAnimationViewController ()

- (IBAction)startAniamtion:(UIButton *)sender;

@property (nonatomic,weak) IBOutlet UIImageView* imageView;

@property (nonatomic,weak) IBOutlet UIButton* animationButton;

@end

@implementation SpringAnimationViewController

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
    _animationButton.enabled = NO;
    BTypeAnimations animations = ^{
        _imageView.transform = CGAffineTransformScale(_imageView.transform, 2, 2);
    };
    BTypeCompletion completion = ^(BOOL finished){
        if (finished) {
            double delayInSeconds = 2.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                _imageView.transform = CGAffineTransformIdentity;
                _animationButton.enabled = YES;
            });
        }
    };
    [UIView animateWithDuration:2.0f
                          delay:0.2f
         usingSpringWithDamping:0.5f
          initialSpringVelocity:10.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:animations
                     completion:completion];
}
- (IBAction)dismiss:(id)sender {
    [self dismissController];
}
@end
