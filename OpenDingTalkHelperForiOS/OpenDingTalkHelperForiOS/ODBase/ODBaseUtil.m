//
//  ODBaseUtil.m
//  OpenDingTalkHelperForiOS
//
//  Created by 李兆祥 on 2019/10/17.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/OpenDingTalkHelperForiOS

#import "ODBaseUtil.h"
#import "ODWeekSelectModel.h"
#import "ALToastView.h"
#import <UserNotifications/UserNotifications.h>
@implementation ODBaseUtil
+ (instancetype)shareInstance{
    static ODBaseUtil * s_instance_singleton = nil ;
    if (s_instance_singleton == nil) {
        s_instance_singleton = [[ODBaseUtil alloc] init];
    }
    return (ODBaseUtil *)s_instance_singleton;
}
#pragma mark - 时间日期相关
#pragma mark 获取两个时间(hh:mm)相差的时间
+ (long)getDistanceBetweenHm:(NSString *)hm nextHm:(NSString *)nextHm{
    
    return [self getTotalMinsHm:nextHm] - [self getTotalMinsHm:hm];
}
#pragma mark 获取两个时间(hh:mm:ss)相差的时间
+ (long)getDistanceBetweenHms:(NSString *)hms nextMs:(NSString *)nextHms{
    
    return [self getTotalSecondsHms:nextHms] - [self getTotalSecondsHms:hms];
}

#pragma mark 获取时间(hh:mm)的总秒数
+ (long)getTotalMinsHm:(NSString *)hm{
    long hour = [[hm componentsSeparatedByString:@":"][0] intValue];
    long minute = [[hm componentsSeparatedByString:@":"][1] intValue];
    return hour * 60 + minute;
}

#pragma mark 通过总分钟数获取时间(hh:mm)
+ (NSString *)getHmWithTotalMinutes:(long)min{
    long hour = min / 60;
    long minute = min % 60;
    return [NSString stringWithFormat:@"%.2ld:%.2ld",hour,minute];
}

#pragma mark 获取时间(hh:mm:ss)的总秒数
+ (long)getTotalSecondsHms:(NSString *)hms{
    long hour = [[hms componentsSeparatedByString:@":"][0] intValue];
    long minute = [[hms componentsSeparatedByString:@":"][1] intValue];
    long second = [[hms componentsSeparatedByString:@":"][2] intValue];
    return hour * 60 * 60 + minute * 60 + second;
}

#pragma mark 通过总秒数获取时间(hh:mm:ss)
+ (NSString *)getHmsWithTotalSeconds:(long)sec{
    long hour = sec / 60 / 60;
    long minute = sec / 60;
    long second = sec % 60;
    return [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",hour,minute,second];
}

#pragma mark 获取当前日期后一天的日期(yyyy-mm-dd)
+ (NSString *)getTomorrowDay:(NSDate *)aDate {
    return [self getDistanceDay:aDate day:1];
}

#pragma mark 获取当前日期后几天的日期(yyyy-mm-dd)
+ (NSString *)getDistanceDay:(NSDate *)aDate day:(long)day{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day] + day)];
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

#pragma mark 获取下一个符合条件的日期(yyyy-mm-dd)
+ (NSString *)getNextDayIncludeToday:(BOOL)includeToday{
    NSArray *selectedArray = [ODWeekSelectModel zx_dbQuaryWhere:@""];
    NSDate *date = [NSDate date];
    if(!selectedArray){
        if(includeToday){
            NSDateFormatter *todayFormat=[[NSDateFormatter alloc] init];
            [todayFormat setDateFormat:@"yyyy-MM-dd"];
            return [todayFormat stringFromDate:date];
        }else{
            return [self getTomorrowDay:date];
        }
    }else{
        NSString *todayWeek = [self getWeekDayFordate:date];
        NSArray *weekArr = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
        long todayIndex = [weekArr indexOfObject:todayWeek];
        long index = 0;
        long firstIndex = -1;
        BOOL none = YES;
        for (ODWeekSelectModel *selectModel in selectedArray) {
            if(selectModel.selected){
                if(firstIndex == -1){
                    firstIndex = index;
                }
                if(includeToday && (index >= todayIndex)){
                    none = NO;
                    break;
                }else if(!includeToday && (index > todayIndex)){
                    none = NO;
                    break;
                }
            }
            index++;
        }
        if(none){
            index = firstIndex;
        }
        if(index != -1){
            long day = 0;
            if(todayIndex <= index){
                if(!includeToday && todayIndex == index){
                    day = 7;
                }else{
                    day = index - todayIndex;
                }
            }else{
                day = 7 - (todayIndex - index);
            }
            return [self getDistanceDay:date day:day];
        }
        
    }
    return nil;
}

