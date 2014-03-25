//
//  NTPep.h
//  PageController01
//
//  Created by 潇翔 汪 on 14-3-24.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTPep : UIViewController

- (id) initWithPepBoy: (NSString*) boy nib: (NSString*) nib bundle: (NSBundle*) bundle;

@property (nonatomic, copy) NSString* boy;

@end
