//
//  DemoBasicViewController.m
//  AntUI
//
//  Created by 莜阳 on 2017/7/27.
//  Copyright © 2017年 Alipay. All rights reserved.
//

#import "DemoComponentViewController.h"

@implementation DemoComponentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"  %@  :viewDidLoad", NSStringFromClass([self class]));
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 数据列表，说明：AU_DEMO(类别名称, 条目列表, 类别logo路径)
    AU_DEMO(@"导航",
            (@{
               @"NavBar" : @"NavigationBarDemoViewController",
               @"TabBar" : @"DemoTabBarViewController",
               @"Segment" : @"SegmentHomeDemoViewController"
               }),
            @"home_navigation");
    
    AU_DEMO(@"搜索",
            (@{@"SearchBar" : @"SearchHomeDemoViewController"}),
            @"home_search");
    
    AU_DEMO(@"基础组件",
            (@{
               @"Font" : @"FontDemoViewController",
               @"Article" : @"",
               @"Badge" : @"BadgeDemoViewController",
               @"IconFont" : @"DemoIconFontViewController",//@"DemoIconFontViewController",//@"IconfontDemoViewController",
               @"Load" : @"LoadDemoViewController",
               @"Button" : @"ButtonDemoViewViewController",
               @"Carousel" :
                   //                   @"DemoAUBannerViewViewController",
               @"CarouselDemoViewController",
               @"Lists" : @"ListDemoViewController",
               @"Footer" : @"FooterDemoViewController",
               @"Result" : @"ResultViewController",
//               @"LargeResult" : @"AULargeResultViewDemoViewController",
               @"Screening" : @"",
               @"KeyBoards" : @"KeyboardsDemoViewController",
               @"Color" : @"ColorDemoViewController",
               @"LoadIndicator" : @"LoadIndicatorDemoViewController",
//               @"agreement" : @"DemoAgreementViewViewController",
               @"AUBladeView": @"bladeViewController"
               }),
            
            @"home_base");
    
    AU_DEMO(@"表单",
            (@{
               @"checkBox" : @"CheckboxDemoViewCotroller",
               @"Radio" : @"RadioDemoViewController",
               
               @"Input" :
                   @"InputDemoViewController",
//               @"DemoAUInputBoxViewController",
               @"Picker" : @"PickerDemoViewController", // @"APPickerViewViewController", //
               @"Switch" : @"SwitchDemoViewViewController", // @"ListItemsViewController", //
               
               @"TextArea" : @"TextareaDemoViewController"
               }),
            @"home_form");
    
    AU_DEMO(@"操作反馈",
            (@{
               @"Actionsheet" : @"ActionSheetDemoViewController",
               @"Dialog" : @"DialogDemoViewController",
               @"Toast" : @"ToastDemoViewController",
               @"PopOver" : @"PopoverDemoViewController",
               @"PopTip" : @"PopTipDemoViewController",
//               @"FilterMenu" : @"DemoFilterMenuViewController"
               }),
            @"home_feedback");
    
    AU_DEMO(@"底层规则",
            (@{
               @"Flex" : @"",
               @"Layer" : @""
               }),
            @"home_layout");
    
    
    
    
    
    
    
    // 数据列表，说明：AU_DEMO(类别名称, 条目列表, 类别logo路径)
    AU_DEMO(@"界面",
            (@{
               @"异常空白页" : @"DemoNetErrorViewController",
               @"资金输入" : @"",
               @"二维码" : @"DemoAUQRCodeViewController",
               @"下拉刷新" : @"AURefreshViewDemoViewController",
               @"下拉刷新2" : @"AURefreshViewDemoViewControllerTest",
               @"上拉加载更多" : @"DemoDragLoadingViewController",
               @"全屏加载页" : @"DemoEmptyLoadingViewController",
               //               @"底部button" : @"",
               @"横向滚动式选择列表" : @"",
               @"屏幕亮度调节" : @"ScreenBrightnessDemoViewController"
               }),
            @"home_Interface");
    
    AU_DEMO(@"媒体",
            (@{
               @"图片上传" : @"",
               @"选择文件" : @"",
               @"视频" : @"",
               @"录音" : @"RecordFloatTipDemoViewController"
               }),
            @"home_media");
    
    AU_DEMO(@"换肤",
            (@{
               @"动态换肤" : @"DemoNewChangeSkinViewController"
               }),
            @"home_skin");
    AU_DEMO(@"Lottie Demo",
            (@{
               @"demo1" : @"LottieTestDemoViewController"
               }),
            @"home_skin");
    
}

@end
