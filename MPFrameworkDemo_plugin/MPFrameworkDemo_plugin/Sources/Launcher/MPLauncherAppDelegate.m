//
//  MPLauncherAppDelegate.m
//  MPFrameworkDemo_plugin
//
//  Created by vivi.yw on 2019/03/28.
//  Copyright © 2019 ORGNIZATION_NAME. All rights reserved.
//

#import "MPLauncherAppDelegate.h"
#import "MPTabBarViewController.h"
#import "DoraemonLoadAnalyze.h"
#import "DoraemonCPUUtil.h"
#import "DoraemonMemoryUtil.h"
#import "DoraemonANRManager.h"
#import "BSBacktraceLogger.h"

#import "MatrixHandler.h"
//typedef void (^DoraemonANRBlock)(NSDictionary *);

#import "MPFrameworkDemo_plugin-Swift.h"

@interface MPLauncherAppDelegate ()
//每秒运行一次
@property(nonatomic, strong) NSTimer *secondTimer;
//@property(nonatomic, copy) DoraemonANRBlock anrBlock;

@property(nonatomic, strong) MPTabBarViewController *rootVC;

@end

@implementation MPLauncherAppDelegate

- (id)init {
    printLoadAnalyzeInfo();
    self = [super init];
    if (self) {
        NSArray *baseImgs = [NSArray arrayWithObjects:
                @"TabBar_HomeBar",
                @"TabBar_Discovery",
                @"TabBar_PublicService",
                @"TabBar_Friends", nil];
        NSArray *selectImgs = [NSArray arrayWithObjects:
                @"TabBar_HomeBar_Sel",
                @"TabBar_Discovery_Sel",
                @"TabBar_PublicService_Sel",
                @"TabBar_Friends_Sel", nil];

        UIViewController *tab1ViewController = (UIViewController *) [self createLoggingViewController:@"DemoViewController"];
        UIViewController *tab2ViewController = (UIViewController *) [self createLoggingViewController:@"ComponentViewController"];

        UIViewController *tab3ViewController = (UIViewController *) [self createLoggingViewController:@"DemoComponentViewController"];

        SwiftMainViewController *tab4ViewController = [SwiftMainViewController new];



        NSArray *navArray = @[tab1ViewController, tab2ViewController, tab3ViewController, tab4ViewController];
        NSArray *titles = @[@"Tab1", @"Tab2", @"Tab3", @"Swift"];
        for (int i = 0; i < [navArray count]; i++) {
            UIImage *bImg = [UIImage imageNamed:baseImgs[i]];
            UIImage *selectImg = [UIImage imageNamed:selectImgs[i]];

            UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titles[i] image:bImg selectedImage:selectImg];
            item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.tag = i;
            [(UIViewController *) navArray[i] setTabBarItem:item];
            ((UIViewController *) navArray[i]).title = titles[i];
        }

        self.rootVC = [[MPTabBarViewController alloc] init];
        self.rootVC.viewControllers = navArray;
        self.rootVC.selectedIndex = 0;
        [self.rootVC.delegate tabBarController:self.rootVC didSelectViewController:tab1ViewController];
    }
    return self;
}

- (id)createLoggingViewController:(NSString *)className {
    id vc;
    Class cl = NSClassFromString(className);
    if (cl != Nil) {
        vc = [[cl alloc] init];
    } else {
        vc = (DTViewController *) [[DTViewController alloc] init];
    }
    return vc;
}


- (UIViewController *)rootControllerInApplication:(DTMicroApplication *)application {
    return self.rootVC;
}

- (void)applicationDidFinishLaunching:(DTMicroApplication *)application {
    // 打开ANR 监控
    [DoraemonANRManager sharedInstance].anrTrackOn = YES;
    [[DoraemonANRManager sharedInstance] start];
    [[DoraemonANRManager sharedInstance] addANRBlock:^(NSDictionary *anrInfo) {
        NSLog(@"😱😱😱 anrDic == %@",anrInfo);
    }];
//    [self startRecord];
    
}

- (void)application:(DTMicroApplication *)application willResumeWithOptions:(NSDictionary *)launchOptions {

}

- (void)application:(DTMicroApplication *)application willStartLaunchingWithOptions:(NSDictionary *)options {
    
#if DEBUG
    [[MatrixHandler sharedInstance] installMatrix];
#endif
    
}


- (void)startRecord {
    if (!_secondTimer) {
        _secondTimer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(doSecondFunction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_secondTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)endRecord {
    if (_secondTimer) {
        [_secondTimer invalidate];
        _secondTimer = nil;

    }
}

//每一秒钟采样一次cpu Memory使用率
- (void)doSecondFunction {
    CGFloat cpuUsage = [DoraemonCPUUtil cpuUsageForApp];
    if (cpuUsage * 100 > 100) {
        cpuUsage = 100;
    } else {
        cpuUsage = cpuUsage * 100;
    }
    // 0~100   对应 高度0~_oscillogramView.doraemon_height
    //    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];


    NSUInteger useMemoryForApp = [DoraemonMemoryUtil useMemoryForApp];
//    NSUInteger totalMemoryForDevice = [DoraemonMemoryUtil totalMemoryForDevice];

    NSLog(@"✅cpuUsage :%.2f%%  👣useMemoryForApp:%d MB", cpuUsage, useMemoryForApp);

}



@end
