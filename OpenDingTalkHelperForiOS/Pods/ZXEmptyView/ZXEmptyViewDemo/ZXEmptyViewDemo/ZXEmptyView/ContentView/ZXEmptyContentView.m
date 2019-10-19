//
//  ZXEmptyContentView.m
//  ZXEmptyView
//
//  Created by ZXLee on 2019/10/4.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/ZXEmptyView

#import "ZXEmptyContentView.h"
#import "UIView+ZXEmptyLayout.h"
#import "UILabel+ZXGetStringSize.h"
#import "UIView+ZXEmptyViewKVO.h"
#define ZXOrgFixSpace 10
#define ZXFixSpace [self getFixSpace]
#define ZXSpace(val) [self getSubviewsSpace:val]
@interface ZXEmptyContentView()
@property(strong,nonatomic)id tapSender;
@property(assign,nonatomic)SEL tapSel;
@end
@implementation ZXEmptyContentView
#pragma mark - 生命周期
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.zx_autoShowEmptyView = YES;
        self.zx_autoAdjustWhenHeaderView = YES;
        self.zx_autoAdjustWhenFooterView = YES;
        self.zx_autoHideWhenTapOrClick = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight;
        //初始化顶部的imageView
        ZXEmptyTopImageView *topImageView = [[ZXEmptyTopImageView alloc]init];
        topImageView.frame = CGRectZero;
        topImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:topImageView];
        self.zx_topImageView = topImageView;
        
        //初始化titleLabel
        ZXEmptyTitleLabel *titleLabel = [[ZXEmptyTitleLabel alloc]init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        titleLabel.frame = CGRectZero;
        [self addSubview:titleLabel];
        self.zx_titleLabel = titleLabel;
        
        //初始化detailLabel
        ZXEmptyDetailLabel *detailLabel = [[ZXEmptyDetailLabel alloc]init];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.numberOfLines = 0;
        detailLabel.frame = CGRectZero;
        [self addSubview:detailLabel];
        self.zx_detailLabel = detailLabel;
        
        //初始化actionBtn
        __weak typeof(self) weakSelf = self;
        ZXEmptyActionButton *actionBtn = [[ZXEmptyActionButton alloc]init];
        actionBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [actionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        actionBtn.titleLabel.numberOfLines = 0;
        actionBtn.frame = CGRectZero;
        [actionBtn zx_clickedBlock:^(UIButton * _Nullable btn) {
            if(weakSelf.zx_btnClickedBlock){
                weakSelf.zx_btnClickedBlock(btn);
            }
        }];
        actionBtn.zx_hanldeClickedBlock = ^(UIButton * _Nonnull btn) {
            if(weakSelf.zx_autoHideWhenTapOrClick){
                [weakSelf zx_hide];
            }
        };
        [self addSubview:actionBtn];
        self.zx_actionBtn = actionBtn;
        
        UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentViewTap:)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tapGr];
        
        [self obsSubviewsValueChange];
        [self zx_customSetting];
    }
    return self;
}
#pragma mark 刷新子视图布局
- (void)layoutSubviews{
    [super layoutSubviews];
    [self resetFrame];
    [self relayoutSubviews];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CGFLOAT_MIN * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self resetFrame];
    });
}

#pragma mark 添加到superView上
- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    [self zx_hide];
}

#pragma mark - Private
#pragma mark 点击了emptyView
- (void)contentViewTap:(UITapGestureRecognizer *)gr{
    if(self.zx_emptyViewClickedBlock){
        self.zx_emptyViewClickedBlock(gr.view);
        if(self.zx_autoHideWhenTapOrClick){
            [self zx_hide];
        }
    }
    if(self.tapSender && self.tapSel && [self.tapSender respondsToSelector:self.tapSel]){
        ((void (*)(id, SEL))[self.tapSender methodForSelector:self.tapSel])(self.tapSender, self.tapSel);
        if(self.zx_autoHideWhenTapOrClick){
            [self zx_hide];
        }
    }
    
}

