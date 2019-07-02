//
//  ViewController.m
//  MPAntUIDemo_plugin
//
//  Created by yangwei on 2019/3/28.
//  Copyright © 2019年 yangwei. All rights reserved.
//

#import "ComponentViewController.h"
#import "MPAntUIDemoDef.h"
#import "MPBannerVC.h"
#import "MPPullRefreshVC.h"
#import "MPSearchBarVC.h"
#import "MPDatePickerVC.h"
//#import <NebulaSDK/NebulaSDK.h>

#import "MPDataCenterTestCase.h"


@interface ComponentViewController ()

@end

@implementation ComponentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"AntUIDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *models = [[NSMutableArray alloc] init];
    
    DemoFunctionListModel *model = [[DemoFunctionListModel alloc] init];
    model.title = @"轮播图";
    model.target = self;
    model.selector = @selector(showBanner);
    [models addObject:model];
    
    
    
    model = [[DemoFunctionListModel alloc] init];
    model.title = @"上拉和下拉刷新";
    model.target = self;
    model.selector = @selector(showPullRefresh);
    [models addObject:model];
    
    model = [[DemoFunctionListModel alloc] init];
    model.title = @"搜索框";
    model.target = self;
    model.selector = @selector(showSearchBar);
    [models addObject:model];
    
    model = [[DemoFunctionListModel alloc] init];
    model.title = @"日期选择";
    model.target = self;
    model.selector = @selector(showDatePicker);
    [models addObject:model];
    
    
    model = [[DemoFunctionListModel alloc] init];
    model.title = @"KV 存储";
    model.target = self;
    model.selector = @selector(kvStorage);
    [models addObject:model];
    
    
    model = [[DemoFunctionListModel alloc] init];
    model.title = @"LRU 存储";
    model.target = self;
    model.selector = @selector(lruStorage);
    [models addObject:model];
    
    
    
    
    
     self.functionList = [NSArray arrayWithArray:models];
    
    
 
    
}
-(void)open4{
    
}


- (void)kvStorage
{
    [MPDataCenterTestCase runKVStorageTest];
}

- (void)lruStorage
{
    [MPDataCenterTestCase runLRUTest];
}



- (void)showBanner {
    MPBannerVC *vc = [MPBannerVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showPullRefresh {
    MPPullRefreshVC *vc = [MPPullRefreshVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showSearchBar {
    MPSearchBarVC *vc = [MPSearchBarVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showDatePicker {
    MPDatePickerVC *vc = [MPDatePickerVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)showTinyApp {
   
    
//    NSString *appID = @"2018080616290001";
//    //    [DTContextGet() startApplication:appID params:@{@"appId":appID,@"debug":@"framework"} animated:YES];
//    [[NBServiceGet() appCenter] prepareApp:appID version:nil process:^(NAMAppPrepareStep step, id info) {
//
//    } finish:^(NAMApp *app, NSError *error) {
//        if (!error) {
//            // 打开应用, 需切至主线程
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [NBServiceGet() startSession:@{@"appId":app.app_id, @"version":app.version, @"debug":@"framework"} animated:YES];
//            });
//        }
//    }];
//
}


@end
