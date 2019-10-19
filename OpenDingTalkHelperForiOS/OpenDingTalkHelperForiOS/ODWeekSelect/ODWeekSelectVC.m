//
//  ODWeekSelectVC.m
//  OpenDingTalkHelperForiOS
//
//  Created by 李兆祥 on 2019/10/18.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/OpenDingTalkHelperForiOS

#import "ODWeekSelectVC.h"
#import "ZXSlideSelectTableView.h"
#import "ODWeekSelectCell.h"
#import "ODWeekSelectModel.h"
@interface ODWeekSelectVC ()
@property (weak, nonatomic) IBOutlet ZXSlideSelectTableView *tableView;

@end

@implementation ODWeekSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupData];
}

#pragma mark - 初始化
#pragma mark 初始化UI
- (void)setupUI{
    self.title = @"星期";
    self.tableView.zx_setCellClassAtIndexPath = ^Class _Nonnull(NSIndexPath * _Nonnull indexPath) {
        return [ODWeekSelectCell class];
    };
    self.tableView.zx_gestureViewRight = 0;
    __weak typeof(self) weakSelf = self;
    self.tableView.zx_didSelectedAtIndexPath = ^(NSIndexPath * _Nonnull indexPath, ODWeekSelectModel * _Nonnull model, id  _Nonnull cell) {
        model.selected = !model.selected;
        [weakSelf.tableView reloadData];
    };
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"存储" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self addGuideView];
}

#pragma mark 初始化数据
- (void)setupData{
    NSArray *selectedArray = [ODWeekSelectModel zx_dbQuaryWhere:@""];
    if(selectedArray){
        self.tableView.zxDatas = [selectedArray mutableCopy];
        return;
    }
    NSArray *weekArr = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    NSMutableArray *datas = [NSMutableArray array];
    int index = 0;
    for (NSString *week in weekArr) {
        ODWeekSelectModel *selectModel = [[ODWeekSelectModel alloc]init];
        selectModel.week = week;
        selectModel.selected = YES;
        index++;
        selectModel.number = index;
        [datas addObject:selectModel];
    }
    self.tableView.zxDatas = datas;
}

#pragma mark - Actions
#pragma mark 点击了存储按钮
- (void)saveAction{
    [ODWeekSelectModel zx_dbDropTable];
    [self.tableView.zxDatas zx_dbSave];
    if(self.savedBlock){
        self.savedBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
