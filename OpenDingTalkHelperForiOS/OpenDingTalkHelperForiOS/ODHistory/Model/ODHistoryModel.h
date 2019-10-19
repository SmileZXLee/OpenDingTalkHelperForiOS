//
//  ODHistoryModel.h
//  OpenDingTalkHelperForiOS
//
//  Created by 李兆祥 on 2019/10/17.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/OpenDingTalkHelperForiOS

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ODHistoryModel : NSObject

/**
 打卡时间
 */
@property (copy, nonatomic)NSString *time;

/**
 是否成功
 */
@property (copy, nonatomic)NSString *status;
@end

NS_ASSUME_NONNULL_END
