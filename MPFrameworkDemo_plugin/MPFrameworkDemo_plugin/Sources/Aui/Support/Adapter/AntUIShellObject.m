
//
//  AntUIShellObject.m
//  AntUIShell
//
//  Created by 祝威 on 16/9/27.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "AntUIShellObject.h"

//#import <APMonitor/APMonitor.h>
//#import <APMultimedia/APMultimedia.h>
#import <MPBadgeService/MPBadgeService.h>

#import "APImageRequest.h"
#import "Lottie.h"

@implementation AntUIShellObject


#pragma mark ----AUThirdPartyAdapter
/***********************************************************/
//图片协议APMultimedia
/*
 第三方适配下载图片接口
 主要对多媒体接口进行包装，由第三方实现
 */
- (NSString *)thirdPartyGetImage:(NSString *)identifier
                        business:(NSString *)business
                            zoom:(CGSize)size
                    originalSize:(CGSize)originSize
                        progress:(void (^)(double percentage,long long partialBytes,long long totalBytes))progress
                      completion:(void (^)(UIImage *image, NSError *error))complete
{
//    return  [[APImageManager manager] getImage:identifier business:business zoom:size originalSize:originSize progress:progress completion:complete];
    return nil;
}

/*
 第三方适配uiimageview下载图片接口
 由第三方去实现。
 */
- (void)thirdPartypFromImageView:(UIImageView *)fromImgView
                 setImageWithKey:(NSString *)key
                        business:(NSString *)business
                placeholderImage:(UIImage *)placeholder
                            zoom:(CGSize)zoom
                    originalSize:(CGSize)originalSize
                        progress:(void (^)(double percentage,long long partialBytes,long long totalBytes))progress
                      completion:(void (^)(UIImage *image, NSError *error))complete
{
//    if(fromImgView && [fromImgView isKindOfClass:[UIImageView class]]) {
//        [fromImgView setImageWithKey:key business:business placeholderImage:placeholder zoom:zoom originalSize:originalSize progress:progress completion:complete];
//    }
}


- (void)thirdPartypGetImageByIdentifier:(NSString *)identifier
                                request:(APImageRequest *)request
                            viewInstant:(UIView *)viewInstants
                                    key:(NSString *)key
{
    if (!identifier) {
        return;
    }
    
    // 如果是本地图片则直接执行block
    if ([identifier containsString:@".bundle/"]) {
        APImageDownloadResponse *response = [[APImageDownloadResponse alloc] init];
        response.identifier = identifier;
        response.image = [UIImage imageNamed:identifier];
        if (request.downLoadCompletion) {
            request.downLoadCompletion(response);
        }
    }
//    APImageRequest *requestBackup = [request mutableCopy];
//    requestBackup.downLoadCompletion = ^(APImageDownloadResponse *response) {
//        if ([response.identifier isEqualToString:identifier]) {
//            request.downLoadCompletion(response);
//        } else {
//            request.downLoadCompletion(nil);
//        }
//    };
//    [[MPBadgeManager manager] getImage:identifier request:requestBackup];
}

/***********************************************************/
//红点协议MPBadgeService
/*
 初始化红点View
 */
- (UIView *) thirdPartyBadgeViewWithFrame:(CGRect)frame
{
    return [[MPBadgeView alloc] initWithFrame:frame];
}

/*
 红点设置widgetId
 
 */
- (void) thirdPartyBadgeViewWith:(UIView *)badgeView
                        widgetId:(NSString *) widgetId
{
    if(badgeView && [badgeView isKindOfClass:[MPBadgeView class]]) {
        MPBadgeView * tmpBadgeView =(MPBadgeView *)badgeView;
        tmpBadgeView.widgetId = widgetId;
    }

}
/*
 注册红点view到MPBadgeManager管理者去。
 */
- (void) thirdPartyBadgeViewReg:(UIView *)badgeView
{
    if(badgeView && [badgeView isKindOfClass:[MPBadgeView class]]) {
        MPBadgeView * tmpBadgeView =(MPBadgeView *)badgeView;
        [[MPBadgeManager sharedInstance] registerBadgeView:tmpBadgeView];
    }

}

