//
//  AViewController.h
//  Animation
//
//  Created by 潇翔 汪 on 14-2-11.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TBaseViewControllerDelegate <NSObject>

-(void)backup:(id)content fromController:(UIViewController*)controller;

@end

@interface TBaseViewController : UIViewController

@property (nonatomic,weak) id<TBaseViewControllerDelegate> aDelegate;

-(void)dismissController;

@end
