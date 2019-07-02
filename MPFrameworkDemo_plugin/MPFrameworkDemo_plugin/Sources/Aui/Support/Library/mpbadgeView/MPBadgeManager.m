//
//  MPBadgeManager.m
//  MPBadgeService
//
//  Created by liangbao.llb on 12/9/14.
//  Copyright (c) 2014 Alipay. All rights reserved.
//

#import "MPBadgeManager.h"
#import "MPBadgeViewDelegate.h"
#import "MPBadgeServiceConfig.h"
#import "MPBadgeInfo.h"
#import "MPAbsBadgeView.h"
#import "MPWidgetInfo.h"
//#import <MPDataCenter/APDataCenter.h>

typedef NS_ENUM(NSInteger, APBadgeMsgUpdateType) {
    APBadgeMsgUpdateTypeAdd,
    APBadgeMsgUpdateTypeModify,
    APBadgeMsgUpdateTypeDelete,
};

@protocol MPBadgeDaoProtocol <NSObject>

- (NSArray *)getBadgeData:(NSString *)userId;
- (NSArray *)getBadgeDataWithBadges:(NSArray *)badgeList;
- (void)saveBadgeData:(NSArray *)badgeList;
- (void)deleteBadgeData:(NSArray *)badgeList;
- (void)deleteBadgeDataWithUserId:(NSString *)userId;
- (void)deleteAllBadgeData;

@end

static MPBadgeManager *sSharedInstance = nil;

@interface MPBadgeManager () <MPBadgeViewDelegate>
{
    NSMutableArray      *_badgeMessages;
    NSMutableArray      *_localBadgeMessages;
    NSMutableDictionary *_badgeMap;
    NSMutableArray      *_badgeWidgets;
    NSRecursiveLock     *_badgeMessagesLock;
    NSRecursiveLock     *_localBadgeMessagesLock;
    NSRecursiveLock     *_badgeMapLock;
    NSString            *_userId;
    id<MPBadgeDaoProtocol>_proxy;
}

@property (nonatomic, strong) id<MPBadgeServiceConfig> badgeConfig;

@end

@implementation MPBadgeManager

#pragma mark - 析构方法
- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 构造方法
- (id)init
{
    if (self = [super init]) {
        _badgeMap = [[NSMutableDictionary alloc] init];
        _badgeWidgets = [[NSMutableArray alloc] init];
        _badgeMessages = [[NSMutableArray alloc] init];
        _localBadgeMessages = [[NSMutableArray alloc] init];
        _badgeMessagesLock = [[NSRecursiveLock alloc] init];
        _localBadgeMessagesLock = [[NSRecursiveLock alloc] init];
        _badgeMapLock = [[NSRecursiveLock alloc] init];
        
        NSString *daoConfigPath = [[NSBundle mainBundle] pathForResource:@"MPBadgeService.bundle/MPBadgeServiceDAO" ofType:@"xml"];
        _proxy = nil;
    }
    
    return self;
}

#pragma mark - 类接口方法

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[[self class] alloc] init];
    });
    return sSharedInstance;
}

- (void)setBadgeServiceConfig:(id<MPBadgeServiceConfig>)config
{
    self.badgeConfig = config;
}

- (void)refreshAfterLogin:(NSString *)userId
{
    _userId = userId;
    
    // 清除内存缓存
    [self clearAllBadges];
    
    // 读取本地缓存数据，并显示红点
    [self getBadgeDataFromLocalCache];
    [self refreshWidgets];
}

- (void)clearAllBadges
{
    // 清除界面上的红点
    dispatch_async(dispatch_get_main_queue(), ^{
        for (MPAbsBadgeView *badgeView in _badgeWidgets) {
            [badgeView updateBadgeValue:nil];
        }
    });
    
    // 清除内存数据
    if (_badgeMessages) {
        [_badgeMessagesLock lock];
        [_badgeMessages removeAllObjects];
        [_badgeMessagesLock unlock];
    }
    
    if (_localBadgeMessages) {
        [_localBadgeMessagesLock lock];
        [_localBadgeMessages removeAllObjects];
        [_localBadgeMessagesLock unlock];
    }
    
    if (_badgeMap) {
        [_badgeMapLock lock];
        [_badgeMap removeAllObjects];
        [_badgeMapLock unlock];
    }
}

