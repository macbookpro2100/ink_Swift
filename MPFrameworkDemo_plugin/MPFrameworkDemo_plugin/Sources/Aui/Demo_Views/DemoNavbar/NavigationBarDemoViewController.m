//
//  DemoNavigationBarViewController.m
//  AntUI
//
//  Created by 莜阳 on 2017/8/15.
//  Copyright © 2017年 Alipay. All rights reserved.
//

#import "NavigationBarDemoViewController.h"
#import "MainTitleBarDemoViewController.h"
 

#define KDemoViewTag    10987

@implementation NavigationBarDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat topMargin = self.headerView.bottom;
    NSInteger tag = KDemoViewTag + 1;
    
    {
        AUButton *button1 = [self createButtonWithTitle:@"主标题导航"];
        button1.origin = CGPointMake(kDemoGlobalMargin, topMargin);
        button1.tag = tag++;
        [self.view addSubview:button1];
        topMargin = button1.bottom + 10;
    }
    
    {
        AUButton *button1 = [self createButtonWithTitle:@"主副标题导航"];
        button1.origin = CGPointMake(kDemoGlobalMargin, topMargin);
        button1.tag = tag++;
        [self.view addSubview:button1];
        topMargin = button1.bottom + 10;
    }
    
    {
        AUButton *button1 = [self createButtonWithTitle:@"自定义导航栏"];
        button1.origin = CGPointMake(kDemoGlobalMargin, topMargin);
        button1.tag = tag++;
        [self.view addSubview:button1];
        topMargin = button1.bottom + 10;
    }
    
    {
        AUButton *button1 = [self createButtonWithTitle:@"图文导航栏样式"];
        button1.origin = CGPointMake(kDemoGlobalMargin, topMargin);
        button1.tag = tag++;
        [self.view addSubview:button1];
        topMargin = button1.bottom + 10;
    }
    
    {
        AUButton *button1 = [self createButtonWithTitle:@"菜单导航栏样式"];
        button1.origin = CGPointMake(kDemoGlobalMargin, topMargin);
        button1.tag = tag++;
        [self.view addSubview:button1];
        topMargin = button1.bottom + 10;
    }
}

- (AUButton *)createButtonWithTitle:(NSString *)title
{
    AUButton *button1 = [AUButton buttonWithStyle:AUButtonStyle2];
    [button1 setTitle:title forState:UIControlStateNormal];
    button1.width = AUCommonUIGetScreenWidth() - kDemoGlobalMargin * 2;
    [button1 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    return button1;
}

- (void)clickButton:(id)sender
{
    if ([sender isKindOfClass:[AUButton class]])
    {
        AUButton *button = (AUButton *)sender;
        UIViewController *vc;
        switch (button.tag - KDemoViewTag) {
                
            case 1:
            {
                vc = [[MainTitleBarDemoViewController alloc] init];
            }
                break;
      
            case 3:
            {
                vc = [[NSClassFromString(@"CustomNaviBarDemoViewController") alloc] init];
                break;
            }
    
            case 5:
            {
                vc = [[NSClassFromString(@"MenuTitleViewDemoViewController") alloc] init];
                break;
            }
            case 2:
            {
                return;
            }
            case 4:
            {
                return;
            }
            default:
                break;
        }
        vc.title = button.titleLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
