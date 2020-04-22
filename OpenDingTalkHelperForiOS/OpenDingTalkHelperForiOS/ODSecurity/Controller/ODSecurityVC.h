//
//  ODSecurityVC.h
//  OpenDingTalkHelperForiOS
//
//  Created by 李兆祥 on 2020/4/21.
//  Copyright © 2020 ZXLee. All rights reserved.
//

#import "ODBaseVC.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    ODSecurityTypeSetPwd = 0, //设置密码
    ODSecurityTypeSettingPwd, //正在设置密码
    ODSecurityTypeDoVerify, //显示并验证用户身份
    ODSecurityTypeCheckPwd, //验证密码
    ODSecurityTypeShowCover //仅显示此控制器
} ODSecurityType;
@interface ODSecurityVC : ODBaseVC
@property (assign, nonatomic) int type;
@property (copy, nonatomic) void (^setSuccessBlock)(void);
@property (copy, nonatomic) void (^checkSuccessBlock)(void);
@end

NS_ASSUME_NONNULL_END
