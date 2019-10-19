//
//  UILabel+ZXGetStringSize.h
//  ZXEmptyView
//
//  Created by ZXLee on 2019/10/4.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/ZXEmptyView

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (ZXGetStringSize)

/**
 获取普通text的高度

 @return 普通text的高度
 */
- (CGFloat)zx_getNormalStringHeight;

/**
 获取普通Text的宽度

 @return 普通Text的宽度
 */
- (CGFloat)zx_getNormalStringWidth;

/**
 获取attrString的高度

 @return attrString的高度
 */
- (CGFloat)zx_getAttrStringHeight;

/**
 获取attrString的宽度

 @return attrString的宽度
 */
- (CGFloat)zx_getAttrStringWidth;

/**
 获取普通Text的高度

 @param fixWidth 固定宽
 @return 普通Text的高度
 */
- (CGFloat)zx_getNormalStringHeightWithFixWidth:(CGFloat)fixWidth;

/**
 获取attrString的高度

 @param fixWidth 固定宽
 @return attrString的高度
 */
- (CGFloat)zx_getAttrStringHeightWithFixWidth:(CGFloat)fixWidth;

/**
 获取普通Text的宽度

 @param fixHeight 固定高
 @return 普通Text的宽度
 */
- (CGFloat)zx_getNormalStringWidthWithFixHeight:(CGFloat)fixHeight;

/**
 获取attrString的宽度
 
 @param fixHeight 固定高
 @return attrString的宽度
 */
- (CGFloat)zx_getAttrStringWidthWithFixHeight:(CGFloat)fixHeight;
@end

NS_ASSUME_NONNULL_END
