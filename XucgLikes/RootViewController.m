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

    self.view.backgroundColor = [UIColor whiteColor];
    
    _xucgLikes = [[XucgLikes alloc] init];
    _xucgLikes.frame = self.view.bounds;
    [self.view addSubview:_xucgLikes];
    
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
    [_xucgLikes popOneLike];
}

@end
