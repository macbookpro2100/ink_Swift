//
//  MPAbsBadgeView.m
//  MPBadgeService
//
//  Created by liangbao.llb on 12/10/14.
//  Copyright (c) 2014 Alipay. All rights reserved.
//

#import "MPAbsBadgeView.h"
#import "MPBadgeViewDelegate.h"

@implementation MPAbsBadgeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setWidgetId:(NSString *)widgetId
{
    if (![_widgetId isEqualToString:widgetId]) {
        [self updateBadgeValue:nil];
    }
    _widgetId = [widgetId copy];

    if (_widgetId && self.delegate && [self.delegate respondsToSelector:@selector(refreshBadgeView:)]) {
        if ([NSThread isMainThread]) {
            [self.delegate refreshBadgeView:self];
        }
        else {
            __weak MPAbsBadgeView *weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                MPAbsBadgeView *safeSelf = weakSelf;
                [safeSelf.delegate refreshBadgeView:safeSelf];
            });
        }
    }
}

- (void)updateBadgeValue:(NSString *)badgeValue
{
    [self drawBadgeStyle:badgeValue];
    if (self.callback) {
        self.callback();
    }
    
    if (self.updateBlock) {
        BOOL isShow = badgeValue ? YES : NO;
        self.updateBlock(self.widgetInfo, isShow);
    }
}

- (void)drawBadgeStyle:(NSString *)style
{
}

- (BOOL)isLastStyle:(NSString *)badgeValue{
    return NO;
}

@end
