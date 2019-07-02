//
//  MPDataCenterTestCase.h
//  MPDataCenterDemo
//
//  Created by kuoxuan on 2019/2/27.
//  Copyright © 2019 alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPDataCenterTestCase : NSObject
+ (void)runKVStorageTest;
+ (void)runLRUTest;
@end

@interface MPCodingData : NSObject <NSCoding>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@end

NS_ASSUME_NONNULL_END
