//
//  ODWeekSelectCell.m
//  OpenDingTalkHelperForiOS
//
//  Created by 李兆祥 on 2019/10/18.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/OpenDingTalkHelperForiOS

#import "ODWeekSelectCell.h"
#import "ODWeekSelectModel.h"
@interface ODWeekSelectCell()
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImgV;
@property (strong, nonatomic) ODWeekSelectModel *weekSelectModel;
@end
@implementation ODWeekSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setWeekSelectModel:(ODWeekSelectModel *)weekSelectModel{
    _weekSelectModel = weekSelectModel;
    self.weekLabel.text = weekSelectModel.week;
    self.selectedImgV.image = weekSelectModel.selected ? [UIImage imageNamed:@"selected_icon"] : nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