#pragma mark - 控件操作接口
- (void)registerBadgeView:(MPAbsBadgeView *)badgeView
{
    NSAssert([NSThread isMainThread], nil);
    
    if (nil == badgeView) {
        NSAssert(0, @"注册的MPAbsBadgeView不能nil");
        return;
    }
    
    if (![badgeView isKindOfClass:[MPAbsBadgeView class]]) {
        NSAssert(0, @"注册的红点控件必须是MPAbsBadgeView的子类");
        return;
    }
    
    if (![_badgeWidgets containsObject:badgeView]) {
        badgeView.delegate = self;
        [_badgeWidgets addObject:badgeView];
        [self refreshBadgeViewStyle:badgeView];
    }
}

- (void)unregisterBadgeView:(MPAbsBadgeView *)badgeView
{
    NSAssert([NSThread isMainThread], nil);
    
    if (nil == badgeView || nil == badgeView.widgetId) {
        return;
    }
    
    if ([_badgeWidgets containsObject:badgeView]) {
        [badgeView updateBadgeValue:nil];
        [_badgeWidgets removeObject:badgeView];
    }
}

- (void)tapBadgeView:(MPAbsBadgeView *)badgeView
{
    MPWidgetInfo *widgetInfo = badgeView.widgetInfo;
    if (!widgetInfo.bNeedAck || 0 == (widgetInfo.temporaryBadgeNumber + widgetInfo.persistentBadgeNumber)) {
        return;
    }
    [self tapBadgeViewWithWidgetId:badgeView.widgetId];
}

- (void)tapBadgeViewWithWidgetId:(NSString *)widgetId
{
    if (nil == widgetId || ![widgetId isKindOfClass:[NSString class]] || 0 == [widgetId length]) {
        return;
    }
    
    [_badgeMapLock lock];
    MPWidgetInfo *widgetInfo = [_badgeMap objectForKey:widgetId];
    [_badgeMapLock unlock];
    if (nil == widgetInfo || !widgetInfo.bNeedAck ||
        0 == (widgetInfo.temporaryBadgeNumber + widgetInfo.persistentBadgeNumber)) {
        return;
    }
    
    widgetInfo.bNeedAck = NO;
    BOOL bRemoteDataChanged = [self tapBadgeViewInRemoteData:widgetId];
    BOOL bLocalDataChanged = [self tapBadgeViewInLocalData:widgetId];
    if (bRemoteDataChanged || bLocalDataChanged) {
        [self performSelectorOnMainThread:@selector(refreshAllWidgets) withObject:nil waitUntilDone:NO];
    }
}

- (void)clearBadgeWithWidgetId:(NSString *)widgetId
{
    if (nil == widgetId || ![widgetId isKindOfClass:[NSString class]] || 0 == [widgetId length]) {
        return;
    }
    
    [_badgeMapLock lock];
    MPWidgetInfo *widgetInfo = [_badgeMap objectForKey:widgetId];
    [_badgeMapLock unlock];
    if (nil == widgetInfo || 0 == (widgetInfo.temporaryBadgeNumber + widgetInfo.persistentBadgeNumber)) {
        return;
    }
    
    BOOL bRemoteDataChanged = NO;
    NSArray *messagesInRemote = [self findMessagesByWidgetIdInRemoteData:widgetId isLeaf:NO];
    for (MPBadgeInfo *msg in messagesInRemote) {
        BOOL ret = [self tapBadgeViewInRemoteData:msg.allWidgetIds.lastObject];
        if (ret) {
            bRemoteDataChanged = YES;
        }
    }
    
    BOOL bLocalDataChanged = NO;
    NSArray *messagesInLocal = [self findMessagesByWidgetIdInLocalData:widgetId isLeaf:NO];
    for (MPBadgeInfo *msg in messagesInLocal) {
        BOOL ret = [self tapBadgeViewInLocalData:msg.allWidgetIds.lastObject];
        if (ret) {
            bLocalDataChanged = YES;
        }
    }
    
    if (bRemoteDataChanged || bLocalDataChanged) {
        [self performSelectorOnMainThread:@selector(refreshAllWidgets) withObject:nil waitUntilDone:NO];
    }
}

