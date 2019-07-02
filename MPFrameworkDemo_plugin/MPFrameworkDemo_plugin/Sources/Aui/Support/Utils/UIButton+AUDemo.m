//
//  UIButton+AUDemo.m
//  AntUI
//
//  Created by maizhelun on 2016/10/9.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "UIButton+AUDemo.h"
#import <objc/runtime.h>

@implementation UIButton (AUDemo)

- (dispatch_block_t)au_action
{
    return objc_getAssociatedObject(self, @selector(au_action));
}

- (void)setAu_action:(dispatch_block_t)action
{
    objc_setAssociatedObject(self, @selector(au_action), action, OBJC_ASSOCIATION_COPY);
    [self removeTarget:self action:@selector(performAu_action) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(performAu_action) forControlEvents:UIControlEventTouchUpInside];
}

- (void)performAu_action
{
    dispatch_block_t action = self.au_action;
    if (action) {
        action();
    }
}

@end