#pragma mark 刷新imageView的布局
- (void)relayoutImageView:(UIImageView *)imageView index:(NSUInteger)index{
    UIImage *topImg = imageView.image;
    if(!topImg){
        [imageView setValue:[NSValue valueWithCGRect:CGRectZero] forKey:@"frame"];
        return;
    }
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = 0;
    CGFloat Space = ZXSpace(imageView);
    if(topImg){
        width = topImg.size.width;
        height = topImg.size.height;
    }
    CGSize fixSize = CGSizeZero;
    CGFloat fixWidth = 0;
    CGFloat fixHeight = 0;
    fixSize = [[imageView valueForKey:@"zx_fixSize"]CGSizeValue];
    fixWidth = [[imageView valueForKey:@"zx_fixWidth"]doubleValue];
    fixHeight = [[imageView valueForKey:@"zx_fixHeight"]doubleValue];
    if(!CGSizeEqualToSize(self.zx_topImageView.zx_fixSize, CGSizeZero)){
        height = fixSize.height;
        width = fixSize.width;
    }else if(fixWidth){
        if(self.zx_fixWidth){
            fixWidth = fixWidth > self.zx_fixWidth ? self.zx_fixWidth : fixWidth;
        }
        height = fixWidth / width * height;
        width = fixWidth;
    }else if(fixHeight){
        width = fixHeight / height * width;
        height = fixHeight;
    }
    x = (self.zx_width - width) / 2;
    CGFloat viewOffset = 0;
    if(index){
        viewOffset = CGRectGetMaxY(self.subviews[index - 1].frame);
    }
    y = !height ? viewOffset : Space + viewOffset;
    CGRect frame = CGRectMake(x, y, width, height);
    CGRect (^zx_handleFrame)(CGRect orgFrame) = [imageView valueForKey:@"zx_handleFrame"];
    if(zx_handleFrame){
        frame = zx_handleFrame(frame);
    }
    [imageView setValue:[NSValue valueWithCGRect:frame] forKey:@"frame"];
}

#pragma mark 刷新label的布局
- (void)relayoutLabel:(UILabel *)label index:(NSUInteger)index{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = 0;
    CGFloat strWidth = 0;
    CGFloat fixWidth = [[label valueForKey:@"zx_fixWidth"] doubleValue];
    CGFloat fixHeight = [[label valueForKey:@"zx_fixHeight"] doubleValue];
    CGFloat additionWidth = [[label valueForKey:@"zx_additionWidth"] doubleValue];
    CGFloat additionHeight = [[label valueForKey:@"zx_additionHeight"] doubleValue];
    CGFloat Space = ZXSpace(label);
    if(self.zx_fixWidth){
        if(fixWidth){
            fixWidth = fixWidth > self.zx_fixWidth ? self.zx_fixWidth : fixWidth;
        }else{
            fixWidth = self.zx_fixWidth;
        }
    }
    if(label.text.length){
        strWidth = [label zx_getNormalStringWidthWithFixHeight:height];
    }else if(label.attributedText.length){
        strWidth = [label zx_getAttrStringWidthWithFixHeight:height];
    }
    if(strWidth){
        if(strWidth > self.superview.zx_width - ZXOrgFixSpace * 2){
            strWidth = self.superview.zx_width - ZXOrgFixSpace * 2;
        }
    }
    if(fixWidth && fixWidth < strWidth){
        strWidth = fixWidth;
    }
    width = strWidth;
    if(additionWidth && width){
        width += additionWidth;
    }
    height = [label zx_getNormalStringHeightWithFixWidth:width];
    if(additionHeight && height){
        height += additionHeight;
    }
    if(fixHeight){
        height = fixHeight;
    }
    x = (self.zx_width - width) / 2;
    CGFloat viewOffset = 0;
    if(index){
        viewOffset = CGRectGetMaxY(self.subviews[index - 1].frame);
    }
    y = !height ? viewOffset : Space + viewOffset;
    CGRect frame = CGRectMake(x, y, width, height);
    CGRect (^zx_handleFrame)(CGRect orgFrame) = [label valueForKey:@"zx_handleFrame"];
    if(zx_handleFrame){
        frame = zx_handleFrame(frame);
    }
    [label setValue:[NSValue valueWithCGRect:frame] forKey:@"frame"];
}