- (MPBadgeInfo *)badgeInfoWithBadgeId:(NSString *)badgeId
{
    if (!badgeId || ![badgeId isKindOfClass:[NSString class]] || 0 == [badgeId length]) {
        return nil;
    }
    
    [_badgeMessagesLock lock];
    for (MPBadgeInfo *msg in _badgeMessages) {
        if ([msg.badgeId isEqual:badgeId]) {
            [_badgeMessagesLock unlock];
            return msg;
        }
    }
    [_badgeMessagesLock unlock];
    
    [_localBadgeMessagesLock lock];
    for (MPBadgeInfo *msg in _localBadgeMessages) {
        if ([msg.badgeId isEqual:badgeId]) {
            [_localBadgeMessagesLock unlock];
            return msg;
        }
    }
    [_localBadgeMessagesLock unlock];
    
    return nil;
}

- (NSUInteger)badgeCountWithBizId:(NSString *)bizId
{
    if (!bizId || ![bizId isKindOfClass:[NSString class]] || 0 == [bizId length]) {
        return 0;
    }
    
    // 获取指定业务下“红点”的总数
    NSUInteger uCount = 0;
    NSString *widgetId = nil;
    
    [_badgeMessagesLock lock];
    for (MPBadgeInfo *msg in _badgeMessages) {
        widgetId = [msg allWidgetIds].lastObject;
        if (msg.bizId && [msg.bizId isEqualToString:bizId]) {
            uCount += msg.temporaryBadgeNumber + msg.persistentBadgeNumber;
        }
    }
    [_badgeMessagesLock unlock];
    
    [_localBadgeMessagesLock lock];
    for (MPBadgeInfo *msg in _localBadgeMessages) {
        widgetId = [msg allWidgetIds].lastObject;
        if (msg.bizId && [msg.bizId isEqualToString:bizId]) {
            uCount += msg.temporaryBadgeNumber + msg.persistentBadgeNumber;
        }
    }
    [_localBadgeMessagesLock unlock];
    
    return uCount;
}

- (NSUInteger)badgeCountWithWidgetId:(NSString *)widgetId
{
    if (!widgetId || ![widgetId isKindOfClass:[NSString class]] || 0 == [widgetId length]) {
        return 0;
    }
    
    // 获取指定控件“红点”的总数
    NSUInteger uCount = 0;
    
    [_badgeMessagesLock lock];
    for (MPBadgeInfo *item in _badgeMessages) {
        if ([[item allWidgetIds] containsObject:widgetId]) {
            uCount += item.temporaryBadgeNumber + item.persistentBadgeNumber;
        }
    }
    [_badgeMessagesLock unlock];
    
    [_localBadgeMessagesLock lock];
    for (MPBadgeInfo *item in _localBadgeMessages) {
        if ([[item allWidgetIds] containsObject:widgetId]) {
            uCount += item.temporaryBadgeNumber + item.persistentBadgeNumber;
        }
    }
    [_localBadgeMessagesLock unlock];
    
    return uCount;
}

