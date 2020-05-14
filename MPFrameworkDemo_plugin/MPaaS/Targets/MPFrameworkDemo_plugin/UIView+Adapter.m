//
//  UIView+Adapter.m
//  MPFrameworkDemo_plugin
//
//  Created by macbookpro2100 on 5/14/20.
//  Copyright © macbookpro2100 All rights reserved.
//

#import "UIView+Adapter.h"

//#import <AppKit/AppKit.h>
#import <AntUI/UIView+Helper.h>

@implementation UIView (Adapter)

- (CGPoint)origin {
    return self.origin_mp;
}

- (CGSize)size {
    return self.size_mp;
}
@end
