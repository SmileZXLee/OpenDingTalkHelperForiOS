//
//  ODHomeCell.m
//  OpenDingTalkHelperForiOS
//
//  Created by 李兆祥 on 2019/10/16.
//  Copyright © 2019 ZXLee. All rights reserved.
//

#import "ODHomeCell.h"
#import "ODHomeModel.h"
@interface ODHomeCell()
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic)ODHomeModel *homeModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconMoreWidth;

@end
@implementation ODHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.mainLabel.adjustsFontSizeToFitWidth = YES;
    self.detailLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setHomeModel:(ODHomeModel *)homeModel{
    _homeModel = homeModel;
    self.mainLabel.text = homeModel.title;
    self.detailLabel.text = homeModel.detail;
    self.iconMoreWidth.constant = self.detailLabel.text.length ? 0 : 15;
    if([homeModel.title isEqualToString:@"就绪状态"]){
        if([homeModel.detail isEqualToString:@"已就绪"]){
            self.detailLabel.textColor = [UIColor colorWithRed:1/255.0 green:189/255.0 blue:24/255.0 alpha:1];
        }else{
            self.detailLabel.textColor = [UIColor redColor];
        }
    }else{
        self.detailLabel.textColor = [UIColor darkGrayColor];
    }
    if([self.mainLabel.text isEqualToString:@"星期"]){
        self.iconMoreWidth.constant = 15;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