- (NSDictionary *)badgeCountDetailWithWidgetId:(NSString *)widgetId
{
    if (!widgetId || ![widgetId isKindOfClass:[NSString class]] || 0 == [widgetId length]) {
        return nil;
    }
    
    // 获取指定控件“红点”的个数详情
    NSMutableDictionary *badgeCountDetail = [NSMutableDictionary dictionary];
    NSUInteger pointCount = 0;
    NSUInteger numCount = 0;
    NSUInteger newCount = 0;
    NSUInteger huiConnt = 0;
    NSUInteger xinCount = 0;
    NSUInteger customCount = 0;
    
    [_badgeMessagesLock lock];
    for (MPBadgeInfo *item in _badgeMessages) {
        if ([[item allWidgetIds] containsObject:widgetId]) {
            if ([item.style isEqual:@"point"]) {
                pointCount += item.temporaryBadgeNumber + item.persistentBadgeNumber;
            }
            else if ([item.style isEqual:@"num"]) {
                numCount += item.temporaryBadgeNumber + item.persistentBadgeNumber;
            }
            else if ([item.style isEqual:@"new"]) {
                newCount += item.temporaryBadgeNumber + item.persistentBadgeNumber;
            }
            else if ([item.style isEqual:@"hui"]) {
                huiConnt += item.temporaryBadgeNumber + item.persistentBadgeNumber;
            }
            else if ([item.style isEqual:@"xin"]) {
                xinCount += item.temporaryBadgeNumber + item.persistentBadgeNumber;
            }
            else {
                customCount += item.temporaryBadgeNumber + item.persistentBadgeNumber;
            }
        }
    }
    [_badgeMessagesLock unlock];
    
    [_localBadgeMessagesLock lock];
    for (MPBadgeInfo *item in _localBadgeMessages) {
        if ([[item allWidgetIds] containsObject:widgetId]) {
            if ([item.style isEqual:@"point"]) {
                pointCount += item.temporaryBadgeNumber + item.persistentBadgeNumber;
            }
            else if ([item.style isEqual:@"num"]) {
                numCount += item.temporaryBadgeNumber + item.persistentBadgeNumber;
            }
            else if ([item.style isEqual:@"new"]) {
                newCount += item.temporaryBadgeNumber + item.persistentBadgeNumber;
            }
            else if ([item.style isEqual:@"hui"]) {
                huiConnt += item.temporaryBadgeNumber + item.persistentBadgeNumber;
            }
            else if ([item.style isEqual:@"xin"]) {
                xinCount += item.temporaryBadgeNumber + item.persistentBadgeNumber;
            }
            else {
                customCount += item.temporaryBadgeNumber + item.persistentBadgeNumber;
            }
        }
    }
    [_localBadgeMessagesLock unlock];
    
    if (pointCount > 0) {
        [badgeCountDetail setObject:[NSString stringWithFormat:@"%lu", (unsigned long)pointCount] forKey:@"point"];
    }
    if (numCount > 0) {
        [badgeCountDetail setObject:[NSString stringWithFormat:@"%lu", (unsigned long)numCount] forKey:@"num"];
    }
    if (newCount > 0) {
        [badgeCountDetail setObject:[NSString stringWithFormat:@"%lu", (unsigned long)newCount] forKey:@"new"];
    }
    if (huiConnt > 0) {
        [badgeCountDetail setObject:[NSString stringWithFormat:@"%lu", (unsigned long)huiConnt] forKey:@"hui"];
    }
    if (xinCount > 0) {
        [badgeCountDetail setObject:[NSString stringWithFormat:@"%lu", (unsigned long)xinCount] forKey:@"xin"];
    }
    if (customCount > 0) {
        [badgeCountDetail setObject:[NSString stringWithFormat:@"%lu", (unsigned long)customCount] forKey:@"custom"];
    }
    
    return badgeCountDetail;
}

#pragma mark - 数据操作接口
- (void)insertRemoteBadgeInfo:(NSArray *)badgeList
{
    [self updateLocalDataWithRemoteDataAndRefresh:badgeList mode:APBadgeMsgUpdateTypeAdd];
}

- (void)modifyRemoteBadgeInfo:(NSArray *)badgeList
{
    [self updateLocalDataWithRemoteDataAndRefresh:badgeList mode:APBadgeMsgUpdateTypeModify];
}

- (void)deleteRemoteBadgeInfo:(NSArray *)badgeList
{
    [self updateLocalDataWithRemoteDataAndRefresh:badgeList mode:APBadgeMsgUpdateTypeDelete];
}

- (void)insertLocalBadgeInfo:(NSArray *)badgeList
{
    if (![badgeList isKindOfClass:[NSArray class]]) {
        return;
    }
    
    [self updateLocalDataWithLocalData:badgeList];
}

