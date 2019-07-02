//
//  UIButton+AUDemo.h
//  AntUI
//
//  Created by maizhelun on 2016/10/9.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (AUDemo)

- (dispatch_block_t)au_action;
- (void)setAu_action:(dispatch_block_t)action;

@end
