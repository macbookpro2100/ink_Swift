//
//  DTFrameworkInterface+MPFrameworkDemo_plugin.m
//  MPFrameworkDemo_plugin
//
//  Created by vivi.yw on 2019/03/28.
//  Copyright © 2019 Alibaba. All rights reserved.
//

#import "DTFrameworkInterface+MPFrameworkDemo_plugin.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

@implementation DTFrameworkInterface (MPFrameworkDemo_plugin)

- (BOOL)shouldLogReportActive
{
    return YES;
}

- (NSTimeInterval)logReportActiveMinInterval
{
    return 0;
}

- (BOOL)shouldLogStartupConsumption
{
    return YES;
}

- (BOOL)shouldAutoactivateBandageKit
{
    return YES;
}

- (BOOL)shouldAutoactivateShareKit
{
    return YES;
}

- (DTNavigationBarBackTextStyle)navigationBarBackTextStyle
{
    return DTNavigationBarBackTextStyleAlipay;
}


- (DTFrameworkCallbackResult)application:(UIApplication *)application openURL:(NSURL *)url newURL:(NSURL **)newURL sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

    if (url) {
        NSString *fileName = url.lastPathComponent; // 从路径中获得完整的文件名（带后缀）
        // path 类似这种格式：file:///private/var/mobile/Containers/Data/Application/83643509-E90E-40A6-92EA-47A44B40CBBF/Documents/Inbox/jfkdfj123a.pdf
        NSString *path = url.absoluteString; // 完整的url字符串
        path = [self URLDecodedString:path]; // 解决url编码问题

        NSMutableString *string = [[NSMutableString alloc] initWithString:path];

        if ([path hasPrefix:@"file://"]) { // 通过前缀来判断是文件
            // 去除前缀：/private/var/mobile/Containers/Data/Application/83643509-E90E-40A6-92EA-47A44B40CBBF/Documents/Inbox/jfkdfj123a.pdf
            [string replaceOccurrencesOfString:@"file://" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, path.length)];
            //
            //            // 此时获取到文件存储在本地的路径，就可以在自己需要使用的页面使用了
            //            NSDictionary *dict = @{@"fileName": fileName,
            //                    @"filePath": string};
            //            [[NSNotificationCenter defaultCenter] postNotificationName:@"FileNotification" object:nil userInfo:dict];

            // save 本地Doucument

//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//            NSString *documentsDirectory = [paths lastObject];
//
//            NSString *targetItemPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
//            NSLog(@"targetItemPath %@",targetItemPath);
//            NSFileManager *fileManage = [NSFileManager defaultManager];
//
//            if (![fileManage fileExistsAtPath:targetItemPath]) {
//                BOOL isSuccess = [fileManage copyItemAtPath:string toPath:targetItemPath error:nil];
//                NSLog(@"name=%@ %@",fileName,isSuccess ? @"✅拷贝成功" : @"拷贝失败");
//            }
            return DTFrameworkCallbackResultReturnYES;
        }
    }
    return DTFrameworkCallbackResultReturn;
}


// 当文件名为中文时，解决url编码问题
- (NSString *)URLDecodedString:(NSString *)str {
    NSString *decodedString = (__bridge_transfer NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef) str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    APLogDebug(@"File", @"decodedString = %@", decodedString);
    return decodedString;
}
//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fileNotification:) name:@"FileNotification" object:nil];

- (void)fileNotification:(NSNotification *)notifcation {
    NSDictionary *info = notifcation.userInfo;
    // fileName是文件名称、filePath是文件存储在本地的路径
    // jfkdfj123a.pdf
    NSString *fileName = [info objectForKey:@"fileName"];
    // /private/var/mobile/Containers/Data/Application/83643509-E90E-40A6-92EA-47A44B40CBBF/Documents/Inbox/jfkdfj123a.pdf
    NSString *filePath = [info objectForKey:@"filePath"];

    NSLog(@"fileName=%@---filePath=%@", fileName, filePath);
}
@end

#pragma clang diagnostic pop