#pragma mark 类内部接口
- (void)refreshAllWidgets
{
    [self performSelector:@selector(updateWidget) withObject:nil afterDelay:0.02];
}

- (void)updateWidget
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateWidget) object:nil];
    
    // 计算wigetId要显示的临时和持久数
    [_badgeMessagesLock lock];
    [_localBadgeMessagesLock lock];
    [_badgeMapLock lock];
    for (NSString *widgetId in [_badgeMap allKeys]) {
        MPWidgetInfo *widgetInfo = [_badgeMap objectForKey:widgetId];
        widgetInfo.persistentBadgeNumber = 0;
        widgetInfo.temporaryBadgeNumber = 0;
        widgetInfo.bNeedAck = NO;
        
        for (MPBadgeInfo *item in _badgeMessages) {
            // 实现了wigetId关联显示问题
            if ([[item allWidgetIds] containsObject:widgetId]) {
                widgetInfo.temporaryBadgeNumber += item.temporaryBadgeNumber;
                widgetInfo.persistentBadgeNumber += item.persistentBadgeNumber;
                if ([[item allWidgetIds].lastObject isEqualToString:widgetId] &&
                    (widgetInfo.temporaryBadgeNumber + widgetInfo.persistentBadgeNumber > 0)) {
                    widgetInfo.bNeedAck = YES;
                }
            }
        }
        
        for (MPBadgeInfo *item in _localBadgeMessages) {
            // 实现了wigetId关联显示问题
            if ([[item allWidgetIds] containsObject:widgetId]) {
                widgetInfo.temporaryBadgeNumber += item.temporaryBadgeNumber;
                widgetInfo.persistentBadgeNumber += item.persistentBadgeNumber;
                if ([[item allWidgetIds].lastObject isEqualToString:widgetId] &&
                    (widgetInfo.temporaryBadgeNumber + widgetInfo.persistentBadgeNumber > 0)) {
                    widgetInfo.bNeedAck = YES;
                }
            }
        }
        
    }
    [_badgeMapLock unlock];
    [_localBadgeMessagesLock unlock];
    [_badgeMessagesLock unlock];
    
    // 更新widget的显示
    for (MPAbsBadgeView *widget in _badgeWidgets) {
        NSString *widgetId = widget.widgetId;
        if (nil == widgetId) {
            [widget updateBadgeValue:nil];
            continue;
        }
        
        [self refreshBadgeViewStyle:widget];
    }
}

- (BOOL)tapBadgeViewInRemoteData:(NSString *)widgetId
{
    NSArray *messages = [self findMessagesByWidgetIdInRemoteData:widgetId isLeaf:YES];
    if (nil == messages || 0 == [messages count]) {
        return NO;
    }
    
    // 删除内存缓存
    [_badgeMessagesLock lock];
    [_badgeMessages removeObjectsInArray:messages];
    [_badgeMessagesLock unlock];
    
    // 删除本地缓存
    [_proxy deleteBadgeData:messages];
    
    return YES;
}

- (BOOL)tapBadgeViewInLocalData:(NSString *)widgetId
{
    NSArray *messages = [self findMessagesByWidgetIdInLocalData:widgetId isLeaf:YES];
    if (nil == messages || 0 == [messages count]) {
        return NO;
    }
    
    // 删除内存缓存，本地不缓存
    [_localBadgeMessagesLock lock];
    [_localBadgeMessages removeObjectsInArray:messages];
    [_localBadgeMessagesLock unlock];
    
    return YES;
}

- (NSArray *)findMessagesByWidgetIdInRemoteData:(NSString *)widgetId isLeaf:(BOOL)isLeaf
{
    // 查找以指定widgetId作为叶子的红点信息
    NSMutableArray *array = [NSMutableArray array];
    
    [_badgeMessagesLock lock];
    for (MPBadgeInfo *msg in _badgeMessages) {
        if (isLeaf) {
            if ([[msg allWidgetIds].lastObject isEqualToString:widgetId]) {
                [array addObject:msg];
            }
        }
        else {
            for (NSString *wId in [msg allWidgetIds]) {
                if ([wId isEqualToString:widgetId]) {
                    [array addObject:msg];
                    break;
                }
            }
        }
    }
    [_badgeMessagesLock unlock];
    
    return array;
}