#pragma mark 获取下一个符合条件的日期(yyyy-mm-dd hh:mm:ss)
+ (NSString *)getNextFullTimeHm:(NSString *)nextHm{
    NSDate *date = [NSDate date];
    NSDateFormatter *msFormat=[[NSDateFormatter alloc] init];
    [msFormat setDateFormat:@"hh:mm:ss"];
    NSDateFormatter *fullFormat=[[NSDateFormatter alloc] init];
    [fullFormat setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSString *msStr = [msFormat stringFromDate:date];
    NSString *fullNextStr;
    long randomSec = [self getRandomNumber:1 to:59];
    NSString *randomSecStr = [NSString stringWithFormat:@":%.2ld",randomSec];
    NSString *fullTempStr = [nextHm stringByAppendingString:randomSecStr];
    long msDis = [self getDistanceBetweenHms:msStr nextMs:fullTempStr];
    NSString *subFullNextStr = [self getNextDayIncludeToday:msDis > 0];
    if(!subFullNextStr){
        return @"永不";
    }
    fullNextStr = [[subFullNextStr stringByAppendingString:@" "]stringByAppendingString:nextHm];
    return [fullNextStr stringByAppendingString:randomSecStr];
}

#pragma mark 获取当前时间(yyyy-mm-dd hh:mm:ss)
+ (NSString *)getNowFullStr{
    NSDate *date = [NSDate date];
    NSDateFormatter *msFormat=[[NSDateFormatter alloc] init];
    [msFormat setDateFormat:@"hh:mm"];
    NSDateFormatter *fullFormat=[[NSDateFormatter alloc] init];
    [fullFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *fullDateStr = [fullFormat stringFromDate:date];
    if(fullDateStr.length == 19){
        NSDateFormatter *timeCurrentFormatter = [[NSDateFormatter alloc] init];
        [timeCurrentFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSString *timeCurrentWeek = [ODBaseUtil getWeekDayFordate:[timeCurrentFormatter dateFromString:fullDateStr]];
        NSMutableString *timeCurrentMustr = [[NSMutableString alloc]initWithString:fullDateStr];
        [timeCurrentMustr insertString:[NSString stringWithFormat:@"(%@)",timeCurrentWeek] atIndex:10];
        fullDateStr = timeCurrentMustr;
    }
    return fullDateStr;
}

#pragma mark 获取当前日期是周几
+ (NSString *)getWeekDayFordate:(NSDate *)date{
    NSArray *weekday = @[[NSNull null],@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}
#pragma mark - 通知推送相关
#pragma mark 检查是否有通知权限
+(void)checkUserNotificationEnableCallback:(od_checkUserNotificationEnableBlock)block{
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(settings.notificationCenterSetting == UNNotificationSettingEnabled);
            });
            
        }];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
                UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
                [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            } else {
                [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
            }
            block(!([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone));
        });
    }
}

#pragma mark 打开设置
+ (void)openSetting{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [application openURL:url options:@{} completionHandler:nil];
            }
        }else {
            [application openURL:url];
        }
    }
}

#pragma mark 请求通知权限
+ (void)askForUserNotification{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0){
        if (@available(iOS 10.0, *)) {
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                        if (settings.authorizationStatus == UNAuthorizationStatusAuthorized){
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [[UIApplication sharedApplication] registerForRemoteNotifications];
                                [[NSNotificationCenter defaultCenter]postNotificationName:ODNotificationAuthoredKey object:nil];
                            });
                        }
                    }];
                }
            }];
        }
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
        if (@available(iOS 8.0, *)) {
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
                UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
                [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
                [[UIApplication sharedApplication] registerForRemoteNotifications];
                [[NSNotificationCenter defaultCenter]postNotificationName:ODNotificationAuthoredKey object:nil];
            }
        }
    }
}

