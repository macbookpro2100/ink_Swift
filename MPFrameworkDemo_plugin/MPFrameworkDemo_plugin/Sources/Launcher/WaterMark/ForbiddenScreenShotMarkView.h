//
//  ForbiddenScreenShotMarkView.h
//  MPFrameworkDemo_plugin
//
//  Created by macbookpro2100 on 12/20/19.
//  Copyright © 2019 macbookpro2100. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForbiddenScreenShotMarkView : UIView
- (id)initWithFrame:(CGRect)frame textColor:(UIColor *)color alpha:(CGFloat)alpha;

- (void)setWaterMarkIsAllowScreenShot:(BOOL)isAllowScreenShot;
@end

NS_ASSUME_NONNULL_END
