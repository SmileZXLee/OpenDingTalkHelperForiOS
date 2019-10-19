//
//  UIView+ZXEmptyAutoShow.h
//  ZXEmptyView
//
//  Created by ZXLee on 2019/10/5.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/ZXEmptyView

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZXEmptyAutoShow)
/**
 显示当前view所属的emptyView
 */
- (void)zx_showEmptyView;

/**
 隐藏当前view所属的emptyView
 */
- (void)zx_hideEmptyView;
@end

@interface UITableView (ZXEmptyAutoShow)

/**
 tableView开始加载的时候手动调用，将会隐藏emptyView
 */
- (void)zx_startLoading;

/**
 tableView结束加载的时候手动调用，将会根据tableView中cell的个数决定是否显示emptyView
 */
- (void)zx_endLoading;
@end

@interface UICollectionView (ZXEmptyAutoShow)

/**
 collectionView开始加载的时候手动调用，将会隐藏emptyView
 */
- (void)zx_startLoading;

/**
 collectionView结束加载的时候手动调用，将会根据collectionView中cell的个数决定是否显示emptyView
 */
- (void)zx_endLoading;
@end

NS_ASSUME_NONNULL_END
