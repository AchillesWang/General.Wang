//
//  CustomAnimatableProperty.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-17.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "CustomAnimatableProperty.h"
#import "CustomAnimatableView.h"

@interface CustomAnimatableProperty ()
@property (weak, nonatomic) IBOutlet CustomAnimatableView *caView;

@end

@implementation CustomAnimatableProperty

- (IBAction)doAnimation:(id)sender {
    CALayer* lay = self.caView.layer;
    CABasicAnimation* ba = [CABasicAnimation animationWithKeyPath:@"thickness"];
    ba.toValue = [NSNumber numberWithFloat:10.0f];
    ba.autoreverses = YES;
    [lay addAnimation:ba forKey:nil];
    
}

- (IBAction)dismiss:(id)sender {
    [self dismissController];
}


@end
