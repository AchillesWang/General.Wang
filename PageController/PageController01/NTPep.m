//
//  NTPep.m
//  PageController01
//
//  Created by 潇翔 汪 on 14-3-24.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import "NTPep.h"

@interface NTPep ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation NTPep

-(id)initWithPepBoy:(NSString *)boy nib:(NSString *)nib bundle:(NSBundle *)bundle
{
    self = [self initWithNibName:nib bundle:bundle];
    if (self) {
        self->_boy = [boy copy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.label.text = self.boy;
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[self.boy lowercaseString]]];
}

- (NSString*) description {
    return self.boy;
}

@end
