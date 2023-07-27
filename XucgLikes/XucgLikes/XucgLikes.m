//
//  XucgLikes.m
//  XucgLikes
//
//  Created by xucg on 5/25/16.
//  Copyright © 2016 xucg. All rights reserved.
//  Welcome visiting https://github.com/gukemanbu/XucgLikes

#import "XucgLikes.h"

@implementation XucgLikes

- (instancetype)init {
    self = [super init];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.frame = CGRectMake(0, 0, 33, 66);
        
        NSString *imageName = [NSString stringWithFormat:@"lm-girl-heart%u", arc4random() % 7];
        self.image = [UIImage imageNamed:imageName];
    }
    
    return self;
}

- (void)showInView:(UIView *)view atPosition:(CGPoint)position{
    
    CGRect frame = self.frame;
    frame.origin = position;
    self.frame = frame;
    [view addSubview:self];
    
    // 出现动画
    CABasicAnimation *showAnimation;
    showAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    showAnimation.duration = 0.6f;
    showAnimation.autoreverses = NO;
    showAnimation.removedOnCompletion = NO;
    showAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    showAnimation.toValue = [NSNumber numberWithFloat:1.0];
    [self.layer addAnimation:showAnimation forKey:@"popup"];
    
    // 飞行动画
    CAKeyframeAnimation *flyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    flyAnimation.delegate = (id<CAAnimationDelegate>)self;
    flyAnimation.beginTime = 0.f;
    flyAnimation.duration = xucgScreenWidth > xucgScreenHeight ? 3.f : 6.f;
    flyAnimation.removedOnCompletion = NO;
    flyAnimation.fillMode = kCAFillModeForwards;
    flyAnimation.repeatCount = 0;
    flyAnimation.calculationMode = kCAAnimationCubicPaced;
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, position.x, position.y);
    
    int right = arc4random_uniform(2);
    int down = arc4random_uniform(2);
    int tmpX = arc4random_uniform(100);
    int tmpY = arc4random_uniform(20);
    
    CGFloat ctrlX = position.x + (right? tmpX : -tmpX);
    CGFloat ctrlY = position.y*0.5 + (down? tmpY : -tmpY);
    
    CGPathAddQuadCurveToPoint(curvedPath, NULL, ctrlX, ctrlY, position.x, 0);
    flyAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    [self.layer addAnimation:flyAnimation forKey:@"fly"];
    
    // 渐变动画
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeInAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    fadeInAnimation.toValue = [NSNumber numberWithFloat:0.0];
    fadeInAnimation.additive = NO;
    fadeInAnimation.removedOnCompletion = NO;
    fadeInAnimation.beginTime = 0.f;
    fadeInAnimation.duration = 3.f;
    fadeInAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:fadeInAnimation forKey:@"fade"];
    
    // 缩小动画
    CABasicAnimation *disAnimation;
    disAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    disAnimation.beginTime = CACurrentMediaTime() + 2.5f;
    disAnimation.duration = 0.5f;
    disAnimation.autoreverses = NO;
    disAnimation.removedOnCompletion = NO;
    disAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    disAnimation.toValue = [NSNumber numberWithFloat:0.f];
    [self.layer addAnimation:disAnimation forKey:@"dismiss"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self removeFromSuperview];
}

@end