#pragma mark 添加本地推送
+ (NSString *)addLocalNoticeNextHm:(NSString *)nextHm type:(ODTimeType)timeType{
    NSDateFormatter *fullFormat = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    [fullFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *fullNextStr = [self getNextFullTimeHm:nextHm];
    if([fullNextStr isEqualToString:@"永不"]){
        [self removeLocalNoticeWithType:timeType];
        return fullNextStr;
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:type fromDate:date toDate:[fullFormat dateFromString:fullNextStr] options:0];
    long disSec = cmps.day * 24 * 60 * 60 + cmps.hour * 60 * 60 + cmps.minute * 60 + cmps.second;
    if(disSec <= 0){
        [self showToast:@"定时任务设置失败，请将系统时间设置为24小时制"];
        return fullNextStr;
    }
    if(@available(iOS 10.0, *)) {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        content.title = timeType == ODTimeTypeGoToWork ? @"钉钉定时打卡助手(上班打卡)" : @"钉钉定时打卡助手(下班打卡)";
        content.body = @"请务必不要退到后台，保持此应用始终在前台，并保持充足电量！";
        NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:disSec] timeIntervalSinceNow];
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:time repeats:NO];
        NSString *identifier = timeType == ODTimeTypeGoToWork ? @"od_noticeId_to" : @"od_noticeId_off";
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(!error){
                    //[self showToast:@"推送添加成功"];
                }
            });
        }];
    }else {
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        notif.fireDate = [NSDate dateWithTimeIntervalSinceNow:disSec];
        notif.alertBody = @"此通知用于打开钉钉";
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    }
    if(fullNextStr.length == 19){
        NSDateFormatter *timeCurrentFormatter = [[NSDateFormatter alloc] init];
        [timeCurrentFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *timeCurrentWeek = [ODBaseUtil getWeekDayFordate:[timeCurrentFormatter dateFromString:fullNextStr]];
        NSMutableString *timeCurrentMustr = [[NSMutableString alloc]initWithString:fullNextStr];
        [timeCurrentMustr insertString:[NSString stringWithFormat:@"(%@)",timeCurrentWeek] atIndex:10];
        fullNextStr = timeCurrentMustr;
    }
    return fullNextStr;
}

