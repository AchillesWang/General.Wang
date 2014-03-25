//
//  GestureRecognizersController.m
//  Touches
//
//  Created by 潇翔 汪 on 14-2-24.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "GestureRecognizersController.h"
#import "HorizPanGestureRecognizer.h"
#import "VertPanGestureRecognizer.h"


@interface GestureRecognizersController ()

@property (weak, nonatomic) IBOutlet UIView *v;

@end

@implementation GestureRecognizersController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer* t2 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(doubleTap)];
    t2.numberOfTapsRequired = 2;
    //手指数
//    t2.numberOfTouchesRequired = 2;
    [self.v addGestureRecognizer:t2];
    
    UITapGestureRecognizer* t1 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(singleTap)];
    [t1 requireGestureRecognizerToFail:t2];
    [self.v addGestureRecognizer:t1];
#define which 2
#if which == 1
    UIPanGestureRecognizer* p = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                                       action:@selector(dragging:)];
    [self.v addGestureRecognizer:p];
#elif which == 2
    UIPanGestureRecognizer*p =[[HorizPanGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(dragging:)];
    [self.v addGestureRecognizer:p];
    UIPanGestureRecognizer* p2 = [[VertPanGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(dragging:)];
    [self.v addGestureRecognizer:p2];
#endif
}

-(void)dragging:(UIPanGestureRecognizer*)p
{
    UIView* vv = p.view;
    if (p.state == UIGestureRecognizerStateBegan||p.state == UIGestureRecognizerStateChanged) {
        CGPoint delta = [p translationInView:vv.superview];
        CGPoint c = vv.center;
        c.x += delta.x; c.y += delta.y;
        vv.center = c;
        [p setTranslation:CGPointZero inView:vv.superview];
    }
}

-(void)doubleTap
{
    NSLog(@"doubleTap");
}
-(void)singleTap
{
    NSLog(@"singleTap");
}
@end
