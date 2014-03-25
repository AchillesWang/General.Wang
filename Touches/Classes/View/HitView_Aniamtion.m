//
//  HitView_Aniamtion.m
//  Touches
//
//  Created by 潇翔 汪 on 14-2-26.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "HitView_Aniamtion.h"


@interface HitView_Aniamtion ()
@property (weak, nonatomic) IBOutlet UIView *v;
@end

@implementation HitView_Aniamtion

- (void) awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer* t = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.v addGestureRecognizer:t];
    t.cancelsTouchesInView = NO;
    // uncomment next line to see how button, even if tappable, "swallows the touch" while animating
    // [self.v removeGestureRecognizer:t];
}
- (void) tap: (UIGestureRecognizer*) g {
    NSLog(@"tap! (gesture recognizer)");
}

- (UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // uncomment this next line to see what it's like without our munged hit-testing
    // return [super hitTest:point withEvent:event];
    // v is the animated subview
    CALayer* lay = [self.v.layer presentationLayer];
    CALayer* hitLayer = [lay hitTest: point];
    if (hitLayer == lay || hitLayer.superlayer == lay)
        return self.v;
    UIView* hitView = [super hitTest:point withEvent:event];
    if (hitView == self.v)
        return self;
    return hitView;
}


@end
