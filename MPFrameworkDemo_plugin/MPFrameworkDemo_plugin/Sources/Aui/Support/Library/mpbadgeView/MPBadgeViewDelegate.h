//
//  MPBadgeViewDelegate.h
//  MPBadgeService
//
//  Created by liangbao.llb on 12/10/14.
//  Copyright (c) 2014 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MPAbsBadgeView;

@protocol MPBadgeViewDelegate <NSObject>

- (void)refreshBadgeView:(MPAbsBadgeView *)badgeView;

@end
