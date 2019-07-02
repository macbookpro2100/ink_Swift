//
//  MPDataCenterTestCase.m
//  MPDataCenterDemo
//
//  Created by kuoxuan on 2019/2/27.
//  Copyright © 2019 alipay. All rights reserved.
//

#import "MPDataCenterTestCase.h"
#import <MPDataCenter/MPDataCenter.h>

# define  dataBusiness @"dataTestCase"

@protocol DemoProtocol <APDAOProtocol>
- (APDAOResult*)insertItem:(NSString*)content;
- (NSString*)getItem:(NSNumber*)index;
@end

@implementation MPDataCenterTestCase


+ (void)runKVStorageTest
{
    [APCommonPreferences setInteger:11 forKey:@"intkey" business:dataBusiness];
    NSInteger intValue = [APCommonPreferences integerForKey:@"intkey" business:dataBusiness];
    assert(intValue == 11);
    NSAssert(intValue == 11, @"Integer存储检测不通过");
    
    [APCommonPreferences setDouble:11.11 forKey:@"doubleKey" business:dataBusiness];
    double doubleValue = [APCommonPreferences doubleForKey:@"doubleKey" business:dataBusiness];
    NSAssert(doubleValue == 11.11, @"Double存储检测不通过");

    [APCommonPreferences setString:@"helloDataCenter" forKey:@"strKey" business:dataBusiness];
    NSString *str = [APCommonPreferences stringForKey:@"strKey" business:dataBusiness];
    NSAssert([str isEqualToString:@"helloDataCenter"], @"String存储检测不通过");

    [APCommonPreferences setObject:@{@"hello": @"data"} forKey:@"plistObjectKey" business:dataBusiness];
    NSDictionary *dict = [APCommonPreferences objectForKey:@"plistObjectKey" business:dataBusiness];
    NSAssert([@"data" isEqualToString:[dict objectForKey:@"hello"]], @"PList对象存储检不通过");

    MPCodingData *obj = [MPCodingData new];
    obj.name = @"hello";
    obj.age = 12;
    [APCommonPreferences archiveObject:obj forKey:@"archObjKey" business:dataBusiness];
    MPCodingData *encodeObj = [APCommonPreferences objectForKey:@"archObjKey" business:dataBusiness];
    NSAssert([encodeObj.name isEqualToString:@"hello"] && encodeObj.age == 12, @"Archive对象存储检测不通过");

}


+ (void)runLRUTest
{
    APLRUMemoryCache *mCache = [[APLRUMemoryCache alloc] initWithCapacity:10];
    [mCache setObject:@"vv" forKey:@"key"];
    NSString *str = [mCache objectForKey:@"key"];
    NSAssert([str isEqualToString:@"vv"], @"LRU Memory检测不通过");

    APLRUDiskCache *dCache = [[APLRUDiskCache alloc] initWithName:@"diskCache" capacity:100 userDependent:NO crypted:NO];
    [dCache setObject:@"vvd" forKey:@"key"];
    NSAssert([@"vvd" isEqualToString:[dCache objectForKey:@"key"]], @"LRU Disk检测不通过");

}

@end


@implementation MPCodingData

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    MPCodingData *data = [MPCodingData new];
    data.name = [aDecoder decodeObjectForKey:@"name"];
    data.age = [aDecoder decodeIntegerForKey:@"age"];
    return data;
}

@end
