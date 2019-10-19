//
//  ODWeekSelectVC.h
//  OpenDingTalkHelperForiOS
//
//  Created by 李兆祥 on 2019/10/18.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/OpenDingTalkHelperForiOS

#import "ODBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ODWeekSelectVC : ODBaseVC

/**
 点击了存储按钮回调
 */
@property(copy,nonatomic)void(^savedBlock)(void);
@end

NS_ASSUME_NONNULL_END
