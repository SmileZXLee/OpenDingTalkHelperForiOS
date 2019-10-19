//
//  ZXEmptyDetailLabel.h
//  ZXEmptyView
//
//  Created by ZXLee on 2019/10/2.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/ZXEmptyView

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXEmptyDetailLabel : UILabel

/**
 固定detailLabel的宽度
 */
@property(assign,nonatomic)CGFloat zx_fixWidth;

/**
 固定detailLabel距离顶部高度（默认为10）
 */
@property(assign,nonatomic)CGFloat zx_fixTop;

/**
 固定detailLabel的高度
 */
@property(assign,nonatomic)CGFloat zx_fixHeight;

/**
 设置detailLabel的附加宽度（在原始宽度上增加）
 */
@property(assign,nonatomic)CGFloat zx_additionWidth;

/**
 设置detailLabel的附加高度（在原始高度上增加）
 */
@property(assign,nonatomic)CGFloat zx_additionHeight;

/**
 修改detailLabel的frame（当detailLabel的frame改变时调用此block）
 
 @param block 根据view原始frame(自动计算)，返回修改后的frame
 */
@property(copy,nonatomic)CGRect (^zx_handleFrame)(CGRect orgFrame);
@end

NS_ASSUME_NONNULL_END
