//
//  UIView+ZXEmptyAutoShow.m
//  ZXEmptyView
//
//  Created by ZXLee on 2019/10/5.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/ZXEmptyView

#import "UIView+ZXEmptyAutoShow.h"
#import "UIView+ZXEmpty.h"
#import "NSObject+ZXEmptySwizzleMethod.h"

@implementation UIView (ZXEmptyAutoShow)

#pragma mark - Private
#pragma mark 刷新emptyView显示或隐藏的状态
- (void)resetEmptyViewStatus{
    if([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]]){
        ZXEmptyContentView *emptyContentView = self.zx_emptyContentView;
        if(!emptyContentView)return;
        BOOL isEmptyData = [self isEmptyData];
        if(isEmptyData){
            [self zx_showEmptyView];
            CGFloat headerHeight = [self getHeaderHeight];
            CGFloat footerHeight = [self getFooterHeight];
            if(!emptyContentView.zx_autoAdjustWhenHeaderView){
                headerHeight = 0;
            }
            if(!emptyContentView.zx_autoAdjustWhenFooterView){
                footerHeight = 0;
            }
            __weak typeof(self) weakSelf = self;
            [self.zx_emptyContentView zx_updateFrame:^CGRect(CGRect orgFrame) {
                orgFrame = CGRectMake(orgFrame.origin.x, (weakSelf.zx_height - headerHeight - footerHeight -  orgFrame.size.height) / 2 + headerHeight, orgFrame.size.width, orgFrame.size.height);
                return orgFrame;
            }];
        }else{
            [self zx_hideEmptyView];
        }
    }
}

#pragma mark 判断tableView/collectionView是否无数据
- (BOOL)isEmptyData{
    BOOL isEmptyData = YES;
    if([self isKindOfClass:[UITableView class]]){
        UITableView *tableView = (UITableView *)self;
        for (NSInteger section = 0; section < [tableView numberOfSections]; section++) {
            NSUInteger row = [tableView numberOfRowsInSection:section];
            if(row > 0){
                isEmptyData = NO;
                break;
            }
        }
    }
    if([self isKindOfClass:[UICollectionView class]]){
        UICollectionView *collectionView = (UICollectionView *)self;
        for (NSInteger section = 0; section < [collectionView numberOfSections]; section++) {
            NSUInteger row = [collectionView numberOfItemsInSection:section];
            if(row > 0){
                isEmptyData = NO;
                break;
            }
        }
    }
    return isEmptyData;
    
}

#pragma mark 获取tableView/collectionView中section=0处headerView高度
- (CGFloat)getHeaderHeight{
    if([self isKindOfClass:[UITableView class]]){
        UITableView *tableView = (UITableView *)self;
        id delegate = tableView.delegate;
        if(delegate && [delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]){
            CGFloat headerHeight = [delegate tableView:tableView heightForHeaderInSection:0];
            return headerHeight;
        }
    }
    if([self isKindOfClass:[UICollectionView class]]){
        UICollectionView *collectionView = (UICollectionView *)self;
        id delegate = collectionView.delegate;
        if(delegate && [delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]){
            CGSize headerSize = [delegate collectionView:collectionView layout:collectionView.collectionViewLayout referenceSizeForHeaderInSection:0];
            return headerSize.height;
        }
    }
    return 0;
}

#pragma mark 获取tableView/collectionView中section=0处footerView高度
- (CGFloat)getFooterHeight{
    if([self isKindOfClass:[UITableView class]]){
        UITableView *tableView = (UITableView *)self;
        id delegate = tableView.delegate;
        if(delegate && [delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]){
            CGFloat footerHeight = [delegate tableView:tableView heightForFooterInSection:0];
            return footerHeight;
        }
    }
    if([self isKindOfClass:[UICollectionView class]]){
        UICollectionView *collectionView = (UICollectionView *)self;
        id delegate = collectionView.delegate;
        if(delegate && [delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]){
            CGSize footerSize = [delegate collectionView:collectionView layout:collectionView.collectionViewLayout referenceSizeForFooterInSection:0];
            return footerSize.height;
        }
    }
    return 0;
}
#pragma mark - Public
#pragma mark 显示emptyView
- (void)zx_showEmptyView{
    if(!self.zx_emptyContentView || !self.zx_emptyContentView.zx_autoShowEmptyView){
        return;
    }
    [self.zx_emptyContentView zx_show];
}

