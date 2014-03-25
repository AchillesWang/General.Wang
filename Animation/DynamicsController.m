//
//  DynamicsController.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-18.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "DynamicsController.h"

@interface DynamicsController ()<UIDynamicAnimatorDelegate,UICollisionBehaviorDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**
 *  力学动画
 */
@property (strong,nonatomic) UIDynamicAnimator* anim;
@end

@implementation DynamicsController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.anim = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.anim.delegate = self;
}


-(void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    NSLog(@"Pause");
}
-(void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator
{
    NSLog(@"Resume");
}


- (IBAction)doAniamtion:(id)sender {
    [(UIButton*)sender setEnabled:NO];
    //重力
    UIGravityBehavior* grav = [UIGravityBehavior new];
    grav.action = ^{
        NSArray* items = [self.anim itemsInRect:self.view.bounds];
        if (NSNotFound == [items indexOfObject:self.imageView]) {
            [self.anim removeAllBehaviors];
            [self.imageView removeFromSuperview];
            NSLog(@"Done");
        }
    };
    [self.anim addBehavior:grav];
    [grav addItem:self.imageView];
    
    UIPushBehavior* push = [[UIPushBehavior alloc] initWithItems:@[self.imageView]
                                                            mode:UIPushBehaviorModeInstantaneous];
    push.pushDirection = CGVectorMake(0.6, 0);
    [self.anim addBehavior:push];
    UICollisionBehavior* coll = [UICollisionBehavior new];
    coll.collisionMode = UICollisionBehaviorModeBoundaries;
    coll.collisionDelegate = self;
    [coll addBoundaryWithIdentifier:@"floor"
                          fromPoint:CGPointMake(0,self.view.bounds.size.height)
                            toPoint:CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.anim addBehavior:coll];
    [coll addItem:self.imageView];
    
    UIDynamicItemBehavior* bounce = [UIDynamicItemBehavior new];
    bounce.elasticity = 0.4;
    [self.anim addBehavior:bounce];
    [bounce addItem:self.imageView];
    
}
-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    NSLog(@"%@",NSStringFromCGPoint(p));
    for (UIDynamicBehavior* b in self.anim.behaviors) {
        if ([b isKindOfClass:[UIDynamicItemBehavior class]]) {
            UIDynamicItemBehavior* bounce = (UIDynamicItemBehavior*) b;
            CGFloat v = [bounce angularVelocityForItem:self.imageView];
            NSLog(@"%f",v);
            if (v<=0.1) {
                NSLog(@"adding angular velocity");
                [bounce addAngularVelocity:30 forItem:self.imageView];
            }
            break;
        }
    }
}
- (IBAction)dismiss:(id)sender {
    [self dismissController];
}

@end
