//
//  AppDelegate.m
//  OpenDingTalkHelperForiOS
//
//  Created by 李兆祥 on 2019/10/16.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/OpenDingTalkHelperForiOS

#import "ODAppDelegate.h"
#import "ODSecurityVC.h"
#import "ODHomeVC.h"
#import <UserNotifications/UserNotifications.h>
@interface ODAppDelegate ()<UNUserNotificationCenterDelegate>
@property (nonatomic, weak) UIVisualEffectView *coverEffectview ;
@end

@implementation ODAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ODHomeVC *homeVC = [[ODHomeVC alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    window.rootViewController = nav;
    [window makeKeyAndVisible];
    self.window = window;
    [self setNotificationCenter];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    [[UIBarButtonItem appearance] setTintColor:[UIColor darkGrayColor]];
    [self removeCoverEffectviewAndShowSecurity:YES];
    return YES;
}


- (void)setNotificationCenter{
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center removeAllPendingNotificationRequests];
    }
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    [self receiveNotification];
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
API_AVAILABLE(ios(10.0)){
    [self receiveNotification];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler
API_AVAILABLE(ios(10.0)){
    [self receiveNotification];
}

- (void)receiveNotification{
    [[NSNotificationCenter defaultCenter]postNotificationName:ODReceiveNotificationKey object:nil];
}



- (void)addCoverEffectview{
    if(self.coverEffectview)return;
    BOOL enableSecurity = [ZXDataStoreCache readBoolForKey:ODSecurityKey];
    if(enableSecurity){
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.frame = self.window.bounds;
        [self.window addSubview:effectview];
        self.coverEffectview = effectview;
    }
}

- (void)removeCoverEffectviewAndShowSecurity:(BOOL)doVerify{
    BOOL enableSecurity = [ZXDataStoreCache readBoolForKey:ODSecurityKey];
    if(enableSecurity){
        if(![[ODBaseUtil getTopVC] isKindOfClass:[ODSecurityVC class]]){
            ODSecurityVC *VC = [[ODSecurityVC alloc]init];
            if(doVerify){
                VC.type = ODSecurityTypeDoVerify;
            }else{
                VC.type = ODSecurityTypeShowCover;
            }
            [self.window.rootViewController presentViewController:VC animated:NO completion:nil];
        }
        
        if(self.coverEffectview){
            [self.coverEffectview removeFromSuperview];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self addCoverEffectview];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    [self removeCoverEffectviewAndShowSecurity:YES];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