/**
 * 更新显示“红点”样式
 * @param badgeView     红点View
 * @param badgeValue:  @"."   显示红点
 *                     @"new" 显示new
 *                     @"数字" 显示数字，大于99都显示图片more（...）
 *                     @"惠"/"hui"  显示“惠”字
 *                     @"xin" 显示"新"字
 *                     nil    清除当前显示
 *
 * @return 无
 */
- (void) thirdPartyBadgeViewWith:(UIView *)badgeView
                     updateValue:(NSString *)badgeValue
{
    if(badgeView && [badgeView isKindOfClass:[MPBadgeView class]]) {
        MPBadgeView * tmpBadgeView =(MPBadgeView *)badgeView;
        [tmpBadgeView updateBadgeValue:badgeValue];
    }
}

/*
 提供业务监控红点控件刷新接口。
 widgetInfo 类型是MPWidgetInfo
 */
- (void) thirdPartyBadgeViewWith:(UIView *)badgeView
                     updateBlock:(void(^)(id widgetInfo, BOOL isShow)) updateBlock
{
    if(badgeView && [badgeView isKindOfClass:[MPBadgeView class]]) {
        MPBadgeView * tmpBadgeView =(MPBadgeView *)badgeView;
        if(updateBlock) {
            tmpBadgeView.updateBlock = updateBlock;
        }
    }
    
}

/*
 埋点协议 APMonitor
 */
//按钮的actionName的埋点协议
- (void) thirdPartySetButtonActionLog:(UIButton *)button
                        actionNameLog:(NSString *)actionName
{
//    if(button && [button isKindOfClass:[UIButton class]]) {
//        button.actionName = actionName;
//    }
}

/*
 APLogInfo 埋点日志  APMobileFoundation.framework
 */
- (void) thirdPartyAPLogInfo:(NSString *)tag params:(NSString *)param, ...
{
    NSString *logString = nil;
    va_list args;
    va_start(args, param);
    logString = [[NSString alloc] initWithFormat:param arguments:args];
    va_end(args);
//    APLogInfo(tag, @"%@", logString);
}

- (void) thirdPartyAPLogInfo:(NSString *)tag log:(NSString *)log
{
    NSLog(@"tag:%@, log:%@", tag, log);
}

/*
 通知协议 (AUCardMenu/AUFloatMenu)
 */

/*
 AUCardMenu 注册退出登录的通知，保证退出登录AUCardMenu能够及时销毁
 */
- (NSString *) thirdPartyCardMenuDismissNotiName
{
    return @"SAAccountDidExitNotification";
}

/*
 AUFloatMenu 注册alerView kShareTokenAlertViewShownNotification
 */
- (NSString *) thirdPartyFloatMenuDismissFromAlertNotiName
{
    return @"kShareTokenAlertViewShownNotification";
}

/*
 AUFloatMenu 注册alerView SALoginAppWillStartNotification
 */
- (NSString *) thirdPartyFloatMenuDismissFromLoginNotiName
{
    return @"SALoginAppWillStartNotification";
}


- (NSString *)thirdParty_localizedStringForKey:(NSString *)key
                                  defaultValue:(NSString *)value
                                      inBundle:(NSString *)bundleName
{
    return value;
}


/////////////////////////////////////////////////////////////
//////////////////////  APLog   /////////////////////////////
/////////////////////////////////////////////////////////////


/**
 [APConfigService stringForKey]

 @param key 配置服务key
 @return 配置服务的value值
 */
- (NSString *)thirdParty_configForKey:(NSString *)key
{
    return nil;
}

/*
 * json 字符串解析，解析获取字典
 */
- (NSDictionary *) thirdParty_jsonString_deserialize:(NSString *)jsonString
{
//    return [jsonString JSONValue];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        @try {
            NSError *error;
            return [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        }@catch (NSException *exception) {
            NSLog(@"json data read fail!");
        }
    }
    return nil;
}


/////////////////////////////////////////////////////////////
//////////////////////  Lottie  /////////////////////////////
/////////////////////////////////////////////////////////////


- (UIView *)thirdPartyLottieViewWithFilePath:(NSString *)filePath
{
//    NSError *error = nil;
    LOTAnimationView *lotView = [LOTAnimationView animationWithFilePath:filePath];
//    if (error) {
//        MTBIZ_Report(@"BIZ_ANTUI",@"BIZ_ANTUI_AURefreshView",1,@{@"erro_description":[error description]?:@"",@"erro_domain":[error domain]?:@""});
//    } else if (!lotView || !lotView.sceneModel) {
//        MTBIZ_Report(@"BIZ_ANTUI",@"BIZ_ANTUI_AURefreshView",1,@{@"error_descri" : @"lottie view fial!"});
//    }
    lotView = lotView == nil ? [[LOTAnimationView alloc] init] : lotView;
    return lotView;
}