#pragma mark 刷新button的布局
- (void)relayoutButton:(UIButton *)button index:(NSUInteger)index{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = 0;
    CGFloat strWidth = 0;
    CGFloat fixWidth = [[button valueForKey:@"zx_fixWidth"] doubleValue];
    CGFloat fixHeight = [[button valueForKey:@"zx_fixHeight"] doubleValue];
    CGFloat additionWidth = [[button valueForKey:@"zx_additionWidth"] doubleValue];
    CGFloat additionHeight = [[button valueForKey:@"zx_additionHeight"] doubleValue];
    CGFloat Space = ZXSpace(button);
    if(self.zx_fixWidth){
        if(fixWidth){
            fixWidth = fixWidth > self.zx_fixWidth ? self.zx_fixWidth : fixWidth;
        }else{
            fixWidth = self.zx_fixWidth;
        }
    }
    if(button.currentTitle.length){
        strWidth = [button.titleLabel zx_getNormalStringWidth];
    }else if(button.currentAttributedTitle.length){
        strWidth = [button.titleLabel zx_getAttrStringWidth];
    }
    if(strWidth){
        if(strWidth > self.superview.zx_width - Space * 2){
            strWidth = self.superview.zx_width - Space * 2;
        }
    }
    if(fixWidth && fixWidth < strWidth){
        strWidth = fixWidth;
    }
    width = strWidth;
    if(additionWidth && width){
        width += additionWidth;
    }
    height = [button.titleLabel zx_getNormalStringHeightWithFixWidth:width];
    if(additionHeight && height){
        height += additionHeight;
    }
    if(fixHeight){
        height = fixHeight;
    }
    x = (self.zx_width - width) / 2;
    CGFloat viewOffset = 0;
    if(index){
        viewOffset = CGRectGetMaxY(self.subviews[index - 1].frame);
    }
    y = !height ? viewOffset : Space + viewOffset;
    CGRect frame = CGRectMake(x, y, width, height);
    CGRect (^zx_handleFrame)(CGRect orgFrame) = [button valueForKey:@"zx_handleFrame"];
    if(zx_handleFrame){
        frame = zx_handleFrame(frame);
    }
    [button setValue:[NSValue valueWithCGRect:frame] forKey:@"frame"];
}

#pragma mark 刷新emptyView的布局
- (void)resetFrame{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = 0;
    if(self.zx_customView){
        height = self.zx_customView.zx_height;
        width = self.zx_customView.zx_width;
    }else{
        height = CGRectGetMaxY(self.zx_actionBtn.frame) + [self getSubviewsMarginBottom];
        for (UIView *subView in self.subviews) {
            if(subView.zx_width > width){
                width = subView.zx_width;
            }
        }
    }
    
    x = (self.superview.zx_width - width) / 2;
    y = (self.superview.zx_height - height) / 2;
    
    CGFloat fixTop = [[self valueForKey:@"zx_fixTop"] doubleValue];
    if(fixTop){
        y = fixTop;
    }
    CGFloat fixLeft = [[self valueForKey:@"zx_fixLeft"] doubleValue];
    if(fixLeft){
        x = fixLeft;
    }
    
    CGRect frame = CGRectMake(x, y, width, height);
    if(self.zx_handleFrame){
        frame = self.zx_handleFrame(frame);
    }
    self.frame = frame;
    if(self.zx_customView){
        self.zx_customView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    }
}

#pragma mark 刷新所有子视图布局
- (void)relayoutSubviews{
    if(!self.zx_customView){
        [self relayoutSubviewsFromIndex:0];
    }
}

#pragma mark 刷新从fromIndex之后子视图布局
- (void)relayoutSubviewsFromIndex:(NSUInteger)fromIndex{
    NSInteger index = 0;
    for (UIView *subView in self.subviews) {
        if(fromIndex <= index){
            if([subView isKindOfClass:[UIImageView class]]){
                [self relayoutImageView:(UIImageView *)subView index:index];
            }
            if([subView isKindOfClass:[UILabel class]]){
                [self relayoutLabel:(UILabel *)subView index:index];
            }
            if([subView isKindOfClass:[UIButton class]]){
                [self relayoutButton:(UIButton *)subView index:index];
            }
        }
        index++;
    }
}