- (NSArray *)findMessagesByWidgetIdInLocalData:(NSString *)widgetId isLeaf:(BOOL)isLeaf
{
    // 查找以指定widgetId作为叶子的红点信息
    NSMutableArray *array = [NSMutableArray array];
    
    [_localBadgeMessagesLock lock];
    for (MPBadgeInfo *msg in _localBadgeMessages) {
        if (isLeaf) {
            if ([[msg allWidgetIds].lastObject isEqualToString:widgetId]) {
                [array addObject:msg];
            }
        }
        else {
            for (NSString *wId in [msg allWidgetIds]) {
                if ([wId isEqualToString:widgetId]) {
                    [array addObject:msg];
                    break;
                }
            }
        }
    }
    [_localBadgeMessagesLock unlock];
    
    return array;
}

- (void)updateLocalDataWithRemoteDataAndRefresh:(NSArray *)badgeList mode:(APBadgeMsgUpdateType)mode
{
    if (nil == badgeList || ![badgeList isKindOfClass:[NSArray class]] || 0 == [badgeList count]) {
        return;
    }
    
    // 和本地数据做合并，然后保存
    if (APBadgeMsgUpdateTypeModify == mode) {
        [_proxy saveBadgeData:badgeList];
    }
    else if (mode == APBadgeMsgUpdateTypeAdd) {
        [self addBadgeDataWithRemoteData:badgeList];
    }
    else if (mode == APBadgeMsgUpdateTypeDelete) {
        [self deleteBadgeDataWithRemoteData:badgeList];
    }
    
    // 获取最新数据并刷新界面
    [self getBadgeDataFromLocalCache];
    [self refreshWidgets];
}

- (void)addBadgeDataWithRemoteData:(NSArray *)badgeList
{
    NSArray *localBadgeData = [_proxy getBadgeDataWithBadges:badgeList];
    if ([localBadgeData count] > 0) {
        NSMutableArray *modifyList = [NSMutableArray array];
        for (MPBadgeInfo *remoteMsg in badgeList) {
            for (MPBadgeInfo *localMsg in localBadgeData) {
                if ([remoteMsg isEqual:localMsg]) {
                    remoteMsg.temporaryBadgeNumber += localMsg.temporaryBadgeNumber;
                    break;
                }
            }
            [modifyList addObject:remoteMsg];
        }
        badgeList = modifyList;
    }
    
    [_proxy saveBadgeData:badgeList];
}

- (void)deleteBadgeDataWithRemoteData:(NSArray *)badgeList
{
    NSArray *localBadgeData = [_proxy getBadgeDataWithBadges:badgeList];
    if ([localBadgeData count] > 0) {
        NSMutableArray *modifyList = [NSMutableArray array];
        NSMutableArray *deleletList = [NSMutableArray array];
        for (MPBadgeInfo *remoteMsg in badgeList) {
            for (MPBadgeInfo *localMsg in localBadgeData) {
                if ([remoteMsg isEqual:localMsg]) {
                    NSUInteger count = localMsg.temporaryBadgeNumber - remoteMsg.temporaryBadgeNumber;
                    remoteMsg.temporaryBadgeNumber = count > 0 ? count : 0;
                    if (count > 0) {
                        [modifyList addObject:remoteMsg];
                    }
                    else {
                        [deleletList addObject:remoteMsg];
                    }
                    break;
                }
            }
        }
        
        if ([modifyList count] > 0) {
            [_proxy saveBadgeData:modifyList];
        }
        
        if ([deleletList count] > 0) {
            [_proxy deleteBadgeData:deleletList];
        }
    }
}

