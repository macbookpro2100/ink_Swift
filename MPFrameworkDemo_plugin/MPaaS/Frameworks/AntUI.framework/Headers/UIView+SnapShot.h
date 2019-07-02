//
//  UIView+SnapShot.h
//  MobileFoundation
//
//  Created by 孟嵩 on 15/11/2.
//  Copyright © 2015年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SnapShot)
- (UIImage *)snapShot;
- (UIImage *)snapShotWithSize:(CGSize)size;

- (UIImage *)snapShotOnIOS8WithSize:(CGSize)size
                     scaleInContext:(CGFloat)scaleInContext
                      scaleForImage:(CGFloat)scaleForImage;

- (UIImage *)snapShotWithSize:(CGSize)size
               scaleInContext:(CGFloat)scaleInContext
                scaleForImage:(CGFloat)scaleForImage;
@end
