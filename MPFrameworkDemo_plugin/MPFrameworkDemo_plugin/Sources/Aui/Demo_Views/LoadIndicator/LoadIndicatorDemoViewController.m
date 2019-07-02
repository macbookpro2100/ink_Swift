//
//  LoadIndicatorDemoViewController.m
//  AntUIDemo
//
//  Created by 沫竹 on 2017/11/3.
//  Copyright © 2017年 Alipay. All rights reserved.
//

#import "LoadIndicatorDemoViewController.h"
#import <AntUI/AUILoadingIndicatorView.h>

@interface LoadIndicatorDemoViewController ()

@end

@implementation LoadIndicatorDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat topmargin = self.headerView.bottom;
    
    {
        AUILoadingIndicatorView *loadView = [[AUILoadingIndicatorView alloc] initWithType:AUILoadingIndicatorTypeDragLoadMore bizName:@"demo" makeConfig:NULL];
        loadView.y = topmargin;
        loadView.x = 20;
        [self.view addSubview:loadView];
        [loadView startAnimating];
    }
    
    {
        topmargin = self.headerView.bottom + 50;
        AUILoadingIndicatorView *loadView = [[AUILoadingIndicatorView alloc] initWithType:AUILoadingIndicatorTypeToast bizName:@"demo" makeConfig:NULL];
        loadView.y = topmargin ;
        loadView.x = 20;
        [self.view addSubview:loadView];
        [loadView startAnimating];
    }
    {
        topmargin = self.headerView.bottom + 100;
        AUILoadingIndicatorView *loadView = [[AUILoadingIndicatorView alloc] initWithType:AUILoadingIndicatorTypeButton bizName:@"demo" makeConfig:NULL];
        loadView.y = topmargin ;
        loadView.x = 20;
        [self.view addSubview:loadView];
        [loadView startAnimating];
    }
    
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
