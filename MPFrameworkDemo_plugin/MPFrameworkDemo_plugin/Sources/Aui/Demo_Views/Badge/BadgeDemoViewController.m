//
//  BadgeDemoViewController.m
//  AntUI
//
//  Created by zhaolei on 2017/8/31.
//  Copyright © 2017年 Alipay. All rights reserved.
//

#import "BadgeDemoViewController.h"
#import <AntUI/AUSingleTitleListItem.h>

@interface BadgeDemoViewController ()

@property(nonatomic,strong) AUSingleTitleListItem* item;

@end

@implementation BadgeDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.item = [[AUSingleTitleListItem alloc] initWithReuseIdentifier:@"AUSingleTitleListItemStyleValue1" customStyle:AUSingleTitleListItemStyleDefault];
    self.item.width = AUCommonUIGetScreenWidth();
    
    
    [self.item setModelBlock:^(AUListItemModel<AUSingleTitleListItemModelDelegate> *model) {
        model.title = @"单行列表";
        model.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }];
    
    [self.item addSubview:[self getANewSpliteLineWithTop:0 left:0]];
    [self.item addSubview:[self getANewSpliteLineWithTop:self.item.height left:0]];
    
    [self.item setBadgeView:@"demo" badgeNumber:@"."];
    
    [self.contentView addSubview:self.item];
}

@end