- (UIView *)thirdPartyLottieViewWithJsonString:(NSString *)jsonStr
{
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    LOTAnimationView *lotView;
    if (dic.count && !err) {
        lotView = [LOTAnimationView animationFromJSON:dic];
    } else if (err){
//        MTBIZ_Report(@"BIZ_ANTUI",@"BIZ_ANTUI_AURefreshView",1,@{@"erro_description":[err description]?:@"",@"erro_domain":[err domain]?:@""});
    } else {
//        MTBIZ_Report(@"BIZ_ANTUI",@"BIZ_ANTUI_AURefreshView",1,@{@"error_descri" : @"NSJSONSerialization fail!"});
    }
    lotView = lotView == nil ? [[LOTAnimationView alloc] init] : lotView;
    return lotView;
}

- (BOOL)thirdPartyLottieViewIsAnimationPlaying:(LOTAnimationView *)lottieView
{
    return [lottieView isAnimationPlaying];
}

- (void)thirdPartyLottieViewSetLoopAnimation:(LOTAnimationView *)lottieView animation:(BOOL)animation
{
    [lottieView setLoopAnimation:animation];
}

- (CGFloat)thirdPartyLottieViewAnimationProgress:(LOTAnimationView *)lottieView
{
    return [lottieView animationProgress];
}

- (void)thirdPartyLottieViewSetAnimationProgress:(LOTAnimationView *)lottieView
                                        progress:(CGFloat)progress
{
    [lottieView setAnimationProgress:progress];
}


- (void)thirdPartyLottieViewPlayFromProgress:(LOTAnimationView *)lottieView
                               beginProgress:(CGFloat)beginProgress
                                 endProgress:(CGFloat)endProgress

{
    [lottieView playFromProgress:beginProgress toProgress:endProgress withCompletion:nil];
}

- (void)thirdPartyLottieView:(LOTAnimationView *)lottieView
                currentFrame:(NSNumber *)currentFrame
{
#ifdef DEBUG
    NSLog(@"[AURefreshView], setProgressWithFrame, %f", [currentFrame floatValue]);
#endif
    [lottieView setProgressWithFrame:currentFrame];
}

- (void)thirdPartyLottieView:(LOTAnimationView *)lottieView
                  startFrame:(nonnull NSNumber *)startFrame
                     toFrame:(nonnull NSNumber *)toEndFrame
{
    [lottieView playFromFrame:startFrame toFrame:toEndFrame withCompletion:nil];
}

- (NSNumber *)thirdPartyLottieViewEndFrame:(LOTAnimationView *)lottieView
{
    return lottieView.sceneModel.endFrame;
}

- (NSNumber *_Nullable)thirdPartyLottieViewCurrentFrame:(LOTAnimationView *_Nullable)lottieView
{
    //#ifdef DEBUG
    //    return [NSNumber numberWithDouble:0.17171];
    //#else
    return lottieView.animationCurrentFrame;
    //#endif
}

- (void)thirdPartyLottieView:(LOTAnimationView *_Nullable)lottieView
                 playToFrame:(nonnull NSNumber *)toFrame
              withCompletion:(nullable LOTAnimationCompletionBlock)completion
{
    [lottieView playToFrame:toFrame withCompletion:completion];
}

- (void)thirdPartyLottieView:(LOTAnimationView *)lottieView
                  startFrame:(nonnull NSNumber *)startFrame
                     toFrame:(nonnull NSNumber *)toEndFrame
              withCompletion:(nullable LOTAnimationCompletionBlock)completion
{
    [lottieView playFromFrame:startFrame toFrame:toEndFrame withCompletion:completion];
}

- (BOOL)thirdPartyLottieViewReadFileFail:(LOTAnimationView *_Nullable)lottieView
{
    return lottieView == nil;
}

- (BOOL)thirdPartyLottieViewIsLoopAnimation:(LOTAnimationView *_Nullable)lottieView
{
    return [lottieView loopAnimation];
}

@end
