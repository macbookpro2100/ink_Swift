//
//  ScreenBrightnessDemoViewController.m
//  AntUIDemo
//
//  Created by 莜阳 on 2018/3/5.
//  Copyright © 2018年 Alipay. All rights reserved.
//

#import "ScreenBrightnessDemoViewController.h"
#import <AntUI/UIViewController+AUBrightness.h>
#import "ScreenBrightness2DemoViewController.h"

@interface ScreenBrightnessDemoViewController ()

@end

@implementation ScreenBrightnessDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AUButton *button = [AUButton buttonWithStyle:AUButtonStyle1];
    button.origin = CGPointMake(15, self.topMargin + 20);
    [button setTitle:@"调亮屏幕亮度" forState:0];
    [button addTarget:self action:@selector(didClick1Button) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.topMargin = button.bottom + 10;
    
    AUButton *button1 = [AUButton buttonWithStyle:AUButtonStyle1];
    button1.origin = CGPointMake(15, self.topMargin + 20);
    [button1 setTitle:@"恢复屏幕亮度" forState:0];
    [button1 addTarget:self action:@selector(didClick2Button) forControlEvents:UIControlEventTouchUpInside];
    
    [self au_increaseBrightness];
    
    [self.view addSubview:button1];
}

- (void)didClick1Button
{
    [self au_increaseBrightness];
    
    [self performSelector:@selector(openNewPage) withObject:nil afterDelay:0.01f];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [self au_increaseBrightness];
//    [self performSelector:@selector(back) withObject:nil afterDelay:0.4];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)openNewPage
{
    ScreenBrightness2DemoViewController *vc = [[ScreenBrightness2DemoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didClick2Button
{
    [self au_decreaseBrightness];
}

//- (void)dealloc
//{
//    [self au_decreaseBrightness];
//}

@end
