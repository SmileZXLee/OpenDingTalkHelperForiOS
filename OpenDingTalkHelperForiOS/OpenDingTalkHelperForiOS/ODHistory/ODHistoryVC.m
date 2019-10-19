//
//  ODHistoryVC.m
//  OpenDingTalkHelperForiOS
//
//  Created by 李兆祥 on 2019/10/17.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/OpenDingTalkHelperForiOS

#import "ODHistoryVC.h"
#import "ODBaseEmptyView.h"
#import "ODHistoryCell.h"
#import "ODHistoryModel.h"

@interface ODHistoryVC ()
@property (weak, nonatomic) IBOutlet ZXTableView *tableView;

@end

@implementation ODHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupEmptyView];
    [self setupData];
}

#pragma mark - 初始化
#pragma mark 初始化UI
- (void)setupUI{
    self.title = @"钉钉定时打卡记录";
    self.tableView.zx_setCellClassAtIndexPath = ^Class _Nonnull(NSIndexPath * _Nonnull indexPath) {
        return [ODHistoryCell class];
    };
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"清除" style:UIBarButtonItemStylePlain target:self action:@selector(clearAllAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark 设置EmptyView
- (void)setupEmptyView{
    [self.tableView zx_setEmptyView:@"ODBaseEmptyView" isFull:YES];
    self.tableView.zx_emptyContentView.zx_type = ODEmptyViewTypeNodata;
}

#pragma mark 初始化数据
- (void)setupData{
    NSMutableArray *historyDatas = [[ODHistoryModel zx_dbQuaryAll] mutableCopy];
    self.tableView.zxDatas = (NSMutableArray *)[[historyDatas reverseObjectEnumerator] allObjects];;
    self.navigationItem.rightBarButtonItem.enabled = self.tableView.zxDatas.count;
}

#pragma mark - Actions
#pragma mark 清除所有历史数据
- (void)clearAllAction{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定清空定时打卡记录吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [ODHistoryModel zx_dbDropTable];
        [self setupData];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
