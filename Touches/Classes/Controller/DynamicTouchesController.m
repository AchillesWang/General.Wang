//
//  DynamicTouchesController.m
//  Touches
//
//  Created by 潇翔 汪 on 14-2-24.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "DynamicTouchesController.h"

@interface DynamicTouchesController ()<UIDynamicAnimatorDelegate>
@property (strong, nonatomic) UIDynamicAnimator* anim;
@property (strong, nonatomic) UIAttachmentBehavior* att;
@property (strong, nonatomic) NSMutableArray* atts;
@end

@implementation DynamicTouchesController

-(void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    NSLog(@"Pause");
}
-(void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator
{
    NSLog(@"Resume");
}

-(IBAction)panning:(UIPanGestureRecognizer*)g
{
    if (g.state == UIGestureRecognizerStateBegan) {
        self.anim = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
        self.anim.delegate = self;
        CGPoint loc = [g locationOfTouch:0 inView:g.view];
        CGPoint cen = CGPointMake(CGRectGetMidX(g.view.bounds), CGRectGetMidY(g.view.bounds));
        UIOffset off = UIOffsetMake(loc.x-cen.x, loc.y-cen.y);
        CGPoint anchor = [g locationOfTouch:0 inView:self.view];
        UIAttachmentBehavior* att = [[UIAttachmentBehavior alloc] initWithItem:g.view offsetFromCenter:off attachedToAnchor:anchor];
        [self.anim addBehavior:att];
        self.att = att;
    }
    else if (g.state == UIGestureRecognizerStateChanged) {
        self.att.anchorPoint = [g locationOfTouch:0 inView:self.view];
    }
    else {
        self.anim = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end
