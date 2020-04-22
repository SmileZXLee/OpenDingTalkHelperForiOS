//
//  ODBaseUtil.h
//  OpenDingTalkHelperForiOS
//
//  Created by 李兆祥 on 2019/10/17.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/OpenDingTalkHelperForiOS

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void (^ __nullable od_checkUserNotificationEnableBlock)(BOOL enable);
@interface ODBaseUtil : NSObject

/**
 开始时间
 */
@property (copy, nonatomic)NSString *od_startTime;

/**
 结束时间
 */
@property (copy, nonatomic)NSString *od_endTime;
+ (instancetype)shareInstance;

/**
 获取指定范围内的随机数

 @param from 开始
 @param to 结束
 @return 指定范围内的随机数
 */
+ (long)getRandomNumber:(long)from to:(long)to;

/**
 获取两个时间(hh:mm)相差的时间

 @param hm 时间1
 @param nextHm 时间2
 @return 相差的时间(秒)
 */
+ (long)getDistanceBetweenHm:(NSString *)hm nextHm:(NSString *)nextHm;

/**
 获取时间(hh:mm)的总分钟数

 @param hm 时间
 @return 总分钟数
 */
+ (long)getTotalMinsHm:(NSString *)hm;

/**
 通过总分钟数获取时间(hh:mm)

 @param min 总分数数
 @return 时间(hh:mm)
 */
+ (NSString *)getHmWithTotalMinutes:(long)min;

/**
 显示Toast

 @param str toast内容
 */
+ (void)showToast:(NSString *)str;

/**
 检查是否有通知权限

 @param block 检查完成回调
 */
+(void)checkUserNotificationEnableCallback:(od_checkUserNotificationEnableBlock)block;

/**
 打开设置
 */
+ (void)openSetting;

/**
 请求通知权限
 */
+ (void)askForUserNotification;

/**
 添加本地推送

 @param nextHm 本地推送时间(hh:mm)
 @return 本地推送具体时间(yyyy-mm-dd(week) hh:mm:ss)
 */
+ (NSString *)addLocalNoticeNextHm:(NSString *)nextHm;

/**
 获取当前时间(yyyy-mm-dd hh:mm:ss)

 @return 当前时间(yyyy-mm-dd hh:mm:ss)
 */
+ (NSString *)getNowFullStr;

/**
 获取当前日期是周几

 @param date 日期
 @return 周几
 */
+ (NSString *)getWeekDayFordate:(NSDate *)date;


/**
 判断当前系统是否为24小时制

 @return 是否为24小时制
 */
+ (BOOL)is24HourFormat;

/**
 获取显示在用户眼前的控制器

 @return 显示在用户眼前的控制器
 */
+ (UIViewController *)getTopVC;

/**
 获取App名称
 
 @return App名称
 */
+ (NSString *)getAppName;

/**
 获取当前版本号
 
 @return 当前版本号
 */
+ (NSString *)getVersion;
@end

NS_ASSUME_NONNULL_END
