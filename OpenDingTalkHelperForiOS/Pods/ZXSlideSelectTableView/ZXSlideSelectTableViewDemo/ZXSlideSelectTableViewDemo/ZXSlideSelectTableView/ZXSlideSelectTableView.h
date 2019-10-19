//
//  ZXSlideSelectTableView.h
//  ZXSlideSelectTableView
//
//  Created by 李兆祥 on 2019/9/25.
//  Copyright © 2019 李兆祥. All rights reserved.
//  https://github.com/SmileZXLee/ZXSlideSelectTableView
//  基于ZXTableView https://github.com/SmileZXLee/ZXTableView

#import "ZXTableView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^kEnumEventHandler) (id model,BOOL *stop);
@interface ZXSlideSelectTableView : ZXTableView
///cell选中状态发生改变回调，若调用了全选和取消全选触发，则selectedIndexPath和selectedModel均为nil
@property (copy, nonatomic) void (^zx_selectedBlock)(NSIndexPath * _Nullable selectedIndexPath, id _Nullable selectedModel);
///滑动手势所在的view，若要设置其frame建议使用zx_gestureViewWidth或zx_gestureViewFrame
@property(weak, nonatomic, readonly)UIView *zx_gestureView;
///数据模型中用于存储选中状态的属性名，默认为"selected"
@property (copy, nonatomic)NSString *zx_modelSelectedKey;
///设置手势识别区域的宽度，默认x，y都为0，高度等同于tableView高度，若gestureViewWidth和gestureViewFrame都不设置，默认为(0,0,50,tableView.contentSize.height)
///设置手势识别区域的固定宽度
@property (assign, nonatomic)CGFloat zx_gestureViewWidth;
///设置手势识别区域与左侧的固定距离
@property (assign, nonatomic)CGFloat zx_gestureViewLeft;
///设置手势识别区域与右侧的固定距离(若此项设置，则zx_gestureViewLeft无效)
@property (assign, nonatomic)CGFloat zx_gestureViewRight;
///设置手势识别区域与顶部的固定距离
@property (assign, nonatomic)CGFloat zx_gestureViewTop;
///设置手势识别区域与底部的固定距离(若此项设置，则zx_gestureViewTop无效)
@property (assign, nonatomic)CGFloat zx_gestureViewBottom;
///设置手势识别区域的frame，若设置，上方五个设置均无效，默认为(0,0,50,tableView.contentSize.height)[CGRect的height值随意填就好了，ZXSlideSelectTableView会根据具体情况自动调整它，CGRect的y最好是0，可根据自身要求调整]
@property (copy, nonatomic)CGRect (^zx_gestureViewFrameBlock)(CGRect tableViewFrame);
///是否禁止自动设置选中状态（取反），若禁用，则只能选中，无法取消选中
@property (assign, nonatomic)BOOL zx_disableAutoSelected;
///已选中的模型数组（涉及大量数据遍历，建议放在异步线程获取）
@property (strong, nonatomic)NSMutableArray *zx_selectedArray;
///未选中的模型数组（涉及大量数据遍历，建议放在异步线程获取）
@property (strong, nonatomic)NSMutableArray *zx_unSelectedArray;
///选中所有项
- (void)zx_selectAll;
///取消选中所有项
- (void)zx_unSelectAll;
///遍历获取所有model
- (void)zx_enumModelsCallBack:(kEnumEventHandler)result;
NS_ASSUME_NONNULL_END
@end


