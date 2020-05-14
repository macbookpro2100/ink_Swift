//
//  InkNavigationController.m
//  MPFrameworkDemo_plugin
//
//  Created by 李砚(EX-LIYAN010) on 12/20/19.
//  Copyright © 2019 Alibaba. All rights reserved.
//

#import "InkNavigationController.h"
//#import "SuspensionEntrance.h"

@interface InkNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation InkNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.delegate = [SuspensionEntrance shared];
    self.interactivePopGestureRecognizer.enabled = NO;
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
