//
//  XucgLikes.h
//  XucgLikes
//
//  Created by xucg on 5/25/16.
//  Copyright © 2016 xucg. All rights reserved.
//  Welcome visiting https://github.com/gukemanbu/XucgLikes

#import <UIKit/UIKit.h>

#define xucgScreenWidth  [UIScreen mainScreen].bounds.size.width   // 当前屏幕宽
#define xucgScreenHeight [UIScreen mainScreen].bounds.size.height  // 当前屏幕高

@interface XucgLikes : UIImageView

-(void)showInView:(UIView *)view atPosition:(CGPoint)position;

@end
