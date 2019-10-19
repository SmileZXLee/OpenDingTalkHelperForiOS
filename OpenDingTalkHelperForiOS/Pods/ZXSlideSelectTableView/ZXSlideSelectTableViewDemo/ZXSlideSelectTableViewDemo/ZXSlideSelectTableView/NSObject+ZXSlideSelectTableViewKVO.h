//
//  NSObject+ZXSlideSelectTableViewKVO.h
//  ZXSlideSelectTableView
//
//  Created by 李兆祥 on 2019/9/25.
//  Copyright © 2019 李兆祥. All rights reserved.
//  https://github.com/SmileZXLee/ZXSlideSelectTableView
//  基于ZXTableView https://github.com/SmileZXLee/ZXTableView

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^obsResultHandler) (id newData, id oldData,id owner);
@interface NSObject (ZXSlideSelectTableViewKVO)
-(void)zx_slideSelectObsKey:(NSString *)key handler:(obsResultHandler)handler;
@end

NS_ASSUME_NONNULL_END
