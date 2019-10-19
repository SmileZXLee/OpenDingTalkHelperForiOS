//
//  NSObject+ZXEmptySwizzleMethod.h
//  ZXEmptyView
//
//  Created by ZXLee on 2019/10/5.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/ZXEmptyView

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZXEmptySwizzleMethod)

/**
 方法交换

 @param class 目标class
 @param originalSelector 初始的selector
 @param swizzledSelector 交换后的selector
 */
void zx_swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector);
@end

NS_ASSUME_NONNULL_END
