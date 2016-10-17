//
//  RootViewController.m
//  XucgLikes
//
//  Created by xucg on 5/25/16.
//  Copyright © 2016 xucg. All rights reserved.
//

#import "RootViewController.h"
#import "XucgLikes.h"

@interface RootViewController ()

@property (nonatomic, strong) XucgLikes *xucgLikes;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"请点击屏幕";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // tap手势
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
    // NO表示当前控件响应后会传播到其他控件上，默认为YES
    tapGestureRecognizer.cancelsTouchesInView = NO;
    tapGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    [self.view addGestureRecognizer:tapGestureRecognizer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) tapGestureHandler:(UITapGestureRecognizer*)tap{
    XucgLikes *flyHeart = [[XucgLikes alloc] init];
    CGPoint likeOrigin = CGPointMake(xucgScreenWidth/2, xucgScreenHeight - 42);
    [flyHeart showInView:self.view atPosition:likeOrigin];
}

@end
