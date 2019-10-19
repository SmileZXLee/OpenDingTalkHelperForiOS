//
//  ZXEmptyContentView.h
//  ZXEmptyView
//
//  Created by ZXLee on 2019/10/4.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/ZXEmptyView

#import <UIKit/UIKit.h>
#import "ZXFullEmptyView.h"
#import "ZXEmptyTopImageView.h"
#import "ZXEmptyTitleLabel.h"
#import "ZXEmptyDetailLabel.h"
#import "ZXEmptyActionButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZXEmptyContentView : UIView
/**
 emptyView中的顶部ImageView
 */
@property(weak, nonatomic)ZXEmptyTopImageView *zx_topImageView;

/**
 emptyView中的标题label
 */
@property(weak, nonatomic)ZXEmptyTitleLabel *zx_titleLabel;

/**
 emptyView中的描述label
 */
@property(weak, nonatomic)ZXEmptyDetailLabel *zx_detailLabel;

/**
 emptyView中的点击按钮
 */
@property(weak, nonatomic)ZXEmptyActionButton *zx_actionBtn;

/**
 emptyView中的自定义View
 */
@property(strong, nonatomic)UIView *zx_customView;

/**
 完全挡住目标view的EmptyView(emptyView的superView)
 */
@property(strong, nonatomic)ZXFullEmptyView *zx_fullEmptyView;

/**
 自动显示/隐藏emptyView，默认为YES（emptyView所属视图为TableView或CollectionView时生效）
 */
@property(assign, nonatomic)BOOL zx_autoShowEmptyView;

/**
 没有数据的时候根据headerView高度自动调整emptyView位置，默认为YES（emptyView所属视图为TableView或CollectionView时生效）
 */
@property(assign, nonatomic)BOOL zx_autoAdjustWhenHeaderView;

/**
 没有数据的时候根据footerView高度自动调整emptyView位置，默认为YES（emptyView所属视图为TableView或CollectionView时生效）
 */
@property(assign, nonatomic)BOOL zx_autoAdjustWhenFooterView;

/**
 子类可重写此方法并在其中进行初始化设置
 */
- (void)zx_customSetting;

/**
 emptyView 距离顶部的固定高度（默认水平居中）
 */
@property(assign,nonatomic)CGFloat zx_fixTop;

/**
 emptyView 距离左侧的固定高度（默认垂直居中）
 */
@property(assign,nonatomic)CGFloat zx_fixLeft;

/**
 emptyView的固定宽度(默认为：若子控件中最宽的小于superView - 2 * 10，则为子控件中最宽的宽度，否则为superView - 2 * 10)，若修改这个值，子控件宽度会根据需要自动压缩，同时高度调整
 */
@property(assign,nonatomic)CGFloat zx_fixWidth;

/**
 设置emptyView的附加宽度（在原始宽度上增加）
 */
@property(assign,nonatomic)CGFloat zx_additionWidth;


/**
 emptyView的subviews距离底部的高度（默认为10）
 */
@property(assign,nonatomic)CGFloat zx_subviewsMarginBottom;

/**
 emptyView的subviews之间的间隙（默认为10）
 */
@property(assign,nonatomic)CGFloat zx_defaultSubviewsSpace;

/**
 为actionBtn添加点击事件
 */
- (void)zx_btnAddTarget:(id)target action:(SEL)sel;
/**
 emptyView中的按钮点击回调
 */
@property(copy,nonatomic)void(^zx_btnClickedBlock)(UIButton *sender);

/**
 为emptyView添加点击事件
 
 @param target target
 @param sel sel
 */
- (void)zx_emptyViewAddTarget:(id)target action:(SEL)sel;

/**
 emptyView点击回调
 */
@property(copy,nonatomic)void(^zx_emptyViewClickedBlock)(UIView *sender);

/**
 修改emptyView的frame（当emptyView的frame改变时调用此block）
 
 @param block 根据view原始frame(自动计算)，返回修改后的frame
 */
@property(copy,nonatomic)CGRect (^zx_handleFrame)(CGRect orgFrame);

/**
 显示当前emptyView
 */
- (void)zx_show;

/**
 隐藏当前emptyView
 */
- (void)zx_hide;


/**
 这个属性用于子类继承的时候记录当前emptyView的类型，并根据不同类型进行不同的个性化设置
 */
@property(assign,nonatomic)int zx_type;
/**
 当点击了emptyView或其中的按钮是否自动隐藏emptyView，默认为YES，自动隐藏的规则为:若设置了tap事件回调，则tap时隐藏emptyView；点击actionBtn时必隐藏emptyView；默认为YES
 */
@property(assign,nonatomic)BOOL zx_autoHideWhenTapOrClick;
@end

NS_ASSUME_NONNULL_END
