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
	// Do any additional setup after loading the view, typically from a nib.
//    UIViewController* vc = self->_swappers[_cur];
//    vc.view.frame = self.panel.bounds;
//    [self.panel addSubview:vc.view];
//    
//    [vc didMoveToParentViewController:self];
    UIViewController* vc = self->_swappers[_cur];
    [self addChildViewController:vc]; // "will" called for us
    vc.view.frame = self.panel.bounds;
    [self.panel addSubview: vc.view]; // insert view into interface between "will" and "did"
    // note: when we call add, we must call "did" afterwards
    [vc didMoveToParentViewController:self];
}


- (IBAction)doButton:(id)sender {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    UIViewController* fromvc = self->_swappers[_cur];
    _cur = (_cur == 0) ? 1 : 0;
    UIViewController* tovc = self->_swappers[_cur];
    tovc.view.frame = self.panel.bounds;
    // must have both as children before we can transition between them
    [self addChildViewController:tovc]; // "will" called for us
    // note: when we call remove, we must call "will" (with nil) beforehand
    [fromvc willMoveToParentViewController:nil];
    [self transitionFromViewController:fromvc
                      toViewController:tovc
                              duration:0.4
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:nil
                            completion:^(BOOL finished) {
                                [tovc didMoveToParentViewController:self];
                                [fromvc removeFromParentViewController];
                                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                            }];
}

@end