#pragma mark 监听子视图内容改变
- (void)obsSubviewsValueChange{
    __weak typeof(self) weakSelf = self;
    NSUInteger index = 0;
    for (UIView *subView in self.subviews) {
        [subView zx_obsKey:@"zx_fixWidth" handler:^(id  _Nonnull newData, id  _Nonnull oldData, id  _Nonnull owner) {
            if(oldData){
                [weakSelf relayoutSubviewsFromIndex:index];
            }
        }];
        [subView zx_obsKey:@"zx_fixTop" handler:^(id  _Nonnull newData, id  _Nonnull oldData, id  _Nonnull owner) {
            if(oldData){
                [weakSelf relayoutSubviewsFromIndex:index];
            }
        }];
        if([subView isKindOfClass:[UIImageView class]]){
            [subView zx_obsKey:@"image" handler:^(id  _Nonnull newData, id  _Nonnull oldData, id  _Nonnull owner) {
                if(oldData){
                    [weakSelf relayoutSubviewsFromIndex:index];
                }
            }];
            [subView zx_obsKey:@"zx_fixHeight" handler:^(id  _Nonnull newData, id  _Nonnull oldData, id  _Nonnull owner) {
                if(oldData){
                    [weakSelf relayoutSubviewsFromIndex:index];
                }
            }];
            [subView zx_obsKey:@"zx_fixSize" handler:^(id  _Nonnull newData, id  _Nonnull oldData, id  _Nonnull owner) {
                if(!CGSizeEqualToSize([oldData CGSizeValue], CGSizeZero)){
                    [weakSelf relayoutSubviewsFromIndex:index];
                }
            }];
        }
        if([subView isKindOfClass:[UILabel class]]){
            [subView zx_obsKey:@"text" handler:^(id  _Nonnull newData, id  _Nonnull oldData, id  _Nonnull owner) {
                if(oldData){
                    [weakSelf relayoutSubviewsFromIndex:index];
                }
            }];
            [subView zx_obsKey:@"attributedText" handler:^(id  _Nonnull newData, id  _Nonnull oldData, id  _Nonnull owner) {
                if(oldData){
                    [weakSelf relayoutSubviewsFromIndex:index];
                }
            }];
        }
        if([subView isKindOfClass:[UIButton class]]){
            [((UIButton *)subView).titleLabel zx_obsKey:@"text" handler:^(id  _Nonnull newData, id  _Nonnull oldData, id  _Nonnull owner) {
                if(oldData){
                    [weakSelf relayoutSubviewsFromIndex:index];
                }
            }];
            [((UIButton *)subView).titleLabel zx_obsKey:@"attributedText" handler:^(id  _Nonnull newData, id  _Nonnull oldData, id  _Nonnull owner) {
                if(oldData){
                    [weakSelf relayoutSubviewsFromIndex:index];
                }
            }];
        }
        index++;
    }
}

#pragma mark 获取子视图之前的间距
- (CGFloat)getSubviewsSpace:(UIView *)subview{
    CGFloat fixTop = [[subview valueForKey:@"zx_fixTop"] doubleValue];
    if(fixTop){
        return fixTop;
    }
    return ZXFixSpace;
}

#pragma mark 获取子视图距离emptyView底部距离
- (CGFloat)getSubviewsMarginBottom{
    CGFloat subviewsMarginBottom = [[self valueForKey:@"zx_subviewsMarginBottom"] doubleValue];
    if(subviewsMarginBottom){
        return subviewsMarginBottom;
    }
    return ZXFixSpace;
}

#pragma mark 获取默认的子视图之间的距离
- (CGFloat)getFixSpace{
    CGFloat defaultSubviewsSpace = [[self valueForKey:@"zx_defaultSubviewsSpace"] doubleValue];
    if(defaultSubviewsSpace){
        return defaultSubviewsSpace;
    }
    return ZXOrgFixSpace;
}

#pragma mark - Public
#pragma mark 显示emptyView
- (void)zx_show{
    if([self.superview isKindOfClass:[ZXFullEmptyView class]]){
        self.superview.hidden = NO;
    }
    [self.superview layoutSubviews];
    self.hidden = NO;
}

#pragma mark 隐藏emptyView
- (void)zx_hide{
    if([self.superview isKindOfClass:[ZXFullEmptyView class]]){
        self.superview.hidden = YES;
    }
    self.hidden = YES;
}

#pragma mark 子类可重写此方法并在其中进行初始化设置
- (void)zx_customSetting{
    
}
#pragma mark 为emptyView添加点击事件
- (void)zx_emptyViewAddTarget:(id)target action:(SEL)sel{
    self.tapSender = target;
    self.tapSel = sel;
}

#pragma mark 为actionBtn添加点击事件
- (void)zx_btnAddTarget:(id)target action:(SEL)sel{
    [self.zx_actionBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - getter & setter
- (ZXFullEmptyView *)zx_fullEmptyView{
    if([self.superview isKindOfClass:[ZXFullEmptyView class]]){
        _zx_fullEmptyView = (ZXFullEmptyView *)self.superview;
    }
    return _zx_fullEmptyView;
}

- (void)setZx_customView:(UIView *)zx_customView{
    if(_zx_customView){
        [_zx_customView removeFromSuperview];
    }
    _zx_customView = zx_customView;
    [self addSubview:zx_customView];
    [self setNeedsLayout];
}

@end