#pragma mark 隐藏emptyView
- (void)zx_hideEmptyView{
    if(!self.zx_emptyContentView || !self.zx_emptyContentView.zx_autoShowEmptyView){
        return;
    }
    [self.zx_emptyContentView zx_hide];
}
@end

@implementation UITableView (ZXEmptyAutoShow)
+ (void)load{
    zx_swizzleMethod(self, @selector(reloadData), @selector(zx_tableViewReloadData));
    zx_swizzleMethod(self, @selector(reloadSections:withRowAnimation:), @selector(zx_reloadSections:withRowAnimation:));
    zx_swizzleMethod(self, @selector(insertSections:withRowAnimation:), @selector(zx_insertSections:withRowAnimation:));
    zx_swizzleMethod(self, @selector(deleteSections:withRowAnimation:), @selector(zx_deleteSections:withRowAnimation:));
}

- (void)zx_tableViewReloadData{
    [self zx_tableViewReloadData];
    [self resetEmptyViewStatus];
}

- (void)zx_reloadSections:(id)arg1 withRowAnimation:(int)agr2{
    [self zx_reloadSections:arg1 withRowAnimation:agr2];
    [self resetEmptyViewStatus];
}

- (void)zx_insertSections:(id)arg1 withRowAnimation:(int)agr2{
    [self zx_insertSections:arg1 withRowAnimation:agr2];
    [self resetEmptyViewStatus];
}

- (void)zx_deleteSections:(id)arg1 withRowAnimation:(int)agr2{
    [self zx_deleteSections:arg1 withRowAnimation:agr2];
    [self resetEmptyViewStatus];
}

- (void)zx_startLoading{
    [self zx_hideEmptyView];
}

- (void)zx_endLoading{
    [self resetEmptyViewStatus];
}
@end

@implementation UICollectionView (ZXEmptyAutoShow)
+ (void)load{
    zx_swizzleMethod(self, @selector(reloadData), @selector(zx_collectionViewReloadData));
    zx_swizzleMethod(self, @selector(reloadSections:), @selector(zx_reloadSections:));
    zx_swizzleMethod(self, @selector(insertSections:), @selector(zx_insertSections:));
    zx_swizzleMethod(self, @selector(deleteSections:), @selector(zx_deleteSections:));
    zx_swizzleMethod(self, @selector(reloadItemsAtIndexPaths:), @selector(zx_reloadItemsAtIndexPaths:));
    zx_swizzleMethod(self, @selector(insertItemsAtIndexPaths:), @selector(zx_insertItemsAtIndexPaths:));
    zx_swizzleMethod(self, @selector(deleteItemsAtIndexPaths:), @selector(zx_deleteItemsAtIndexPaths:));
}

- (void)zx_collectionViewReloadData{
    [self zx_collectionViewReloadData];
    [self resetEmptyViewStatus];
}

- (void)zx_reloadSections:(id)arg1{
    [self zx_reloadSections:arg1];
    [self resetEmptyViewStatus];
}

- (void)zx_insertSections:(id)arg1{
    [self zx_insertSections:arg1];
    [self resetEmptyViewStatus];
}

- (void)zx_deleteSections:(id)arg1{
    [self zx_deleteSections:arg1];
    [self resetEmptyViewStatus];
}

- (void)zx_reloadItemsAtIndexPaths:(id)arg1{
    [self zx_reloadItemsAtIndexPaths:arg1];
    [self resetEmptyViewStatus];
}

- (void)zx_insertItemsAtIndexPaths:(id)arg1{
    [self zx_insertItemsAtIndexPaths:arg1];
    [self resetEmptyViewStatus];
}

- (void)zx_deleteItemsAtIndexPaths:(id)arg1{
    [self zx_deleteItemsAtIndexPaths:arg1];
    [self resetEmptyViewStatus];
}

- (void)zx_startLoading{
    [self zx_hideEmptyView];
}

- (void)zx_endLoading{
    [self resetEmptyViewStatus];
}
@end
