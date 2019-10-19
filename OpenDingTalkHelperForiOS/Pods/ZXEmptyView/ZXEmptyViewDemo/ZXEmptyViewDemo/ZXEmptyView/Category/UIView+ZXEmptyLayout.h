//
//  UIView+ZXEmptyLayout.h
//  ZXEmptyView
//
//  Created by ZXLee on 2019/10/2.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/ZXEmptyView

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZXEmptyLayout)
@property (assign,nonatomic) CGFloat zx_x;
@property (assign,nonatomic) CGFloat zx_y;
@property (assign,nonatomic) CGFloat zx_width;
@property (assign,nonatomic) CGFloat zx_height;
@property (assign,nonatomic) CGFloat zx_right;
@property (assign,nonatomic) CGFloat zx_bottom;
@property (assign,nonatomic) CGFloat zx_centerX;
@property (assign,nonatomic) CGFloat zx_centerY;
@property (assign,nonatomic) CGPoint zx_origin;
@property (assign,nonatomic) CGSize zx_size;
@end

NS_ASSUME_NONNULL_END
