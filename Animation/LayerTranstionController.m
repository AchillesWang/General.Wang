//
//  LayerTranstionController.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-17.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "LayerTranstionController.h"

@interface LayerTranstionController ()
@property (weak, nonatomic) IBOutlet UIView *v;
@property (assign,nonatomic) BOOL isSmilingFace;

@end

@implementation LayerTranstionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CALayer* lay = [CALayer layer];
    lay.frame = self.v.layer.bounds;
    [self.v.layer addSublayer:lay];
    lay.contents        = (id)[UIImage imageNamed:@"Mars"].CGImage;
    lay.contentsGravity = kCAGravityResizeAspectFill;
    self.v.layer.masksToBounds = YES;
    self.v.layer.borderWidth   = 2;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)dismiss:(id)sender {
    [self dismissController];
}
- (IBAction)doAnimation:(id)sender {
    [self animation];
}
-(void)animation
{
    CALayer* lay = self.v.layer.sublayers[0];
    CATransition* t = [CATransition animation];
    t.type     = kCATransitionPush;
    t.subtype  = kCATransitionFromBottom;
    t.duration = 2;
    [CATransaction setDisableActions:YES];
    if (_isSmilingFace) {
        lay.contents = (id)[UIImage imageNamed:@"Mars"].CGImage;
    }else{
        lay.contents = (id)[UIImage imageNamed: @"Smiley"].CGImage;
    }
    [lay addAnimation: t forKey: nil];
    _isSmilingFace = !_isSmilingFace;
}

@end
