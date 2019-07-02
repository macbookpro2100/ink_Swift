//
//  MPWidgetInfo.m
//  MPBadgeService
//
//  Created by liangbao.llb on 12/14/14.
//  Copyright (c) 2014 Alipay. All rights reserved.
//

#import "MPWidgetInfo.h"

@implementation MPWidgetInfo

- (id)initWithId:(NSString *)widgetId
{
    self = [super init];
    if (self) {
        self.widgetId = widgetId;
    }
    
    return self;
}

@end
