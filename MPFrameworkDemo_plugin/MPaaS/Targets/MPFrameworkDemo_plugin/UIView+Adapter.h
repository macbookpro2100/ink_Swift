//
//  UIView+Adapter.h
//  MPFrameworkDemo_plugin
//
//  Created by macbookpro2100 on 5/14/20.
//  Copyright © macbookpro2100 All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Adapter)

/**
 * Shortcut for frame.origin
 */
@property(nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property(nonatomic) CGSize size;
@end

NS_ASSUME_NONNULL_END
