//
//  ZXEmptyTopImageView.h
//  ZXEmptyView
//
//  Created by ZXLee on 2019/10/2.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/ZXEmptyView

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZXEmptyTopImageView : UIImageView

/**
 固定imageView的宽度，高度根据图片比例自适应
 */
@property(assign,nonatomic)CGFloat zx_fixWidth;

/**
 固定imageView的高度，宽度根据图片比例自适应
 */
@property(assign,nonatomic)CGFloat zx_fixHeight;

/**
 固定imageView的Size
 */
@property(assign,nonatomic)CGSize zx_fixSize;

/**
 固定imageView距离顶部高度（默认为10）
 */
@property(assign,nonatomic)CGFloat zx_fixTop;

/**
 修改imageView的frame（当imageView的frame改变时调用此block）
 
 @param block 根据view原始frame(自动计算)，返回修改后的frame
 */
@property(copy,nonatomic)CGRect (^zx_handleFrame)(CGRect orgFrame);
@end

NS_ASSUME_NONNULL_END
