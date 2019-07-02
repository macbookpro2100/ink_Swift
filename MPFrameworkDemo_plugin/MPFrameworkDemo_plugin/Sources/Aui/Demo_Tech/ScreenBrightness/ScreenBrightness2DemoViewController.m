//
//  ScreenBrightness2DemoViewController.m
//  AntUIDemo
//
//  Created by 莜阳 on 2018/3/27.
//  Copyright © 2018年 Alipay. All rights reserved.
//

#import "ScreenBrightness2DemoViewController.h"

@interface ScreenBrightness2DemoViewController ()

@end

@implementation ScreenBrightness2DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.title = @"中间页面";
    
    [self au_increaseBrightness:0.5];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
