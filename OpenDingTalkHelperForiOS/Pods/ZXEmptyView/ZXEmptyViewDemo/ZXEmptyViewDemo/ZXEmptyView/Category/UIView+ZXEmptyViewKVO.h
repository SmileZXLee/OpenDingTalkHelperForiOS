//
//  UIView+ZXEmptyViewKVO.h
//  ZXEmptyView
//
//  Created by ZXLee on 2019/10/4.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/ZXEmptyView

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^obsResultHandler) (id newData, id oldData,id owner);
@interface NSObject (ZXEmptyViewKVO)

/**
 KVO监听

 @param key 监听的key
 @param handler 监听结果回调
 */
-(void)zx_obsKey:(NSString *)key handler:(obsResultHandler)handler;

/**
 记录已经添加监听的keyPath与对应的block
 */
@property(strong,nonatomic,readonly)NSMutableDictionary *zx_observingKeyPathDictionary;
@end

NS_ASSUME_NONNULL_END
