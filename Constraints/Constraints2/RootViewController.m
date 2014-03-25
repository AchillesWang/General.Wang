//
//  RootViewController.m
//  Constraints2
//
//  Created by 潇翔 汪 on 14-3-4.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.lab1.translatesAutoresizingMaskIntoConstraints = NO;
    self.lab2.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary* d = NSDictionaryOfVariableBindings(_lab1,_lab2);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_lab1]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:d]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_lab2]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:d]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_lab1]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:d]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_lab2]-20-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:d]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_lab1]-(>=20)-[_lab2]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:d]];
    
    // we will be ambiguous when the label texts grow
    // one way to solve: different compression resistance priorities
    
    [self.lab1 setContentCompressionResistancePriority:751 forAxis:UILayoutConstraintAxisHorizontal];
    
    
    
    
    self.btn.translatesAutoresizingMaskIntoConstraints = NO;
    self.lab3.translatesAutoresizingMaskIntoConstraints = NO;
    
    d = NSDictionaryOfVariableBindings(_btn,_lab3);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_btn]-(400)-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:d]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=100)-[_lab3]-[_btn]-(>=10)-|"
                                                                      options:NSLayoutFormatAlignAllBaseline metrics:nil
                                                                        views:d]];
    NSLayoutConstraint* con =[NSLayoutConstraint constraintWithItem:_btn
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:0
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0];
    con.priority = 700; // try commenting this out to see the difference in behavior
    [self.view addConstraint:con];
}


- (IBAction)doWiden:(id)sender {
    self.lab1.text = [self.lab1.text stringByAppendingString:@"XXXX"];
    self.lab2.text = [self.lab1.text stringByAppendingString:@"XXXX"];
    self.lab3.text = [self.lab1.text stringByAppendingString:@"XXXX"];
}

@end
