# ZXSlideSelectTableView
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/skx926/ZXSlideSelectTableView/master/LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/ZXSlideSelectTableView.svg?style=flat)](http://cocoapods.org/?q=ZXTableView)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/ZXSlideSelectTableView.svg?style=flat)](http://cocoapods.org/?q=ZXTableView)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%208.0%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
## 安装
### 通过CocoaPods安装
```ruby
pod 'ZXSlideSelectTableView'
```
### 或手动导入
* 将ZXTableView拖入项目中。
* 将ZXSlideSelectTableView拖入项目中。
### 导入头文件
```objective-c
#import "ZXSlideSelectTableView.h"
```
## 预览
<img src="http://www.zxlee.cn/ZXSlideSelectTableViewDemo.gif"/>

## 实现原理
* ZXSlideSelectTableView基于[ZXTableView](https://github.com/SmileZXLee/ZXTableView)快速实现tableView的构造
* 在此基础上ZXSlideSelectTableView通过在tableView上方添加一个覆盖所有选择按钮的gestureView并监听其拖动与点击事件，通过将对应事件的point转换为tableView中的indexPath并修改对应indexPath中的model的"selected"达到选中与取消选中的效果

## 快速使用
### 建议查看项目中Demo文件夹中的例子
1.创建一个ZXSlideSelectTableView  
2.创建需要在tableView中显示的cell和对应的model类  
3.请注意，必须在model中声明"selected"属性
```objective-c
@interface DemoModel : NSObject
@property(copy, nonatomic) NSString *msg;
@property(assign, nonatomic) BOOL selected;
@end
```
* 如果您的model中用于记录当前cell是否选中的属性不为"selected"，请修改model中的属性名或设置ZXSlideSelectTableView的zx_modelSelectedKey值为您当前model中用于记录当前cell是否选中的属性名  

4.在控制器中声明tableView中的cell
```objective-c
self.tableView.zx_setCellClassAtIndexPath = ^Class _Nonnull(NSIndexPath * _Nonnull indexPath) {
    return [DemoCell class];
};
```
5.给tableView设置数据
```objective-c
- (void)setDatas{
    NSMutableArray *dataArr = [NSMutableArray array];
    for(int i = 0; i < 6;i++){
        NSMutableArray *sectionArr = [NSMutableArray array];
        for(int j = 0; j < 10;j++){
            DemoModel *demoModel = [[DemoModel alloc]init];
            demoModel.msg = [NSString stringWithFormat:@"第%d行",j];
            demoModel.selected = NO;
            [sectionArr addObject:demoModel];
        }
        [dataArr addObject:sectionArr];
        
    }
    self.tableView.zxDatas = dataArr;
}
```
* 至此，一个基础的ZXSlideSelectTableView就完成了

## 使用进阶
### ZXSlideSelectTableView相关
#### cell选中状态发生改变回调
```objective-c
self.tableView.zx_selectedBlock = ^(NSIndexPath * _Nonnull selectedIndexPath, id  _Nonnull selectedModel) {
    weakSelf.title = [NSString stringWithFormat:@"已选中%ld个",weakSelf.tableView.zx_selectedArray.count];
};
```
#### 设置数据模型中用于存储选中状态的属性名，默认为"selected"
```objective-c
//将会自动把选中状态赋值给model中的selectedTest属性
self.tableView.zx_modelSelectedKey = @"selectedTest";
```
#### 设置手势识别区域的宽度，默认x，y都为0，高度等同于tableView高度，若gestureViewWidth和gestureViewFrame都不设置，默认为(0,0,50,tableView.contentSize.height)
```objective-c
self.tableView.zx_gestureViewWidth = 60;
```
#### 设置手势识别区域的frame，若设置，则gestureViewWidth无效，若gestureViewWidth和gestureViewFrame都不设置，默认为(0,0,50,tableView.contentSize.height)
```objective-c
self.tableView.zx_gestureViewFrame = CGRectMake(20,0,20,0);
```
#### 是否禁止自动设置选中状态（取反），若禁用，则只能选中，无法取消选中
```objective-c
self.tableView.zx_disableAutoSelected = YES;
```
#### 已选中的模型数组（涉及大量数据遍历，建议放在异步线程获取）
```objective-c
NSMutableArray *selectedArray = self.tableView.zx_selectedArray;
```
#### 未选中的模型数组（涉及大量数据遍历，建议放在异步线程获取）
```objective-c
NSMutableArray *unSelectedArray = self.tableView.zx_unSelectedArray;
```
#### 选中所有项
```objective-c
[self.tableView zx_selectAll];
```
#### 取消选中所有项
```objective-c
[self.tableView zx_unSelectAll];
```
#### 遍历获取所有model
```objective-c
[self zx_enumModelsCallBack:^(id  _Nonnull model, BOOL * _Nonnull stop) {
     NSLog(@"model--%@",model);
}];
```

### ZXTableView相关
#### 和TableView相关的设置，详见：https://github.com/SmileZXLee/ZXTableView/blob/master/README.md

***

## 感谢使用，有任何问题欢迎随时issue我
