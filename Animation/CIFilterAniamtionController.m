//
//  CIFilterAniamtionController.m
//  Animation
//
//  Created by 潇翔 汪 on 14-2-18.
//  Copyright (c) 2014年 xiaoxiang.Wang. All rights reserved.
//

#import "CIFilterAniamtionController.h"

@interface CIFilterAniamtionController ()
@property (weak, nonatomic) IBOutlet UIView *v;

@end

#define SCALE 0.3

@implementation CIFilterAniamtionController
{
    CIFilter*       _tran;
    CGRect          _moiextent;
    double          _frame;
    CFTimeInterval  _timestamp;
    CIContext*      _con;
}


- (IBAction)doAniamtion:(id)sender {
    UIImage* lzl  = [UIImage imageNamed:@"lzl.jpg"];
    CIImage* lzl2 = [[CIImage alloc] initWithCGImage:lzl.CGImage];
    self->_moiextent = lzl2.extent;
    CIFilter* col  = [CIFilter filterWithName:@"CIConstantColorGenerator"];
    CIColor* cicol = [[CIColor alloc] initWithColor:[UIColor redColor]];
    [col setValue:cicol forKey:@"inputColor"];
    CIImage* colorImage = [col valueForKey:@"outputImage"];
    CIFilter* tran      = [CIFilter filterWithName:@"CIFlashTransition"];
    [tran setValue:colorImage
            forKey:@"inputImage"];
    [tran setValue:lzl2
            forKey:@"inputTargetImage"];
    CIVector* center = [CIVector vectorWithX:self->_moiextent.size.width/2.0
                                           Y:self->_moiextent.size.height/2.0];
    [tran setValue:center forKey:@"inputCenter"];
    self->_con       = [CIContext contextWithOptions:nil];
    self->_tran      = tran;
    self->_timestamp = 0.0f;
    dispatch_async(dispatch_get_main_queue(), ^{
        CADisplayLink* link = [CADisplayLink displayLinkWithTarget:self selector:@selector(nextFrame:)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    });
    
    
}
-(void) nextFrame:(CADisplayLink*)sender
{
    if (self->_timestamp<0.01) {
        self->_timestamp = sender.timestamp;
        self->_frame     = 0.0;
    }else{
        self->_frame = (sender.timestamp - self->_timestamp) * SCALE;
    }
    
    sender.paused = YES;
    
    [_tran setValue:@(self->_frame) forKey:@"inputTime"];
    CGImageRef moi = [self->_con createCGImage:_tran.outputImage
                                      fromRect:_moiextent];
    [CATransaction setDisableActions:YES];
    self.v.layer.contents = (__bridge id)moi;
    CGImageRelease(moi);
    
    if (_frame>1.0) {
        NSLog(@"%@",@"invalidate");
        [sender invalidate];
    }
    sender.paused = NO;
    NSLog(@"here %f",self->_frame);
}
- (IBAction)dismiss:(id)sender {
    [self dismissController];
}

@end
