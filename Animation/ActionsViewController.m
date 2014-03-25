//
//  ActionsViewController.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-17.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "ActionsViewController.h"
#import "ActionsLayer.h"


@interface ActionsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (assign,nonatomic) BOOL isSmilingFace;
@property (nonatomic, strong) CALayer* layer;
@end

@implementation ActionsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CALayer* layer = [ActionsLayer new];
    layer.frame           = CGRectMake(100, 50, 40, 40);
    [CATransaction setDisableActions:YES];
    layer.contents        = (id)[UIImage imageNamed:@"Mars"].CGImage;
    layer.contentsGravity = kCAGravityResizeAspectFill;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
}

- (IBAction)dismiss:(id)sender {
    [self dismissController];
}
- (IBAction)doAnimation:(id)sender {
    [self animtion];
}
-(void)animtion
{
    CALayer* layer = self.layer;
    
//    NSLog(@"layer:%@",[layer valueForKey:@"suppressPositionAnimation"]);
    switch ([self.textField.text integerValue]) {
        case 1:
        {
            layer.position = CGPointMake(200,100);
            break;
        }
        case 2:
        {
            [layer setValue:@YES forKey:@"suppressPositionAnimation"];
            layer.position = CGPointMake(200,100); // look Ma, no animation!
            break;
        }
        case 3:
        {
            CABasicAnimation* ba = [CABasicAnimation animation];
            ba.duration    = 5;
            layer.actions  = @{@"position": ba};
            layer.delegate = nil;
            CGPoint newP   = CGPointMake(200,100);
//            [CATransaction setAnimationDuration:1.5];  不知道什么用，？
            layer.position = newP;
            break;
        }
        case 4:
        {
            layer.delegate = self;
            CGPoint newp = CGPointMake(300, 300);
            [CATransaction setValue:[NSValue valueWithCGPoint:newp] forKey:@"newPoint"];
            [CATransaction setAnimationDuration:1.5];
            layer.position = newp;
            break;
        }
        case 5:
        {
            if (_isSmilingFace) {
                layer.contents = (id)[UIImage imageNamed:@"Mars"].CGImage;
            }else{
                layer.contents = (id)[UIImage imageNamed:@"Smiley"].CGImage;
            }
            _isSmilingFace = !_isSmilingFace;
            break;
        }
        case 6:
        {
            layer = [CALayer new];
            layer.frame = CGRectMake(200,50,40,40);
            layer.contentsGravity = kCAGravityResizeAspectFill;
            layer.contents = (id)[UIImage imageNamed:@"Smiley"].CGImage;
            layer.delegate = self;
            [self.view.layer addSublayer:layer];
            break;
        }
        case 7:
        {
            layer.delegate = self;
            [CATransaction setCompletionBlock:^{
                NSLog(@"remove");
                [layer removeFromSuperlayer];
            }];
            [CATransaction setValue:@"" forKey:@"byebye"];
            layer.opacity = 0;
            break;
        }
        default:
            break;
    }
}

-(id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    if ([event isEqualToString:@"position"]) {
        CGPoint oldP  = layer.position;
        CGPoint newP  = [[CATransaction valueForKey:@"newPoint"] CGPointValue];
        CGFloat d     = sqrt(pow(oldP.x-newP.x, 2)+pow(oldP.y-newP.y, 2));
        CGFloat r     = d/3.0;
        CGFloat theta = atan2(newP.y-oldP.y, newP.x-oldP.x);
        CGFloat wag   = 10*M_PI/180;
        CGPoint p1    = CGPointMake(oldP.x + r*cos(theta+wag),
                                             oldP.y + r*sin(theta+wag));
        CGPoint p2    = CGPointMake(oldP.x + r*2*cos(theta-wag),
                                 oldP.y + r*2*sin(theta-wag));
        CAKeyframeAnimation* anim = [CAKeyframeAnimation animation];
        anim.values = @[[NSValue valueWithCGPoint:oldP],
                        [NSValue valueWithCGPoint:p1],
                        [NSValue valueWithCGPoint:p2],
                        [NSValue valueWithCGPoint:newP]];
        anim.calculationMode = kCAAnimationCubic;
        return anim;
        
    }
    if ([event isEqualToString:kCAOnOrderIn]) {
        CABasicAnimation* anim1 =
        [CABasicAnimation animationWithKeyPath:@"opacity"];
        anim1.fromValue = @0.0f;
        anim1.toValue = @(layer.opacity);
        CABasicAnimation* anim2 =
        [CABasicAnimation animationWithKeyPath:@"transform"];
        anim2.toValue = [NSValue valueWithCATransform3D:
                         CATransform3DScale(layer.transform, 1.2, 1.2, 1.0)];
        anim2.autoreverses = YES;
        anim2.duration = 0.1;
        CAAnimationGroup* group = [CAAnimationGroup animation];
        group.animations = @[anim1, anim2];
        group.duration = 0.5;
        return group;
    }
    if ([event isEqualToString:@"opacity"]) {
        if ([CATransaction valueForKey:@"byebye"]) {
            CABasicAnimation* anim1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
            anim1.fromValue = @(layer.opacity);
            anim1.toValue = @0.0f;
            CABasicAnimation* anim2 = [CABasicAnimation animationWithKeyPath:@"transform"];
            anim2.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(layer.transform, 0.1, 0.1, 1.0)];
            
            CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
            animationGroup.animations = @[anim1,anim2];
            animationGroup.duration = 0.5f;
            return animationGroup;
        }
    };
    return nil;
}
- (IBAction)default:(id)sender {
    [self layerSetDefault];
}
-(void)layerSetDefault
{
    self.layer.delegate = nil;
    self.layer.position = CGPointMake(120,70);
    
}
@end
