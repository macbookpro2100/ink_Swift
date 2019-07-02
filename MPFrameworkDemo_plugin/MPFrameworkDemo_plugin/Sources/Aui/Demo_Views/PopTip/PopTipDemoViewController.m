//
//  PopTipDemoViewController.m
//  AntUIDemo
//
//  Created by 沫竹 on 2018/2/7.
//  Copyright © 2018年 Alipay. All rights reserved.
//

#import "PopTipDemoViewController.h"
#import <AntUI/AUPopTipView.h>
#import <AntUI/AUPopBar.h>

@interface PopTipDemoViewController ()

@end

@implementation PopTipDemoViewController

- (void)showPopTipWithButton:(UIButton *)button
{
    if ([self.view viewWithTag:98]) {
        [(AUPopTipView *)[self.view viewWithTag:98] dismiss:YES];
    }
    else {
        AUPopTipView *popTipView = [AUPopTipView showFromView:button
                                                    fromPoint:CGPointZero
                                                       toView:self.view
                                                     animated:YES
                                                     withText:@"你好熟练度福建省练"
                                                  buttonTitle:@"关闭"];
//        popTipView.width = 250;
        popTipView.tag = 98;
        [popTipView setBackgroundColor:[UIColor blackColor]];
    }
}

- (void)showPopTipWithoutButton:(UIButton *)button
{
    if ([self.view viewWithTag:97]) {
        [(AUPopTipView *)[self.view viewWithTag:97] dismiss:YES];
    }
    else {
        AUPopTipView *popTipView = [AUPopTipView showFromView:button
                                                    fromPoint:CGPointZero
                                                       toView:self.view
                                                     animated:YES
                                                     withText:@"你好熟练度福建省练度福建省练度福建省"
                                                  buttonTitle:nil];
        popTipView.width = 320;
        popTipView.tag = 97;
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            button.y += 30;
//        });
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    {
        AUButton *button = [AUButton buttonWithStyle:AUButtonStyle6];
        [button setTitle:@"不带有按钮" forState:UIControlStateNormal];
        button.width = 100;
        button.center = CGPointMake(100, 200);
        button.left = 0;
        [self.view addSubview:button];
        __weak typeof(self) weakSelf = self;
        __weak AUButton *weakButton = button;
        button.auviewActionBlock = ^{
            [weakSelf showPopTipWithoutButton:weakButton];
        };
        [self showPopTipWithoutButton:button];
        
        
    }
    
    {
        __block AUButton *button = [AUButton buttonWithStyle:AUButtonStyle6];
        [button setTitle:@"带有按钮" forState:UIControlStateNormal];
        button.width = 100;
        button.center = CGPointMake(300, 380);
        [self.view addSubview:button];
        __weak typeof(self) weakSelf = self;
        __weak AUButton *weakButton = button;
        button.auviewActionBlock = ^{
            [weakSelf showPopTipWithButton:weakButton];
        };
        [self showPopTipWithButton:button];
        
    }
    
    
    {
        __block AUButton *button = [AUButton buttonWithStyle:AUButtonStyle6];
        [button setTitle:@"底部浮层" forState:UIControlStateNormal];
        button.width = 100;
        button.center = CGPointMake(200, 450);
        [self.view addSubview:button];
        __weak typeof(self) weakSelf = self;
        button.auviewActionBlock = ^{
            if ([weakSelf.view viewWithTag:99]) {
                [(AUPopBar *)[weakSelf.view viewWithTag:99] dismiss:YES];
            }
            else {
                AUPopBar *popBar = [AUPopBar showInViewBottom:weakSelf.view animated:YES withText:@"<b>把“城市服务”添加到首页到首页到首页到首页</b>" icon:[UIImage imageNamed:@"ap_scan"] buttonTitle:@"立即添加" actionBlock:^{
                    NSLog(@"点击了");
                    return YES;
                }];
                popBar.tag = 99;
            }
            
            
        };
        
    }
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [popTipView setInidicatorDirection:AUTipPopViewIndicatorDirectionDown];
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
