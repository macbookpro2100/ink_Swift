//
//  CustomNaviBarDemoViewController.m
//  AntUI
//
//  Created by 莜阳 on 2017/9/1.
//  Copyright © 2017年 Alipay. All rights reserved.
//

#import "CustomNaviBarDemoViewController.h"

@implementation CustomNaviBarDemoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AUCustomNavigationBar *customBar = [AUCustomNavigationBar navigationBarForCurrentVC:self];
//    customBar.rightItemTitle = @"设置";
    UIImage *img = [[AUIconView alloc] initWithFrame:CGRectMake(0, 0, 22, 22) name:kICONFONT_USER_SETTING].image;
    customBar.rightItemImage = img;
    customBar.title = @"自定义导航栏sjajshjahjshdjahjdahsjs";
    [customBar setNavigationBarBlurEffective];
    customBar.backgroundView.alpha = 1.f;
    
    customBar.rightItem.aubadgeNumber = @".";
    
    [customBar startTitleLoading];
    [customBar resetNaviBarLeftItemTarget:self action:@selector(back)];
    
    [self performSelector:@selector(updateBadgeValue:) withObject:customBar afterDelay:2.0];
    [self performSelector:@selector(updateBadgeValue1:) withObject:customBar afterDelay:4.0];
    
    [self.view addSubview:customBar];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateBadgeValue:(AUCustomNavigationBar *)naviBar
{
    naviBar.rightItem.aubadgeNumber = nil;
}

- (void)updateBadgeValue1:(AUCustomNavigationBar *)naviBar
{
    naviBar.rightItem.aubadgeNumber = @"new";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

@end
