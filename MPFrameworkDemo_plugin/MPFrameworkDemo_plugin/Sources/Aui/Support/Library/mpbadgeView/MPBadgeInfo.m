//
//  MPBadgeInfo.m
//  MPBadgeService
//
//  Created by liangbao.llb on 12/9/14.
//  Copyright (c) 2014 Alipay. All rights reserved.
//

#import "MPBadgeInfo.h"

@interface MPBadgeInfo () <NSCoding>
{
    NSMutableArray *_entries;
    NSArray *_widgetIds;
}

@end

@implementation MPBadgeInfo

#pragma mark - 类构造函数
+ (MPBadgeInfo *)badgeInfoWithBadgeId:(NSString *)badgeId
{
    MPBadgeInfo *msg = [[MPBadgeInfo alloc] initWithWidgetIdString:badgeId];
    return msg;
}

- (id)initWithWidgetIdString:(NSString *)string
{
    self = [super init];
    if (self) {
        _badgeId = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        _widgetIds = [string componentsSeparatedByString:@","];
        _temporaryBadgeNumber = 0;
        _persistentBadgeNumber = 0;
    }
    return self;
}

- (NSArray *)allWidgetIds
{
    return _widgetIds;
}

- (void)setBadgeId:(NSString *)badgeId
{
    if (badgeId) {
        _badgeId = [badgeId stringByReplacingOccurrencesOfString:@" " withString:@""];
        _widgetIds = [badgeId componentsSeparatedByString:@","];
    }
    else {
        _badgeId = nil;
    }
}

#pragma mark - Object Coding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.temporaryBadgeNumber forKey:NSStringFromSelector(@selector(temporaryBadgeNumber))];
    //[aCoder encodeInteger:self.persistentBadgeNumber forKey:NSStringFromSelector(@selector(persistentBadgeNumber))];
    [aCoder encodeObject:self.style forKey:NSStringFromSelector(@selector(style))];
    [aCoder encodeObject:[self allWidgetIds] forKey:NSStringFromSelector(@selector(allWidgetIds))];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _temporaryBadgeNumber = [aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(temporaryBadgeNumber))];
        //_persistentBadgeNumber = [aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(persistentBadgeNumber))];
        _style = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(style))];
        _widgetIds = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(allWidgetIds))];
    }
    return self;
}

#pragma mark - Overrides

- (BOOL)isEqual:(id)object
{
    if (object == nil || ![object isKindOfClass:[MPBadgeInfo class]]) {
        return NO;
    }
    
    NSArray *a = [self allWidgetIds];
    NSArray *b = [object allWidgetIds];
    if (a == b) {
        return YES;
    }
    
    if (a.count != b.count) {
        return NO;
    }
    
    for (NSInteger i = 0; i < a.count; ++i) {
        if (![[a objectAtIndex:i] isEqualToString:[b objectAtIndex:i]]) {
            return NO;
        }
    }
    
    return YES;
}

@end
