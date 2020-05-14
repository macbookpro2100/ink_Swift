//
//  MPLauncherAppDelegate.m
//  MPFrameworkDemo_plugin
//
//  Created by vivi.yw on 2019/03/28.
//  Copyright © 2019 ORGNIZATION_NAME. All rights reserved.
//

#import <DoraemonKit/DoraemonManager.h>
#import <DoraemonKit/DoraemonTimeProfiler.h>
#import <DoraemonKit/DoraemonLoadAnalyze.h>
#import <DoraemonKit/DoraemonDefine.h>
#import <DoraemonKit/DoraemonCPUUtil.h>
#import <DoraemonKit/DoraemonMemoryUtil.h>
#import "MPLauncherAppDelegate.h"
#import "MPTabBarViewController.h"


//#import "MatrixHandler.h"
//typedef void (^DoraemonANRBlock)(NSDictionary *);
#import "ForbiddenScreenShotMarkView.h"
#import "MPFrameworkDemo_plugin-Swift.h"


@interface MPLauncherAppDelegate ()
//每秒运行一次
@property(nonatomic, strong) NSTimer *secondTimer;
//@property(nonatomic, copy) DoraemonANRBlock anrBlock;

@property(nonatomic, strong) MPTabBarViewController *rootVC;

@property(nonatomic, strong) ForbiddenScreenShotMarkView *markView;

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


    // 隐藏 root Nav
    DTNavigationController *cn = (DTNavigationController *) [DTMicroApplicationGetCurrent() rootController].navigationController;
    [cn setNavigationBarHidden:YES];


    // 打开ANR 监控
    [DoraemonTimeProfiler startRecord];

    //[[self class] handleCCrashReportWrap];
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);

    for (int i = 0; i < 10; i++) {
        //DDLogInfo(@"点击添加埋点11111");
    }
    [[DoraemonManager shareInstance] addPluginWithTitle:DoraemonLocalizedString(@"测试插件") icon:@"doraemon_default" desc:DoraemonLocalizedString(@"测试插件") pluginName:@"TestPlugin" atModule:DoraemonLocalizedString(@"业务工具")];

    [[DoraemonManager shareInstance] addPluginWithTitle:@"block方式加入插件" icon:@"doraemon_default" desc:@"测试插件" pluginName:@"TestPlugin" atModule:DoraemonLocalizedString(@"业务工具") handle:^(NSDictionary *itemData) {
        NSLog(@"handle block plugin");
    }];

    [[DoraemonManager shareInstance] addStartPlugin:@"StartPlugin"];
    [DoraemonManager shareInstance].bigImageDetectionSize = 10 * 1024;//大图检测只检测10K以上的
    [DoraemonManager shareInstance].startClass = @"DoKitAppDelegate";
    [[DoraemonManager shareInstance] install];
    //[[DoraemonManager shareInstance] installWithStartingPosition:CGPointMake(66, 66)];

    [[DoraemonManager shareInstance] addANRBlock:^(NSDictionary *anrDic) {
        NSLog(@"anrDic == %@", anrDic);
    }];

    //    [[DoraemonManager shareInstance] addH5DoorBlock:^(NSString *h5Url) {
    //        NSLog(@"使用自带容器打开H5链接: %@",h5Url);
    //    }];
    // 例子：移除 GPS Mock
    //    [[DoraemonManager shareInstance] installWithCustomBlock:^{
    //        [[DoraemonManager shareInstance] removePluginWithPluginName:@"DoraemonGPSPlugin" atModule:@"常用工具"];
    //    }];



    NSArray *array = @[];
    NSLog(@"%@", [array description]);

    [DoraemonTimeProfiler stopRecord];

    [self addScreenShotMarkView];


}


- (void)addScreenShotMarkView {
    UIWindow *wind = [DTContextGet() window];
    self.markView = [wind viewWithTag:201987];
    if (!self.markView) {
        self.markView = [[ForbiddenScreenShotMarkView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.markView.tag = 201987;
    }
    if (!self.markView.superview) {
        [wind addSubview:self.markView];
    } else {
        // 保证切换账号后，ssMarkView在视图层最前端
        [wind bringSubviewToFront:self.markView];

    }
}

- (void)sendMarkViewToBack {
    UIWindow *wind = [DTContextGet() window];
    self.markView = [wind viewWithTag:kDemoWartMarkttag];
    if (!self.markView) {
        self.markView = [[ForbiddenScreenShotMarkView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.markView.tag = kDemoWartMarkttag;
    }
    [wind sendSubviewToBack:self.markView];
}

- (void)bringMarkViewToFront {
    UIWindow *wind = [DTContextGet() window];
    self.markView = [wind viewWithTag:kDemoWartMarkttag];
    if (!self.markView) {
        self.markView = [[ForbiddenScreenShotMarkView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.markView.tag = kDemoWartMarkttag;
    }
    [wind bringSubviewToFront:self.markView];
}

- (void)removeScreenShotMarkView {
    UIWindow *wind = [DTContextGet() window];
    self.markView = [wind viewWithTag:kDemoWartMarkttag];
    if (self.markView) {
        [self.markView removeFromSuperview];
    }
}


void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    // Internal error reporting
}

+ (void)handleCCrashReportWrap {
//    PLCrashReporterConfig *config = [[PLCrashReporterConfig alloc] initWithSignalHandlerType: PLCrashReporterSignalHandlerTypeMach symbolicationStrategy: PLCrashReporterSymbolicationStrategyAll];
//    PLCrashReporter *crashReporter = [[PLCrashReporter alloc] initWithConfiguration:config];
//
//    NSError *error;
//
//    // Check if we previously crashed
//    if ([crashReporter hasPendingCrashReport])
//        [self handleCCrashReport:crashReporter ];
//
//    // Enable the Crash Reporter
//    if (![crashReporter enableCrashReporterAndReturnError: &error])
//        NSLog(@"Warning: Could not enable crash reporter: %@", error);
}

- (void)application:(DTMicroApplication *)application willResumeWithOptions:(NSDictionary *)launchOptions {
    [self bringMarkViewToFront];
}

- (void)application:(DTMicroApplication *)application willStartLaunchingWithOptions:(NSDictionary *)options {

#if DEBUG
//    [[MatrixHandler sharedInstance] installMatrix];
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
