//
//  ODHistoryCell.m
//  OpenDingTalkHelperForiOS
//
//  Created by 李兆祥 on 2019/10/17.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/OpenDingTalkHelperForiOS

#import "ODHistoryCell.h"
#import "ODHistoryModel.h"
@interface ODHistoryCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) ODHistoryModel *historyModel;
@end
@implementation ODHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setHistoryModel:(ODHistoryModel *)historyModel{
    _historyModel = historyModel;
    self.timeLabel.text = historyModel.time;
    self.statusLabel.text = historyModel.status;
    if([historyModel.status isEqualToString:@"成功"]){
        self.statusLabel.backgroundColor = [UIColor colorWithRed:1/255.0 green:189/255.0 blue:24/255.0 alpha:1];
    }else{
        self.statusLabel.backgroundColor = [UIColor redColor];
    }
    self.statusLabel.clipsToBounds = YES;
    self.statusLabel.layer.cornerRadius = 5;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
