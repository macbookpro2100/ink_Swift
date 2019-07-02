//
//  GlobalMaskService.h
//  BlurredView
//
//  Created by ouxi on 2018/5/4.
//  Copyright © 2018年 ouxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AUGlobalBlurService : NSObject // <DTService>

+ (instancetype)blurService;

- (void)startService;
@property(nonatomic, strong) NSMutableArray* maskViews;

@end


