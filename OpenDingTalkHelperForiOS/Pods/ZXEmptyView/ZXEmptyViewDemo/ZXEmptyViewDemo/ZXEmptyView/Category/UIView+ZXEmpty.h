//
//  UIView+ZXEmpty.h
//  ZXEmptyView
//
//  Created by ZXLee on 2019/10/5.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/ZXEmptyView

#import <UIKit/UIKit.h>
#import "ZXEmptyContentView.h"
#import "UIView+ZXEmptyLayout.h"
typedef CGRect (^zx_updateFrameBlock)(CGRect orgFrame);
typedef void(^__nullable zx_emptyViewClickedBlock)(UIView * _Nullable btn);
NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZXEmpty)

/**
 为当前view设置根据内容自适应大小的emptyView，且不填充满整个view

 @param emptyViewObj ZXEmptyContentView(或继承于它)对象(id)或ZXEmptyContentView(或继承于它)的class(Class)或ZXEmptyContentView(或继承于它)对象的class名(NSString)
 */
- (void)zx_setEmptyView:(id)emptyViewObj;

/**
 为当前view设置根据内容自适应大小的emptyView

 @param emptyViewObj ZXEmptyContentView(或继承于它)对象(id)或ZXEmptyContentView(或继承于它)的class(Class)或ZXEmptyContentView(或继承于它)对象的class名(NSString)
 @param isFull emptyView是否填充满整个view，默认为否
 */
- (void)zx_setEmptyView:(id)emptyViewObj isFull:(BOOL)isFull;

/**
 为当前view设置根据内容自适应大小的emptyView
 
 @param emptyViewObj ZXEmptyContentView(或继承于它)对象(id)或ZXEmptyContentView(或继承于它)的class(Class)或ZXEmptyContentView(或继承于它)对象的class名(NSString)
 @param isFull emptyView是否填充满整个view，默认为否
 @param clickedBlock 点击了actionBtn回调
 */
- (void)zx_setEmptyView:(id)emptyViewObj isFull:(BOOL)isFull clickedBlock:(zx_clickedBlock)clickedBlock;

/**
 为当前view设置根据内容自适应大小的emptyView
 
 @param emptyViewObj ZXEmptyContentView(或继承于它)对象(id)或ZXEmptyContentView(或继承于它)的class(Class)或ZXEmptyContentView(或继承于它)对象的class名(NSString)
 @param isFull emptyView是否填充满整个view，默认为否
 @param clickedBlock clickedBlock 点击了actionBtn回调
 @param emptyViewClickedBlock 点击了emptyView回调
 */
- (void)zx_setEmptyView:(id)emptyViewObj isFull:(BOOL)isFull clickedBlock:(zx_clickedBlock)clickedBlock emptyViewClickedBlock:(zx_emptyViewClickedBlock)emptyViewClickedBlock;

/**
 为当前view设置根据内容自适应大小的emptyView

 @param emptyViewObj ZXEmptyContentView(或继承于它)对象(id)或ZXEmptyContentView(或继承于它)的class(Class)或ZXEmptyContentView(或继承于它)对象的class名(NSString)
 @param isFull emptyView是否填充满整个view，默认为否
 @param target actionbtn点击target
 @param sel actionbtn点击selector
 */
- (void)zx_setEmptyView:(id)emptyViewObj isFull:(BOOL)isFull clickedTarget:(id)target selector:(SEL)sel;

/**
 为当前view设置根据内容自适应大小的emptyView
 
 @param emptyViewObj ZXEmptyContentView(或继承于它)对象(id)或ZXEmptyContentView(或继承于它)的class(Class)或ZXEmptyContentView(或继承于它)对象的class名(NSString)
 @param isFull emptyView是否填充满整个view，默认为否
 @param target emptyView点击target
 @param sel emptyView点击selector
 */
- (void)zx_setEmptyView:(id)emptyViewObj isFull:(BOOL)isFull emptyViewClickedTarget:(id)target selector:(SEL)sel;

/**
 为当前view设置完全自定义的emptyView

 @param customView 自定义的emptyView
 */
- (void)zx_setCustomEmptyView:(id)customView;


/**
 为当前view设置完全自定义的emptyView

 @param customView 自定义的emptyView
 @param isFull emptyView是否填充满整个view，默认为否
 */
- (void)zx_setCustomEmptyView:(id)customView isFull:(BOOL)isFull;

/**
 修改emptyView或其内部view的frame（当emptyView或其内部view的frame改变时调用此block）

 @param block 根据view原始frame(自动计算)，返回修改后的frame
 */
- (void)zx_updateFrame:(zx_updateFrameBlock)block;

/**
 获取属于当前view的emptyView
 */
@property(weak,nonatomic,readonly)ZXEmptyContentView *zx_emptyContentView;

/**
 完全挡住目标view的EmptyView(emptyView的superView)
 */
@property(weak,nonatomic,readonly)ZXFullEmptyView *zx_fullEmptyView;
@end

NS_ASSUME_NONNULL_END
