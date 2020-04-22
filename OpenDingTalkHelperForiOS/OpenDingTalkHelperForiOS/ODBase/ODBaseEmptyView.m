//
//  ODBaseEmptyView.m
//  OpenDingTalkHelperForiOS
//
//  Created by 李兆祥 on 2019/10/16.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/OpenDingTalkHelperForiOS

#import "ODBaseEmptyView.h"

@implementation ODBaseEmptyView

#pragma mark 初始化设置
- (void)zx_customSetting{
    self.zx_titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.zx_detailLabel.font = [UIFont systemFontOfSize:15];
    self.zx_detailLabel.textColor = [UIColor darkGrayColor];
    self.zx_topImageView.zx_fixWidth = 80;
}

#pragma mark 切换样式
- (void)setZx_type:(int)zx_type{
    if(zx_type == ODEmptyViewTypeAttension){
        self.zx_topImageView.image = [UIImage imageNamed:@"attention_icon"];
        self.zx_titleLabel.text = @"使用须知";
        self.zx_defaultSubviewsSpace = 15;
        self.zx_fixTop = 30 + ZXNavBarHeight;
        self.zx_detailLabel.textAlignment = NSTextAlignmentLeft;
        self.zx_detailLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.zx_detailLabel.zx_additionWidth = -10;
        self.zx_detailLabel.text = @"1.此工具仅用于自动打开钉钉进行签到，钉钉需打开自动签到功能且设备处于打卡范围内！\n2.点击【跳转测试】按钮之后若出现一弹窗提示是否允许打开钉钉，请务必点击允许，仅需允许一次即可。\n3.进入主页后请设置自动打卡的起始时间和结束时间，此应用将会随机选择范围内的时间进行跳转打卡。\n4.请允许通知权限。";
        [self.zx_actionBtn setTitle:@"跳转测试&申请通知权限" forState:UIControlStateNormal];
        [self.zx_actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        self.zx_actionBtn.zx_handleFrame = ^CGRect(CGRect orgFrame) {
            return CGRectMake(20, orgFrame.origin.y + 10, weakSelf.zx_width - 40, 40);
        };
        self.zx_actionBtn.backgroundColor = ODMainColor;
        self.zx_actionBtn.layer.cornerRadius = 5;
    }else{
        self.zx_topImageView.image = [UIImage imageNamed:@"nodata_icon"];
        self.zx_titleLabel.text = @"暂无数据";
        self.zx_detailLabel.text = @"您使用此应用自动打卡的记录将显示在此处";
        [self.zx_actionBtn setTitle:@"" forState:UIControlStateNormal];
    }
}

@end
