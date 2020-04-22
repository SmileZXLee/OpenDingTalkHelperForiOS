//
//  ODBaseEmptyView.h
//  OpenDingTalkHelperForiOS
//
//  Created by 李兆祥 on 2019/10/16.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/OpenDingTalkHelperForiOS

#import "ZXEmptyContentView.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum{
    ODEmptyViewTypeAttension = 0, //注意事项
    ODEmptyViewTypeNodata  //暂无数据
} ODEmptyViewType;
@interface ODBaseEmptyView : ZXEmptyContentView

@end

NS_ASSUME_NONNULL_END