- (void)updateLocalDataWithLocalData:(NSArray *)badgeList
{
    // 不清除本地保存的持久数据，因为本地多个业务注入，是增量数据
    // 将服务器返回的数据保存到_localBadgeMessages
    for (MPBadgeInfo *remoteMsg in badgeList) {
        [self addBadgeMessageLocalData:remoteMsg];
    }
    
    // 保存新获取widgetId到_badgeMap中，在显示时计算显示临时和持久总数
    [_localBadgeMessagesLock lock];
    for (MPBadgeInfo *msg in _localBadgeMessages) {
        for (NSString *widgetId in [msg allWidgetIds]) {
            [_badgeMapLock lock];
            MPWidgetInfo *widgetInfo = [_badgeMap objectForKey:widgetId];
            if (nil == widgetInfo) {
                widgetInfo = [[MPWidgetInfo alloc] initWithId:widgetId];
                [_badgeMap setObject:widgetInfo forKey:widgetId];
            }
            [_badgeMapLock unlock];
            [self setBadgeStyle:widgetInfo style:msg.style];
        }
    }
    [_localBadgeMessagesLock unlock];
    
    [self performSelectorOnMainThread:@selector(refreshAllWidgets) withObject:nil waitUntilDone:NO];
    
    // 发送红点数据更新通知
    [self postBadgeUpdateNotification];
}

- (void)refreshWidgets
{
    // 保存新获取widgetId到_badgeMap中，在显示时计算显示临时和持久总数
    [_badgeMapLock lock];
    if (_badgeMap) {
        [_badgeMap removeAllObjects];
    }
    [_badgeMapLock unlock];
    
    [_badgeMessagesLock lock];
    for (MPBadgeInfo *msg in _badgeMessages) {
        for (NSString *widgetId in [msg allWidgetIds]) {
            [_badgeMapLock lock];
            MPWidgetInfo *widgetInfo = [_badgeMap objectForKey:widgetId];
            if (nil == widgetInfo) {
                widgetInfo = [[MPWidgetInfo alloc] initWithId:widgetId];
                [_badgeMap setObject:widgetInfo forKey:widgetId];
            }
            [_badgeMapLock unlock];
            [self setBadgeStyle:widgetInfo style:msg.style];
        }
    }
    [_badgeMessagesLock unlock];
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf updateWidget];
    });
}

- (BOOL)updateBadgeMessageRemoteData:(MPBadgeInfo *)newBadgeInfo mode:(APBadgeMsgUpdateType)mode
{
    if (newBadgeInfo) {
        // 检查本地缓存是否存在，如果存在，覆盖本地缓存数据，否则新增
        [_badgeMessagesLock lock];
        for (MPBadgeInfo *msg in _badgeMessages) {
            if ([newBadgeInfo isEqual:msg]) {
                if (mode == APBadgeMsgUpdateTypeAdd) {
                    msg.temporaryBadgeNumber += newBadgeInfo.temporaryBadgeNumber;
                }
                else if (mode == APBadgeMsgUpdateTypeModify) {
                    msg.temporaryBadgeNumber = newBadgeInfo.temporaryBadgeNumber;
                }
                else if (mode == APBadgeMsgUpdateTypeDelete) {
                    if (msg.temporaryBadgeNumber < newBadgeInfo.temporaryBadgeNumber) {
                        msg.temporaryBadgeNumber = 0;
                    }
                    else {
                        msg.temporaryBadgeNumber -= newBadgeInfo.temporaryBadgeNumber;
                    }
                }
                msg.persistentBadgeNumber = newBadgeInfo.persistentBadgeNumber;
                msg.style = newBadgeInfo.style;
                
                [_badgeMessagesLock unlock];
                return NO;
            }
        }
        [_badgeMessages addObject:newBadgeInfo];
        
        [_badgeMessagesLock unlock];
        return YES;
    }
    return NO;
}

