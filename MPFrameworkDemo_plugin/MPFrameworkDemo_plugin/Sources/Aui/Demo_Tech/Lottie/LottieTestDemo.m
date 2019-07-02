//
//  LottieTestDemo.m
//  AntUIDemo
//
//  Created by 莜阳 on 2018/1/23.
//  Copyright © 2018年 Alipay. All rights reserved.
//

#import "LottieTestDemo.h"

@interface LottieTestDemoViewController()

@property (nonatomic, strong) LOTAnimationView *lottieView;

@end

@implementation LottieTestDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"lottie_demo2" ofType:@"json" inDirectory:@"APCommonUI_ForDemo.bundle"];
        self.lottieView = [LOTAnimationView animationWithFilePath:filePath];
        self.lottieView.width = self.lottieView.width / 2;
        self.lottieView.height = self.lottieView.height / 2;
        self.lottieView.origin = CGPointMake((self.view.width - self.lottieView.width)/2, self.topMargin + 10);
        [self.view addSubview:self.lottieView];
        self.topMargin += 10;
    }
    
    {
        AUButton *button1 = [AUButton buttonWithStyle:AUButtonStyle8 title:@"play" target:self action:@selector(playAnimation)];
        [button1 sizeToFit];
        button1.origin = CGPointMake(15, self.topMargin);
        [self.view addSubview:button1];
//        self.topMargin += 10;
    }
    
    {
        AUButton *button1 = [AUButton buttonWithStyle:AUButtonStyle8 title:@"stop" target:self action:@selector(stopAnimation)];
        [button1 sizeToFit];
        button1.origin = CGPointMake(self.view.width-button1.width-15, self.topMargin);
        [self.view addSubview:button1];
        self.topMargin += 10;
    }
    
}

- (void)playAnimation
{
    [self.lottieView play];
}

- (void)stopAnimation
{
    [self.lottieView stop];
}

- (void)viewWillAppear:(BOOL)animated
{
    //
}

@end
