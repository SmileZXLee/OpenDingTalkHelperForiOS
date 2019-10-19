//
//  ODBaseVC.m
//  OpenDingTalkHelperForiOS
//
//  Created by 李兆祥 on 2019/10/16.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/OpenDingTalkHelperForiOS

#import "ODBaseVC.h"

@interface ODBaseVC ()

@end

@implementation ODBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    backBtn.title = @"";
    self.navigationItem.backBarButtonItem = backBtn;
}

#pragma mark - Public
#pragma mark 添加引导页面
- (void)addGuideView{
    if([[NSUserDefaults standardUserDefaults]boolForKey:[NSString stringWithFormat:@"OD_%@",NSStringFromClass([self class])]]){
        return;
    }
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:[NSString stringWithFormat:@"OD_%@",NSStringFromClass([self class])]];
    if([self isKindOfClass:NSClassFromString(@"ODWeekSelectVC")]){
        FeatureGuideObject *object1 =[[FeatureGuideObject alloc] init];
        object1.targetView = [self valueForKeyPath:@"tableView.zx_gestureView"];
        object1.introduce = @"上下滑动可快速选择星期";
        object1.buttonTitle = @"我知道了";
        object1.cornerRadius = 2;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FeatureGuideView showGuideViewWithObjects:@[object1] InView:nil];
        });
    }
    
}

@end
