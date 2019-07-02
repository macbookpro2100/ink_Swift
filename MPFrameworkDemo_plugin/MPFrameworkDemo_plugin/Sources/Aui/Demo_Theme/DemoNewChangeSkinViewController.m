//
//  DemoChangeSkinViewController.m
//  AntUIDemo
//
//  Created by 莜阳 on 2018/1/9.
//  Copyright © 2018年 Alipay. All rights reserved.
//

#import "DemoNewChangeSkinViewController.h"
#import "APImageRequest.h"

@interface DemoNewChangeSkinViewController ()

@end

@implementation DemoNewChangeSkinViewController

- (void)viewDidLoad {
    
    [self setAUThemeName:@"DemoTheme/theme1.strings" bunldeName:@"APCommonUI_ForDemo"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.title = @"换肤";
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, self.topMargin, 30, 30)];
    imgView.backgroundColor = [UIColor colorWithRGB:0x108ee9];
    CGFloat tempHeight = 50;
    [imgView au_bindTheme:AU_SEL(setSize:) inBundle:@"APCommonUI_ForDemo" argsList:AU_ARG_FLOAT(@"TITLEBAR_ICON_SIZE", 49), &tempHeight];
    
    UIButton *button = [[UIButton alloc] init];
//    [button setTitleColor:AU_ARG_COLOR([@"DEMO_BUTTON_TITLE_COLOR", RGB(0x108ee9)]) forState:UIControlStateNormal];
//    [button au_bindTheme:AU_SEL(setTitleColor:forState:) inBundle:@"APCommonUI_ForDemo" argsList:AU_ARG_COLOR(@"DEMO_BUTTON_TITLE_COLOR", RGB(0x108ee9), AU_VALUE(UIControlStateNormal)];
    
    APImageRequest *request = [[APImageRequest alloc] init];
    request.downLoadCompletion = ^(APImageDownloadResponse *response) {
        if (response.image) {
            [imgView setImage:response.image];
        }
    };

//    [imgView au_bindImageWithKey:@"AU_DEMO_IMAGE1_ICON_PATH" inBundle:@"APCommonUI_ForDemo" request:request];
    
    [self.view addSubview:imgView];
}


@end
