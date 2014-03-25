//
//  UIView+BType.h
//  Animation
//
//  Created by 潇翔 汪 on 14-2-11.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BType)

typedef void (^BTypeAnimations)(void);
typedef void (^BTypeCompletion)(BOOL finished);

@end
