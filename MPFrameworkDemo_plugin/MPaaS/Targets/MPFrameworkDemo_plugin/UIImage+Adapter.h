//
//  UIImage+Adapter.h
//  MPFrameworkDemo_plugin
//
//  Created by macbookpro2100 on 5/14/20.
//  Copyright © macbookpro2100 All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Adapter)


/**
 *  生成1*1像素的纯色图片
 */
//+ (UIImage *)imageWithColor1x1_au:(UIColor *)color;
+ (UIImage *)imageWithColor1x1:(UIColor *)color;

/**
 *  生成指定尺寸的纯色图片
 */
//+ (UIImage *)imageWithColor_au:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  设置图片透明度
 */
//+ (UIImage *)imageByApplyingAlpha_au:(CGFloat)alpha image:(UIImage*)image;

+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha image:(UIImage *)image;







/**
 注册iconfont（只需要调用一次）
 
 @param fontName iconfont字体名称
 @param fontPath iconfont路径（支持绝对和相对路径等，如@"APCommonUI.bundle/iconfont/auiconfont"）
 */
//+ (void)registerIconFont_au:(NSString *)fontName fontPath:(NSString *)fontPath;


+ (void)registerIconFont:(NSString *)fontName fontPath:(NSString *)fontPath;

/**
 获取一个正方形矢量图（长和宽相等）
 
 @param name  名称
 @param width 大小
 @param color 图像颜色，传nil，默认为蚂蚁蓝
 
 @return 正方形矢量图
 */
//+ (UIImage *)iconWithName_au:(NSString *)name
//                    width:(CGFloat)width
//                    color:(UIColor *)color;

+ (UIImage *)iconWithName:(NSString *)name
                    width:(CGFloat)width
                    color:(UIColor *)color;


/**
 获取一个正方形矢量图（长和宽相等）
 
 @param name        名称
 @param fontName    矢量字体名称
 @param width       大小
 @param color       图像颜色，传nil，默认为蚂蚁蓝
 
 @return 正方形矢量图
 */
//+ (UIImage *)iconWithName_au:(NSString *)name
//                 fontName:(NSString *)fontName
//                    width:(CGFloat)width
//                    color:(UIColor *)color;

+ (UIImage *)iconWithName:(NSString *)name
                 fontName:(NSString *)fontName
                    width:(CGFloat)width
                    color:(UIColor *)color;

/**
 获取一个正方形矢量图（长和宽相等）
 
 @param name        名称
 @param fontName    矢量字体名称
 @param width       大小
 @param color       图像颜色，传nil，默认为蚂蚁蓝
 @param alpha       图像透明度，0 ~ 1
 
 @return 正方形矢量图
 */
//+ (UIImage *)iconWithName_au:(NSString *)name
//                 fontName:(NSString *)fontName
//                    width:(CGFloat)width
//                    color:(UIColor *)color
//                    alpha:(CGFloat)alpha;

+ (UIImage *)iconWithName:(NSString *)name
                 fontName:(NSString *)fontName
                    width:(CGFloat)width
                    color:(UIColor *)color
                    alpha:(CGFloat)alpha;


/**
 取消iconfont注册
 如果是已经在info.plist里面配置，则此方法不生效
 
 @param fontName 字体名称
 @param fontPath iconfont路径（支持绝对和相对路径等，如@"APCommonUI.bundle/iconfont/auiconfont"）
 */
//+ (void)unregisterIconFont_au:(NSString *)fontName fontPath:(NSString *)fontPath;

+ (void)unregisterIconFont:(NSString *)fontName fontPath:(NSString *)fontPath;


/**
 iconfont是否包含该图标
 
 @param name 图标名称
 @param fontName 字体名称
 @return YES，包含；NO，不包含
 */
//+ (BOOL)isIconExists_au:(NSString *)name inFont:(NSString *)fontName;

+ (BOOL)isIconExists:(NSString *)name inFont:(NSString *)fontName;


/**
 iconfont://antui?id=iconfont_more_ios&size=20&color=%23ffffffff
 如果不是一个合法的iconfontURL，则返回nil，否则返回UIImage对象
 包含四个参数：font(可省略)、color、id、size
 
 @return iconfont
 */
//+ (UIImage *)iconFromURLString_au:(NSString *)urlString;

+ (UIImage *)iconFromURLString:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
