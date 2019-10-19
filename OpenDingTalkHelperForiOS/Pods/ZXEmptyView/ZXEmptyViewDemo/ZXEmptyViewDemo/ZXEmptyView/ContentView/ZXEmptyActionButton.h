//
//  ZXEmptyActionButton.h
//  ZXEmptyView
//
//  Created by ZXLee on 2019/10/2.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/ZXEmptyView

#import <UIKit/UIKit.h>
typedef void (^ __nullable zx_clickedBlock)(UIButton *_Nullable btn);
NS_ASSUME_NONNULL_BEGIN

@interface ZXEmptyActionButton : UIButton

/**
 固定actionButton的宽度
 */
@property(assign,nonatomic)CGFloat zx_fixWidth;

/**
 固定actionButton的高度
 */
@property(assign,nonatomic)CGFloat zx_fixHeight;

/**
 设置actionButton的附加宽度（在原始宽度上增加）
 */
@property(assign,nonatomic)CGFloat zx_additionWidth;

/**
 设置actionButton的附加高度（在原始高度上增加）
 */
@property(assign,nonatomic)CGFloat zx_additionHeight;

/**
 固定actionButton距离顶部高度（默认为10）
 */
@property(assign,nonatomic)CGFloat zx_fixTop;

/**
 修改actionButton的frame（当actionButton的frame改变时调用此block）
 
 @param block 根据view原始frame(自动计算)，返回修改后的frame
 */
@property(copy,nonatomic)CGRect (^zx_handleFrame)(CGRect orgFrame);


/**
 actionButton点击后的回调

 @param block 点击后的回调
 */
- (void)zx_clickedBlock:(zx_clickedBlock)block;


/**
 为actionButton添加点击事件

 @param target target
 @param sel sel
 */
- (void)zx_addTarget:(id)target action:(SEL)sel;


/**
 按钮是否已经添加了点击事件回调或action
 */
@property(assign,nonatomic,readonly)BOOL zx_addedClickCallBackOrAction;

/**
 当按钮被点击了触发此block，请使用zx_clickedBlock方法
 */
@property(copy,nonatomic)void (^zx_hanldeClickedBlock)(UIButton *btn);
@end

NS_ASSUME_NONNULL_END