#pragma mark 移除本地推送
+ (void)removeLocalNoticeWithType:(ODTimeType)timeType{
    NSString *alertTitle = timeType == ODTimeTypeGoToWork ? @"钉钉定时打卡助手(上班打卡)" : @"钉钉定时打卡助手(下班打卡)";
    NSArray *localNotificationArray= [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSUInteger acount = [localNotificationArray count];
    if (acount > 0){
        for (int i = 0;i < acount;i++){
            UILocalNotification *myUILocalNotification = [localNotificationArray objectAtIndex:i];
            if([myUILocalNotification.alertTitle isEqualToString:alertTitle]){
                [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];
                break;
            }
        }
    }
}

#pragma mark - Other
#pragma mark 显示Toast
+ (void)showToast:(NSString *)str{
    [ALToastView showToastWithText:str];
}

#pragma mark 获取指定范围内的随机数
+ (long)getRandomNumber:(long)from to:(long)to{
    return (from + (arc4random() % (to - from + 1)));
}

#pragma mark 判断当前系统是否为24小时制
+ (BOOL)is24HourFormat{
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA =[formatStringForHours rangeOfString:@"a"];
    return containsA.location == NSNotFound;
}

#pragma mark 获取显示在用户眼前的控制器
+ (UIViewController *)getTopVC{
    return [self getTopVCRecursive:[self getRootVC]];
}

#pragma mark 递归获取顶部控制器
+ (UIViewController *)getTopVCRecursive:(UIViewController *)vc{
    if(vc.presentedViewController){
        return [self getTopVCRecursive:(UIViewController *)vc.presentedViewController];
    }else if([vc isKindOfClass:[UITabBarController class]]){
        return [self getTopVCRecursive:((UITabBarController *)vc).selectedViewController];
    }else if([vc isKindOfClass:[UINavigationController class]]){
        return [self getTopVCRecursive:((UINavigationController *)vc).visibleViewController];
    }else{
        
        int count = (int)vc.childViewControllers.count;
        for (int i = count - 1; i >= 0; i--) {
            UIViewController *childVc = vc.childViewControllers[i];
            if (childVc && childVc.view.window) {
                vc = [self getTopVCRecursive:childVc];
                break;
            }
        }
        return vc;
    }
    
}

#pragma mark 获取keyWindow
+ (UIWindow *)getKeyWindow{
    return [UIApplication sharedApplication].keyWindow;
}

#pragma mark 获取根控制器
+ (UIViewController *)getRootVC{
    return [self getKeyWindow].rootViewController;
}

#pragma mark 获取info.plist
+ (NSDictionary *)getInfoDictionary{
    return [[NSBundle mainBundle] infoDictionary];
}

#pragma mark 获取App名称
+ (NSString *)getAppName{
    return [[self getInfoDictionary] objectForKey:@"CFBundleDisplayName"];
}

#pragma mark 获取当前版本号
+ (NSString *)getVersion{
    return [[self getInfoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark - getter&setter
- (NSString *)od_startTimeForGoToWork{
    return [ZXDataStoreCache readObjForKey:ODStartTimeKeyForGoToWork];
}
- (void)setOd_startTimeForGoToWork:(NSString *)od_startTime{
    NSString *endTime = self.od_endTimeForGoToWork;
    if(endTime.length){
        long disSec = [[self class]getDistanceBetweenHm:od_startTime nextHm:endTime];
        if(disSec > 0){
            [ZXDataStoreCache saveObj:od_startTime forKey:ODStartTimeKeyForGoToWork];
        }else{
            [[self class]showToast:[NSString stringWithFormat:@"设置失败，起始时间不得大于等于结束时间"]];
        }
    }else{
        [ZXDataStoreCache saveObj:od_startTime forKey:ODStartTimeKeyForGoToWork];
    }
    
}


- (NSString *)od_endTimeForGoToWork{
    return [ZXDataStoreCache readObjForKey:ODEndTimeKeyForGoToWork];
}
- (void)setOd_endTimeForGoToWork:(NSString *)od_endTime{
    NSString *startTime = self.od_startTimeForGoToWork;
    if(startTime.length){
        long disSec = [[self class]getDistanceBetweenHm:startTime nextHm:od_endTime];
        if(disSec > 0){
            [ZXDataStoreCache saveObj:od_endTime forKey:ODEndTimeKeyForGoToWork];
        }else{
            [[self class]showToast:[NSString stringWithFormat:@"设置失败，结束时间不得小于等于起始时间"]];
        }
    }else{
        [ZXDataStoreCache saveObj:od_endTime forKey:ODEndTimeKeyForGoToWork];
    }
}

- (NSString *)od_startTimeForGoOffWork{
    return [ZXDataStoreCache readObjForKey:ODStartTimeKeyForGoOffWork];
}
- (void)setOd_startTimeForGoOffWork:(NSString *)od_startTime{
    NSString *endTime = self.od_endTimeForGoOffWork;
    if(endTime.length){
        long disSec = [[self class]getDistanceBetweenHm:od_startTime nextHm:endTime];
        if(disSec > 0){
            [ZXDataStoreCache saveObj:od_startTime forKey:ODStartTimeKeyForGoOffWork];
        }else{
            [[self class]showToast:[NSString stringWithFormat:@"设置失败，起始时间不得大于等于结束时间"]];
        }
    }else{
        [ZXDataStoreCache saveObj:od_startTime forKey:ODStartTimeKeyForGoOffWork];
    }
    
}


- (NSString *)od_endTimeForGoOffWork{
    return [ZXDataStoreCache readObjForKey:ODEndTimeKeyForGoOffWork];
}
- (void)setOd_endTimeForGoOffWork:(NSString *)od_endTime{
    NSString *startTime = self.od_startTimeForGoOffWork;
    if(startTime.length){
        long disSec = [[self class]getDistanceBetweenHm:startTime nextHm:od_endTime];
        if(disSec > 0){
            [ZXDataStoreCache saveObj:od_endTime forKey:ODEndTimeKeyForGoOffWork];
        }else{
            [[self class]showToast:[NSString stringWithFormat:@"设置失败，结束时间不得小于等于起始时间"]];
        }
    }else{
        [ZXDataStoreCache saveObj:od_endTime forKey:ODEndTimeKeyForGoOffWork];
    }
}

- (BOOL)isOpenedDingTalk{
    return [ZXDataStoreCache readBoolForKey:ODIsOpenedDingTalkKey];
}

- (void)setIsOpenedDingTalk:(BOOL)isOpenedDingtalk{
    [ZXDataStoreCache saveBool:isOpenedDingtalk forKey:ODIsOpenedDingTalkKey];
    
}


@end