- (BOOL)addBadgeMessageLocalData:(MPBadgeInfo *)newBadgeInfo
{
    if (newBadgeInfo) {
        // 检查本地缓存是否存在，如果存在，覆盖本地缓存数据，否则新增
        [_localBadgeMessagesLock lock];
        for (MPBadgeInfo *msg in _localBadgeMessages) {
            if ([newBadgeInfo isEqual:msg]) {
                msg.temporaryBadgeNumber += newBadgeInfo.temporaryBadgeNumber;
                msg.persistentBadgeNumber = newBadgeInfo.persistentBadgeNumber;
                msg.style = newBadgeInfo.style;
                
                [_localBadgeMessagesLock unlock];
                return NO;
            }
        }
        [_localBadgeMessages addObject:newBadgeInfo];
        
        [_localBadgeMessagesLock unlock];
        return YES;
    }
    return NO;
}

- (void)setBadgeStyle:(MPWidgetInfo *)widgetInfo style:(NSString *)style
{
    // 默认的显示级别：hui > xin > new > num > point
    if (nil == widgetInfo.style) {
        widgetInfo.style = style;
    }
    else if (![widgetInfo.style isEqualToString:style]) {
        NSInteger oldStyleLevel = 0;
        NSInteger newStyleLevel = 0;
        NSArray *styleArray = @[@"hui", @"xin", @"new", @"num", @"point"];
        for (int i = 0; i < [styleArray count]; i++) {
            if ([[styleArray objectAtIndex:i] isEqualToString:widgetInfo.style]) {
                oldStyleLevel = i;
            }
            else if ([[styleArray objectAtIndex:i] isEqualToString:style]) {
                newStyleLevel = i;
            }
        }
        
        if (newStyleLevel < oldStyleLevel) {
            widgetInfo.style = style;
        }
    }
}

- (void)postBadgeUpdateNotification
{
    // 发送红点数据更新通知
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kMPBadgeServiceUpdateNotification object:self];
    });
}

#pragma mark -本地缓存方法
- (void)getBadgeDataFromLocalCache
{
    NSArray *tempArr = [_proxy getBadgeData:_userId];
    
    [_badgeMessagesLock lock];
    [_badgeMessages removeAllObjects];
    [_badgeMessages addObjectsFromArray:tempArr];
    [_badgeMessagesLock unlock];
}

#pragma mark - MPBadgeViewDelegate
- (void)refreshBadgeView:(MPAbsBadgeView *)badgeView
{
    NSAssert([NSThread isMainThread], nil);
    if (nil == badgeView || ![_badgeWidgets containsObject:badgeView]) {
        return;
    }
    
    [self refreshBadgeViewStyle:badgeView];
}

- (void)refreshBadgeViewStyle:(MPAbsBadgeView *)widget
{
    [_badgeMapLock lock];
    MPWidgetInfo *widgetInfo = [_badgeMap objectForKey:widget.widgetId];
    [_badgeMapLock unlock];
    widget.widgetInfo = widgetInfo;
    if (widgetInfo && (widgetInfo.temporaryBadgeNumber != 0 || widgetInfo.persistentBadgeNumber != 0)) {
        if ([widgetInfo.style isEqualToString:@"point"]) {
            [widget updateBadgeValue:@"."];
        }
        else if ([[widgetInfo.style lowercaseString] isEqualToString:@"new"]) {
            [widget updateBadgeValue:@"new"];
        }
        else if ([[widgetInfo.style lowercaseString] isEqualToString:@"hui"]) {
            [widget updateBadgeValue:@"hui"];
        }
        else if ([[widgetInfo.style lowercaseString] isEqualToString:@"xin"]) {
            [widget updateBadgeValue:@"xin"];
        }
        else if ([[widgetInfo.style lowercaseString] isEqualToString:@"num"]) {
            NSString *strNum = [NSString stringWithFormat:@"%lu", (unsigned long)(widgetInfo.temporaryBadgeNumber + widgetInfo.persistentBadgeNumber)];
            if (widget.numberCalculateMode != nil) {
                NSDictionary *badgeCountDetail = [self badgeCountDetailWithWidgetId:widget.widgetId];
                strNum = [badgeCountDetail objectForKey:widget.numberCalculateMode];
            }
            [widget updateBadgeValue:strNum];
        }
        else {
        }
    }
    else {
        [widget updateBadgeValue:nil];
        widgetInfo.style = nil;
    }
}

@end
