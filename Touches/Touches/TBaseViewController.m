//
//  AViewController.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-11.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "TBaseViewController.h"

@interface TBaseViewController ()

@end

@implementation TBaseViewController

-(void)dismissController
{
    if (self.aDelegate&&[self.aDelegate respondsToSelector:@selector(backup:fromController:)]) {
        [self.aDelegate backup:nil fromController:self];
    }
}

@end
