//
//  NTViewController.m
//  containerController
//
//  Created by 潇翔 汪 on 14-3-24.
//  Copyright (c) 2014 潇翔 汪. All rights reserved.
//

#import "NTViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"


@interface NTViewController ()
@property (weak, nonatomic) IBOutlet UIView *panel;

@end

@implementation NTViewController
{
    int _cur;
    NSMutableArray* _swappers;
}

-(void)awakeFromNib
{
    self->_swappers = [NSMutableArray new];
    [self->_swappers addObject:[FirstViewController new]];
    [self->_swappers addObject:[SecondViewController new]];
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIViewController* vc = self->_swappers[_cur];
    [self addChildViewController:vc]; // "will" called for us
    vc.view.frame = self.panel.bounds;
    [self.panel addSubview: vc.view]; // insert view into interface between "will" and "did"
    // note: when we call add, we must call "did" afterwards
    [vc didMoveToParentViewController:self];
    [self constrainInPanel:vc.view];
}


- (IBAction)doButton:(id)sender {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    UIViewController* fromvc = self->_swappers[_cur];
    _cur = (_cur == 0) ? 1 : 0;
    UIViewController* tovc = self->_swappers[_cur];
    tovc.view.frame = self.panel.bounds;
    //Animation
    //Aniamtion start config
    UIGraphicsBeginImageContextWithOptions(tovc.view.bounds.size, YES, 0);
    [tovc.view.layer renderInContext:UIGraphicsGetCurrentContext()]; //This method renders directly from the layer tree, 获得图层树渲染的上下文
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView* iv = [[UIImageView alloc] initWithImage:im];
    iv.frame = CGRectZero;
    [self.panel addSubview:iv];
    tovc.view.alpha = 0;

    //Aniamtion start config(end)
    
    // must have both as children before we can transition between them
    [self addChildViewController:tovc]; // "will" called for us
    // note: when we call remove, we must call "will" (with nil) beforehand
    [fromvc willMoveToParentViewController:nil];
    [self transitionFromViewController:fromvc
                      toViewController:tovc
                              duration:0.4
                               options:UIViewAnimationOptionTransitionNone
                            animations:^{
                                iv.frame = self.panel.bounds;
                            }
                            completion:^(BOOL finished) {
                                tovc.view.alpha = 1;
//                                [iv removeFromSuperview];
                                [tovc didMoveToParentViewController:self];
                                [fromvc removeFromParentViewController];
                                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                [self constrainInPanel:tovc.view];
                            }];
}
- (void) constrainInPanel: (UIView*) v {
    }
@end