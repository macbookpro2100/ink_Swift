//
//  DemoViewController.m
//  MPFrameworkDemo_plugin
//
//  Created by vivi.yw on 2019/03/28.
//  Copyright © 2019 macbookpro2100. All rights reserved.
//

#import "DemoViewController.h"
#import "MPFrameworkBizAService.h"
#import "MPNavigatorDemoVC.h"
#import "BSBacktraceLogger.h"
#import "DoraemonSandboxViewController.h"
#import "MatrixViewController.h"


@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"移动框架";

    CREATE_UI({
        BUTTON_WITH_ACTION(@"打开业务A", startAppBizA)
        BUTTON_WITH_ACTION(@"业务A提供的服务", startServiceBizA)
        BUTTON_WITH_ACTION(@"导航栏定制", showNavigator)
        BUTTON_WITH_ACTION(@"code2006", showAPMusic)
        BUTTON_WITH_ACTION(@"3秒卡顿监控", clickARN)
        BUTTON_WITH_ACTION(@"Matrix", clickMatrix)
        BUTTON_WITH_ACTION(@"文件夹", clickFilePath)
    })



//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            BSLOG_MAIN  // 打印主线程调用栈， BSLOG 打印当前线程，BSLOG_ALL 打印所有线程
//            // 调用 [BSBacktraceLogger bs_backtraceOfCurrentThread] 这一系列的方法可以获取字符串，然后选择上传服务器或者其他处理。
//        });
//        [self foo];

}


-(void)clickOpenSwift{

}
-(void)clickMatrix{
    MatrixViewController *vc =  [MatrixViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickFilePath{
    DoraemonSandboxViewController *vc =  [DoraemonSandboxViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)startAppBizA {
    [DTContextGet() startApplication:@"66600001" params:@{@"title": @"业务A", @"model": @{@"message": @"Message to biz A"}} animated:YES];
}

- (void)startServiceBizA {
    id <MPFrameworkBizAService> bizAService = [DTContextGet() findServiceByName:@"BizAService"];
    if (bizAService) {
        NSString *msg = [bizAService getWeatherForToday];
        AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:@"服务返回数据" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)showNavigator {
    MPNavigatorDemoVC *vc = [MPNavigatorDemoVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)showAPMusic {
    [DTContextGet() startApplication:@"20000002" params:@{} animated:YES];
}

- (void)clickARN {
    NSLog(@"3秒钟的卡顿");
    [NSThread sleepForTimeInterval:3.01];
}


- (void)foo {
    [self bar];
}

- (void)bar {
    while (true) {;
    }
}


@end
