//
//  XucgLikes.m
//  XucgLikes
//
//  Created by xucg on 5/25/16.
//  Copyright © 2016 xucg. All rights reserved.
//  Welcome visiting https://github.com/gukemanbu/XucgLikes

#import "XucgLikes.h"

@interface XucgLikes ()

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSMutableArray *heartArray;

@end

@implementation XucgLikes

-(instancetype) init {
    self = [super init];
    if (self) {
        _heartArray = [NSMutableArray array];
    }
    
    return self;
}

-(void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    _width = frame.size.width;
    _height = frame.size.height;
}

-(void) popOneLike {
    NSString *imageName = [NSString stringWithFormat:@"lm-girl-heart%u", arc4random() % 7];
    UIImage *heartImage = [UIImage imageNamed:imageName];
    UIImageView* heartView = [[UIImageView alloc] initWithImage:heartImage];
    [_heartArray addObject:heartView];
    
    // 大小 可以变化 scale = 1.0 / (arc4random() % 10) + 0.7;
    double scale = 1.0;
    
    CGFloat newHeartWidth = heartImage.size.width * scale;
    CGFloat newHeartHeight = heartImage.size.height * scale;
    
    // 心的起始位置
    int startX = _width / 2;
    int startY = _height - newHeartHeight;
    
    heartView.frame = CGRectMake(startX, startY, newHeartWidth, newHeartHeight);
    [self addSubview:heartView];
    
    // 出现动画
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimation.duration = 0.1;
    theAnimation.removedOnCompletion = YES;
    theAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    theAnimation.toValue = [NSNumber numberWithFloat:1.0];
    [heartView.layer addAnimation:theAnimation forKey:@"popup"];
    
    // 飞行动画
    CAKeyframeAnimation *flyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    flyAnimation.delegate = self;
    flyAnimation.beginTime = 0.f;
    flyAnimation.duration = 3.f;
    flyAnimation.removedOnCompletion = NO;
    flyAnimation.fillMode = kCAFillModeForwards;
    flyAnimation.repeatCount = 0;
    flyAnimation.calculationMode = kCAAnimationCubicPaced;
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, startX, startY);
    
    int tmpX = arc4random() % (int)(_width + _width / 2);
    CGFloat ctrlX = tmpX % 2 == 0 ? _width / 2 + tmpX : _width / 2 - tmpX;
    CGFloat ctrlY = _height / 4 + arc4random() % (int)(_height / 2);
    int endX = arc4random() % (int)_width;
    CGPathAddQuadCurveToPoint(curvedPath, NULL, ctrlX, ctrlY, endX, 0);
    flyAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    [heartView.layer addAnimation:flyAnimation forKey:@"fly"];
    
    // 消逝动画
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeInAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    fadeInAnimation.toValue = [NSNumber numberWithFloat:0.0];
    fadeInAnimation.additive = NO;
    fadeInAnimation.removedOnCompletion = NO;
    fadeInAnimation.beginTime = 0.f;
    fadeInAnimation.duration = 3.;
    fadeInAnimation.fillMode = kCAFillModeForwards;
    [heartView.layer addAnimation:fadeInAnimation forKey:@"dismiss"];
}

-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [_heartArray[0] removeFromSuperview];
    [_heartArray removeObjectAtIndex:0];
}

@end