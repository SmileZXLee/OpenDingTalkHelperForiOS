//
//  ODWeekSelectModel.h
//  OpenDingTalkHelperForiOS
//
//  Created by 李兆祥 on 2019/10/18.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/OpenDingTalkHelperForiOS

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ODWeekSelectModel : NSObject

/**
 是否选中
 */
@property (assign, nonatomic)BOOL selected;

/**
 周几
 */
@property (copy, nonatomic)NSString *week;

/**
 周几对应的index
 */
@property (assign, nonatomic)int number;
@end

NS_ASSUME_NONNULL_END
