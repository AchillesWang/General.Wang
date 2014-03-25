//
//  AViewController.h
//  Animation
//
//  Created by 潇翔 汪 on 14-2-11.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AViewControllerDelegate <NSObject>

-(void)backup:(id)content fromController:(UIViewController*)controller;

@end

@interface AViewController : UIViewController

@property (nonatomic,weak) id<AViewControllerDelegate> aDelegate;

-(void)dismissController;

@end
