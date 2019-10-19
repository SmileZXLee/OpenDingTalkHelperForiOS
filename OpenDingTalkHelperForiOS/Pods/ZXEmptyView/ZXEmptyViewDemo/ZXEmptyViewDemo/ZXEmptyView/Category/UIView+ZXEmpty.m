//
//  UIView+ZXEmpty.m
//  ZXEmptyView
//
//  Created by ZXLee on 2019/10/5.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/ZXEmptyView

#import "UIView+ZXEmpty.h"
#import <objc/runtime.h>
#import "UIView+ZXEmptyViewKVO.h"
#import "NSObject+ZXEmptySwizzleMethod.h"
static NSString *emptyContentViewKey = @"zx_emptyContentViewKey";
static NSString *fullEmptyViewKey = @"zx_fullEmptyViewKey";
@implementation UIView (ZXEmpty)

#pragma mark - 初始化方法
- (void)zx_setCustomEmptyView:(id)customView{
    [self zx_setEmptyView:[ZXEmptyContentView class]];
    self.zx_emptyContentView.zx_customView = customView;
}

- (void)zx_setCustomEmptyView:(id)customView isFull:(BOOL)isFull{
    [self zx_setEmptyView:[ZXEmptyContentView class] isFull:isFull];
    self.zx_emptyContentView.zx_customView = customView;
}

- (void)zx_setEmptyView:(id)emptyViewObj{
    [self zx_setEmptyView:emptyViewObj isFull:NO];
}
- (void)zx_setEmptyView:(id)emptyViewObj isFull:(BOOL)isFull{
    ZXEmptyContentView *contentView;
    if([emptyViewObj isKindOfClass:[NSString class]]){
        Class cls = NSClassFromString(emptyViewObj);
        if(cls){
            contentView = [[cls alloc]init];
        }
        
    }else if([emptyViewObj respondsToSelector:@selector(new)]){
        contentView = [[((Class)emptyViewObj) alloc]init];
    }else if([emptyViewObj isKindOfClass:[ZXEmptyContentView class]]){
        contentView = emptyViewObj;
    }
    if(!contentView || ![contentView isKindOfClass:[ZXEmptyContentView class]]){
        NSAssert(NO, @"参数contentObj必需是ZXEmptyContentView(或继承于它)对象(id)或ZXEmptyContentView(或继承于它)的class(Class)或ZXEmptyContentView(或继承于它)对象的class名(NSString)");
    }
    if(isFull){
        [self setFullEmptyView:contentView];
    }else{
        [self setEmptyView:contentView];
    }
}

- (void)zx_setEmptyView:(id)emptyViewObj isFull:(BOOL)isFull clickedBlock:(zx_clickedBlock)clickedBlock{
    [self zx_setEmptyView:emptyViewObj isFull:isFull];
    self.zx_emptyContentView.zx_btnClickedBlock = clickedBlock;
}

- (void)zx_setEmptyView:(id)emptyViewObj isFull:(BOOL)isFull clickedBlock:(zx_clickedBlock)clickedBlock emptyViewClickedBlock:(zx_emptyViewClickedBlock)emptyViewClickedBlock{
    [self zx_setEmptyView:emptyViewObj isFull:isFull];
    self.zx_emptyContentView.zx_btnClickedBlock = clickedBlock;
    self.zx_emptyContentView.zx_emptyViewClickedBlock = emptyViewClickedBlock;
}

- (void)zx_setEmptyView:(id)emptyViewObj isFull:(BOOL)isFull clickedTarget:(id)target selector:(SEL)sel{
    [self zx_setEmptyView:emptyViewObj isFull:isFull];
    [self.zx_emptyContentView zx_btnAddTarget:target action:sel];
}

- (void)zx_setEmptyView:(id)emptyViewObj isFull:(BOOL)isFull emptyViewClickedTarget:(id)target selector:(SEL)sel{
    [self zx_setEmptyView:emptyViewObj isFull:isFull];
    [self.zx_emptyContentView zx_emptyViewAddTarget:target action:sel];
}

#pragma mark - public

- (void)zx_updateFrame:(zx_updateFrameBlock)block{
    if([self isKindOfClass:[ZXEmptyContentView class]]){
        [((ZXEmptyContentView *)self) setNeedsLayout];
        ((ZXEmptyContentView *)self).zx_handleFrame = block;
    }else if([self isKindOfClass:[ZXEmptyTopImageView class]]){
        [((ZXEmptyTopImageView *)self).superview setNeedsLayout];
        ((ZXEmptyTopImageView *)self).zx_handleFrame = block;
    }else if([self isKindOfClass:[ZXEmptyTitleLabel class]]){
        [((ZXEmptyTitleLabel *)self).superview setNeedsLayout];
        ((ZXEmptyTitleLabel *)self).zx_handleFrame = block;
    }else if([self isKindOfClass:[ZXEmptyActionButton class]]){
        [((ZXEmptyActionButton *)self).superview setNeedsLayout];
        ((ZXEmptyActionButton *)self).zx_handleFrame = block;
    }
}
#pragma mark - getter & setter
- (void)setZx_emptyContentView:(ZXEmptyContentView *)emptyContentView {
    objc_setAssociatedObject(self, &emptyContentViewKey, emptyContentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ZXEmptyContentView *)zx_emptyContentView{
    return objc_getAssociatedObject(self, &emptyContentViewKey);
}

- (void)setZx_fullEmptyView:(ZXFullEmptyView *)fullEmptyView {
    objc_setAssociatedObject(self, &fullEmptyViewKey, fullEmptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ZXFullEmptyView *)zx_fullEmptyView{
    return objc_getAssociatedObject(self, &fullEmptyViewKey);
}

#pragma mark - private
#pragma mark 移除旧的emptyView
- (void)removeOldEmptyView{
    for (UIView *subView in self.subviews) {
        if([subView isKindOfClass:[ZXFullEmptyView class]] || [subView isKindOfClass:[ZXEmptyContentView class]]){
            [subView removeFromSuperview];
            break;
        }
    }
}

- (void)setEmptyView:(ZXEmptyContentView *)contentView{
    [self removeOldEmptyView];
    [self addSubview:contentView];
    [self setZx_emptyContentView:contentView];
}

- (void)setFullEmptyView:(ZXEmptyContentView *)contentView{
    [self removeOldEmptyView];
    ZXFullEmptyView *emptyView = [[ZXFullEmptyView alloc]init];
    emptyView.backgroundColor = [UIColor whiteColor];
    self.zx_fullEmptyView = emptyView;
    emptyView.frame = self.bounds;
    [emptyView addSubview:contentView];
    [self addSubview:emptyView];
    [self setZx_emptyContentView:contentView];
}


@end
