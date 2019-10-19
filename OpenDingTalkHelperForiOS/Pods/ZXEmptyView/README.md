# ZXEmptyView
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/smilezxlee/ZXEmptyView/master/LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/ZXEmptyView.svg?style=flat)](http://cocoapods.org/?q=ZXRequestBlock)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/ZXEmptyView.svg?style=flat)](http://cocoapods.org/?q=ZXRequestBlock)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%208.0%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
## 安装
### 通过CocoaPods安装
```ruby
pod 'ZXEmptyView'
```
### 手动导入
* 将ZXEmptyView拖入项目中。

### 导入头文件
```objective-c
#import "ZXEmptyView.h"
```
***

## 起步
### 了解ZXEmptyView基本构造
* ZXEmptyView的操作核心类为:ZXEmptyContentView
* ZXEmptyContentView中从上到下有四个基本控件:zx_topImageView，zx_titleLabel，zx_detailLabel，zx_actionBtn
* 开发者可以创建一个EmptyView继承于ZXEmptyContentView，并重写zx_customSetting，在其中修改ZXEmptyContentView中四个控件的值与样式
* 若需要把ZXEmptyView添加到self.view上，则调用[self.view zx_setEmptyView:@"EmptyClass"]进行初始化
* 在任何地方任何时间都可以通过self.view.zx_emptyContentView修改其内部控件的值与样式，修改后emptyContentView布局会自动刷新
### 基础初始化示例
* 创建DemoEmptyView，继承于ZXEmptyContentView，重写zx_customSetting，设置自定义的样式
```objective-c
@implementation DemoEmptyView
//重写zx_customSetting方法
- (void)zx_customSetting{
    //设置EmptyView顶部的图片
    self.zx_topImageView.image = nil;
    //设置EmptyView中titleLabel的文字颜色
    self.zx_titleLabel.textColor = [UIColor lightGrayColor];
    //与正常设置view样式一样，详细的样式设计下方会列出...
}
@end
```
* 在需要显示EmptyView的控制器中
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置EmptyView
    [self.view zx_setEmptyView:@"DemoEmptyView" isFull:NO clickedBlock:^(UIButton * _Nullable btn) {
        NSLog(@"点击了emptyView中的按钮");
    } emptyViewClickedBlock:^(UIView * _Nullable btn) {
        NSLog(@"点击了emptyView");
    }];
    //显示EmptyView
    [self.view zx_showEmptyView];
}
```
* 至此，一个EmptyView就已创建完毕，进入目标控制器即可发现EmptyView

### 基础样式示例
### ZXEmptyContentView提供了丰富的样式自定义接口，您可以轻松快速地设置需要的EmptyView
#### 1.仅显示titleLabel
* 创建DemoEmptyView，继承于ZXEmptyContentView，重写zx_customSetting，设置自定义的样式
```objective-c
@implementation DemoEmptyView
//重写zx_customSetting方法
- (void)zx_customSetting{
    //设置titleLabel
    self.zx_titleLabel.text = @"仅显示titleLabel";
    self.zx_titleLabel.font = [UIFont boldSystemFontOfSize:20];
}
@end
```

#### 2.显示titleLabel和detailLabel
* 创建DemoEmptyView，继承于ZXEmptyContentView，重写zx_customSetting，设置自定义的样式
```objective-c
@implementation DemoEmptyView
//重写zx_customSetting方法
- (void)zx_customSetting{
    //设置titleLabel
    self.zx_titleLabel.text = @"显示titleLabel和detailLabel";
    self.zx_titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    //设置detailLabel
    self.zx_detailLabel.text = @"这是detailLabel，超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试";
    self.zx_detailLabel.textColor = [UIColor darkGrayColor];
    self.zx_detailLabel.font = [UIFont systemFontOfSize:13];
}
@end
```

#### 3.显示topImageView、titleLabel和detailLabel
* 创建DemoEmptyView，继承于ZXEmptyContentView，重写zx_customSetting，设置自定义的样式
```objective-c
@implementation DemoEmptyView
//重写zx_customSetting方法
- (void)zx_customSetting{
    //设置topImageView
    self.zx_topImageView.image = [UIImage imageNamed:@"nodata_icon"];
    self.zx_topImageView.zx_fixWidth = 100;
    
    //设置titleLabel
    self.zx_titleLabel.text = @"显示topImageView、titleLabel和detailLabel";
    self.zx_titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    //设置detailLabel
    self.zx_detailLabel.text = @"这是detailLabel，超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试";
    self.zx_detailLabel.textColor = [UIColor darkGrayColor];
    self.zx_detailLabel.font = [UIFont systemFontOfSize:13];
}
@end
```

#### 4.显示topImageView、titleLabel和detailLabel和actionBtn
* 创建DemoEmptyView，继承于ZXEmptyContentView，重写zx_customSetting，设置自定义的样式
```objective-c
@implementation DemoEmptyView
//重写zx_customSetting方法
- (void)zx_customSetting{
    //设置topImageView
    self.zx_topImageView.image = [UIImage imageNamed:@"nodata_icon"];
    self.zx_topImageView.zx_fixWidth = 100;
    
    //设置titleLabel
    self.zx_titleLabel.text = @"显示topImageView、titleLabel、detailLabel和actionBtn";
    self.zx_titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    //设置detailLabel
    self.zx_detailLabel.text = @"这是detailLabel，超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试超长文字测试";
    self.zx_detailLabel.textColor = [UIColor darkGrayColor];
    self.zx_detailLabel.font = [UIFont systemFontOfSize:13];
    
    //设置actionBtn
    //设置actionBtn宽度比按钮文字内容宽度多15
    self.zx_actionBtn.zx_additionWidth = 15;
    //设置actionBtn高度比按钮文字内容高度多15
    self.zx_actionBtn.zx_additionHeight = 15;
    self.zx_actionBtn.layer.cornerRadius = 5;
    [self.zx_actionBtn setTitle:@"点击重试" forState:UIControlStateNormal];
    self.zx_actionBtn.backgroundColor = [UIColor orangeColor];
    [self.zx_actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
@end
```

#### 5.显示titleLabel和actionBtn
* 创建DemoEmptyView，继承于ZXEmptyContentView，重写zx_customSetting，设置自定义的样式
```objective-c
@implementation DemoEmptyView
//重写zx_customSetting方法
- (void)zx_customSetting{
    //设置titleLabel
    self.zx_titleLabel.text = @"显示titleLabel和actionBtn";
    self.zx_titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    //设置actionBtn
    //设置actionBtn宽度比按钮文字内容宽度多15
    self.zx_actionBtn.zx_additionWidth = 15;
    //设置actionBtn高度比按钮文字内容高度多10
    self.zx_actionBtn.zx_additionHeight = 10;
    self.zx_actionBtn.layer.cornerRadius = 2;
    [self.zx_actionBtn setTitle:@"点击重试" forState:UIControlStateNormal];
    self.zx_actionBtn.backgroundColor = [UIColor orangeColor];
    [self.zx_actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
@end
```

#### 6.显示topImageView和actionBtn
* 创建DemoEmptyView，继承于ZXEmptyContentView，重写zx_customSetting，设置自定义的样式
```objective-c
@implementation DemoEmptyView
//重写zx_customSetting方法
- (void)zx_customSetting{
    //设置topImageView
    self.zx_topImageView.image = [UIImage imageNamed:@"nodata_icon"];
    self.zx_topImageView.zx_fixWidth = 100;

    //设置actionBtn
    //设置actionBtn宽度比按钮文字内容宽度多15
    self.zx_actionBtn.zx_additionWidth = 15;
    //设置actionBtn高度比按钮文字内容高度多10
    self.zx_actionBtn.zx_additionHeight = 10;
    self.zx_actionBtn.layer.cornerRadius = 2;
    [self.zx_actionBtn setTitle:@"点击重试" forState:UIControlStateNormal];
    self.zx_actionBtn.backgroundColor = [UIColor orangeColor];
    [self.zx_actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
@end
```
#### 7.其他情况可自行尝试，您只需要进行基本的数据和样式设置而无需设置frame，ZXEmptyContentView会帮助您自动布局
#### 在控制器中初始化之后，查看以上6种样式的显示效果:
<img src="http://www.zxlee.cn/ZXEmptyViewDemoImg/demo1.jpg"/>

## 使用进阶
### ZXEmptyContentView布局修改
#### 获取ZXEmptyContentView对象
```objective-c
//若已经调用了初始化方法，如self.view zx_setEmptyView...，则ZXEmptyContentView将会添加在self.view上，使用下面的方式可以获取ZXEmptyContentView对象
ZXEmptyContentView *emptyContentView = self.view.zx_emptyContentView;
```

#### 修改ZXEmptyContentView自身布局
* ZXEmptyContentView大小会根据子控件的frame变化自动变化，且自动居中，您可以在此基础上进行自定义更改
* 设置ZXEmptyContentView距离顶部的固定高度（默认水平居中）
```objective-c
emptyContentView.zx_fixTop = 30;
```
* 设置ZXEmptyContentView距离左侧的固定距离（默认垂直居中）
```objective-c
emptyContentView.zx_fixLeft = 30;
```
* 设置ZXEmptyContentView的固定宽度（默认等于子控件中最宽的宽度，若超过EmptyContentView所属view的宽度-2*10，则为所属view的宽度-2*10）
```objective-c
//其子控件的宽度将被自动压缩，如内部label文字不够显示，则高度自动变高
emptyContentView.zx_fixWidth = 300;
```
* 修改ZXEmptyContentView的frame(当ZXEmptyContentView frame改变时会自动调用此block)
```objective-c
self.zx_handleFrame = ^CGRect(CGRect orgFrame) {
    //将orgFrame修改后返回，orgFrame为自动布局之后ZXEmptyContentView的frame
    return orgFrame;
};
```
*** 
#### 修改ZXEmptyContentView 子控件布局
#### 修改zx_topImageView布局
* 修改zx_topImageView距离顶部高度(默认为10)
```objective-c
emptyContentView.zx_topImageView.zx_fixTop = 20;
```
* 固定zx_topImageView的宽度，高度根据图片比例自适应(默认为image的宽度)
```objective-c
emptyContentView.zx_topImageView.zx_fixWidth = 100;
```
* 固定zx_topImageView的高度，宽度根据图片比例自适应(默认为image的高度)
```objective-c
emptyContentView.zx_topImageView.zx_fixHeight = 100;
```
* 固定zx_topImageView的size(默认为image的size)
```objective-c
emptyContentView.zx_topImageView.zx_fixSize = CGSizeMake(100,100);
```
* 修改zx_topImageView的frame(当zx_topImageView frame改变时会自动调用此block)
```objective-c
self.zx_handleFrame = ^CGRect(CGRect orgFrame) {
    //将orgFrame修改后返回，orgFrame为自动布局之后zx_topImageView的frame
    return orgFrame;
};
```
*** 
#### 修改zx_titleLabel布局
* 修改zx_titleLabel距离顶部高度(默认为10)
```objective-c
emptyContentView.zx_titleLabel.zx_fixTop = 20;
```
* 固定zx_titleLabel的宽度，高度根据文字内容自适应(默认跟从ZXEmptyContentView自动调整)
```objective-c
emptyContentView.zx_titleLabel.zx_fixWidth = 100;
```
* 固定zx_titleLabel的高度，宽度根据文字内容自适应
```objective-c
emptyContentView.zx_titleLabel.zx_fixHeight = 30;
```
* 设置zx_titleLabel的附加宽度（在原始宽度[label文字宽度]上增加）
```objective-c
emptyContentView.zx_titleLabel.zx_additionWidth = 15;
```
* 设置zx_titleLabel的附加高度（在原始高度[label文字高度]上增加）
```objective-c
emptyContentView.zx_titleLabel.zx_additionHeight = 15;
```
* 修改zx_titleLabel的frame(当zx_titleLabel frame改变时会自动调用此block)
```objective-c
self.zx_handleFrame = ^CGRect(CGRect orgFrame) {
    //将orgFrame修改后返回，orgFrame为自动布局之后zx_titleLabel的frame
    return orgFrame;
};
```
*** 
#### 修改zx_detailLabel布局
* 同zx_titleLabel

*** 
#### 修改zx_actionBtn布局
* 修改zx_actionBtn距离顶部高度(默认为10)
```objective-c
emptyContentView.zx_actionBtn.zx_fixTop = 20;
```
* 固定zx_actionBtn的宽度，高度根据文字内容自适应(默认跟从ZXEmptyContentView自动调整)
```objective-c
emptyContentView.zx_actionBtn.zx_fixWidth = 100;
```
* 固定zx_actionBtn的高度，宽度根据文字内容自适应
```objective-c
emptyContentView.zx_actionBtn.zx_fixHeight = 30;
```
* 设置zx_actionBtn的附加宽度（在原始宽度[按钮文字宽度]上增加）
```objective-c
emptyContentView.zx_actionBtn.zx_additionWidth = 15;
```
* 设置zx_actionBtn的附加高度（在原始高度[按钮文字高度]上增加）
```objective-c
emptyContentView.zx_actionBtn.zx_additionHeight = 15;
```
* 修改zx_actionBtn的frame(当zx_actionBtn frame改变时会自动调用此block)
```objective-c
self.zx_handleFrame = ^CGRect(CGRect orgFrame) {
    //将orgFrame修改后返回，orgFrame为自动布局之后zx_actionBtn的frame
    return orgFrame;
};
```
*** 
#### ZXEmptyContentView 子控件统一布局
* 设置ZXEmptyContentView的subviews距离底部的高度（默认为10）
```objective-c
emptyContentView.zx_subviewsMarginBottom = 20;
```
* 设置ZXEmptyContentView的subviews之间的间隙（默认为10）
```objective-c
emptyContentView.zx_defaultSubviewsSpace = 20;
```
*** 
### ZXEmptyContentView数据设置
#### 设置ZXEmptyContentView的子控件数据
* ZXEmptyContentView的子控件包括zx_topImageView、zx_titleLabel、zx_detailLabel、zx_actionBtn
* 您可以在自定义EmptyView继承于ZXEmptyContentView并重写zx_customSetting的时候进行初始化设置
* 您也可以在控制器或其他地方通过view(ZXEmptyContentView添加到哪个view上，就用哪个view).zx_emptyContentView方式获取ZXEmptyContentView对象，从而获取内部控件，并随时修改
#### 下方是一个小Demo，实现了刚开始显示默认数据，3秒后更换数据的效果
* 创建DemoEmptyView，继承于ZXEmptyContentView，重写zx_customSetting，设置自定义的样式
```objective-c
@implementation DemoEmptyView
//重写zx_customSetting方法
- (void)zx_customSetting{
    //设置titleLabel
    self.zx_titleLabel.text = @"3秒后，emptyView数据将发生改变";
    self.zx_titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    //设置detailLabel
    self.zx_detailLabel.text = @"我是detailLabel";
    self.zx_detailLabel.textColor = [UIColor darkGrayColor];
    self.zx_detailLabel.font = [UIFont systemFontOfSize:13];
    
    //设置actionBtn
    //设置actionBtn宽度比按钮文字内容宽度多15
    self.zx_actionBtn.zx_additionWidth = 15;
    //设置actionBtn高度比按钮文字内容高度多10
    self.zx_actionBtn.zx_additionHeight = 10;
    self.zx_actionBtn.layer.cornerRadius = 2;
    [self.zx_actionBtn setTitle:@"我是actionBtn" forState:UIControlStateNormal];
    self.zx_actionBtn.backgroundColor = [UIColor orangeColor];
    [self.zx_actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
@end
```
* 在控制器中设置当前控制器view的emptyView为DemoEmptyView，并在3秒后修改emptyView子控件
```objective-c
[self.view zx_setEmptyView:@"DemoEmptyView" isFull:NO clickedBlock:^(UIButton * _Nullable btn) {
    NSLog(@"点击了按钮");
} emptyViewClickedBlock:nil];
[self.view zx_showEmptyView];
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    self.view.zx_emptyContentView.zx_titleLabel.text = @"3秒到了";
    self.view.zx_emptyContentView.zx_titleLabel.layer.borderWidth = 1;
    self.view.zx_emptyContentView.zx_titleLabel.layer.borderColor = [UIColor redColor].CGColor;

    self.view.zx_emptyContentView.zx_detailLabel.text = @"数据发生了改变数据发生了改变数据发生了改变数据发生了改变数据发生了改变数据发生了改变数据发生了改变数据发生了改变数据发生了改变数据发生了改变数据发生了改变数据发生了改变数据发生了改变数据发生了改变数据发生了改变数据发生了改变数据发生了改变数据发生了改变数据发生了改变";
    self.view.zx_emptyContentView.zx_actionBtn.backgroundColor = [UIColor purpleColor];
    [self.view.zx_emptyContentView.zx_actionBtn setTitle:@"我也发生了改变" forState:UIControlStateNormal];
});
```
* 查看效果:
<img src="http://www.zxlee.cn/ZXEmptyViewDemoImg/demo1.gif"/>

***
### ZXEmptyContentView 点击回调
#### ZXEmptyContentView自身点击回调
* 在控制器中设置当前控制器view的emptyView为DemoEmptyView时，同时设置点击回调
```objective-c
[self.view zx_setEmptyView:@"DemoEmptyView" isFull:NO clickedBlock:^(UIButton * _Nullable btn) {
    NSLog(@"点击了按钮");
} emptyViewClickedBlock:^(UIView * _Nullable btn) {
    NSLog(@"点击了emptyView");
}];
```
* 通过ZXEmptyContentView对象设置自身点击回调(Block)
```objective-c
self.view.zx_emptyContentView.zx_emptyViewClickedBlock = ^(UIView * _Nonnull sender) {
    NSLog(@"点击了emptyView");
};
```
* 通过ZXEmptyContentView对象设置自身点击回调(addTarget)
```objective-c
[self.view.zx_emptyContentView zx_emptyViewAddTarget:self action:@selector(emptyViewClickedAction)];
```
#### ZXEmptyContentView中的actionBtn点击回调(Block)
* 在控制器中设置当前控制器view的emptyView为DemoEmptyView时，同时设置点击回调
```objective-c
[self.view zx_setEmptyView:@"DemoEmptyView" isFull:NO clickedBlock:^(UIButton * _Nullable btn) {
    NSLog(@"点击了按钮");
} emptyViewClickedBlock:^(UIView * _Nullable btn) {
    NSLog(@"点击了emptyView");
}];
```
* 通过ZXEmptyContentView对象设置actionBtn点击回调(Block)
```objective-c
self.view.zx_emptyContentView.zx_btnClickedBlock = ^(UIView * _Nonnull sender) {
    NSLog(@"点击了按钮");
};
```
* 通过ZXEmptyContentView对象设置actionBtn点击回调(addTarget)
```objective-c
[self.view.zx_emptyContentView zx_btnAddTarget:self action:@selector(emptyViewClickedAction)];
```
* 通过actionBtn对象设置自身点击回调(Block)
```objective-c
[self.view.zx_emptyContentView.zx_actionBtn zx_clickedBlock:^(UIButton * _Nullable btn) {
    NSLog(@"点击了按钮");
}];
```
* 通过actionBtn对象设置自身点击回调(addTarget)
```objective-c
[self.view.zx_emptyContentView.zx_actionBtn zx_addTarget:self action:@selector(btnClickedAction)];
```
#### 点击自动隐藏ZXEmptyContentView
* 当点击了ZXEmptyContentView中的actionBtn时ZXEmptyContentView会自动隐藏，若实现了点击ZXEmptyContentView方法的监听，则点击ZXEmptyContentView时，ZXEmptyContentView也会自动隐藏
* 可以通过以下设置关闭此功能
```objective-c
self.tableView.zx_emptyContentView.zx_autoHideWhenTapOrClick = NO;
```
***

### ZXEmptyContentView UITableView&UICollectionView相关
#### ZXEmptyContentView 自动显示与隐藏
* 若将ZXEmptyContentView添加至tableView或collectionView中(如：[self.tableView zx_setEmptyView...])，则ZXEmptyContentView会自动显示与隐藏
* 当tableView或collectionView有数据的时候，ZXEmptyContentView会自动隐藏，无数据时自动显示
* 可以通过以下设置关闭此功能
```objective-c
self.tableView.zx_emptyContentView.zx_autoShowEmptyView = NO;
```
#### ZXEmptyContentView 根据headerView和footerView的高度自动调整布局
* 当tableView或collectionView无数据并且有headerView或footerView时，ZXEmptyContentView会自动计算并调整y轴的偏移量，使得ZXEmptyContentView始终在二者之间
* 可以通过以下设置关闭此功能
```objective-c
self.tableView.zx_emptyContentView.zx_autoAdjustWhenHeaderView = NO;
self.tableView.zx_emptyContentView.zx_autoAdjustWhenFooterView = NO;
```
### ZXEmptyContentView 切换样式
#### 在实际开发中经常需要使用到样式切换，例如若tableView无数据，则显示无数据的emptyView，若网络请求失败，则显示网络错误的emptyView
#### 以下是一个样式切换的demo
* 创建DemoEmptyView，继承于ZXEmptyContentView，重写zx_customSetting，设置自定义的样式
```objective-c
@implementation DemoEmptyView
//重写父类zx_customSetting方法
- (void)zx_customSetting{
    self.zx_type = 0;
}

//重写父类属性zx_type的set方法，若zx_type=0，则为暂无数据，若zx_type=1，则为网络错误，通过控制zx_type来切换显示的样式
- (void)setZx_type:(int)zx_type{
    if(zx_type == 0){
        //暂无数据的样式
        self.zx_topImageView.image = [UIImage imageNamed:@"nodata_icon"];
        self.zx_topImageView.zx_fixWidth = 100;
        self.zx_titleLabel.zx_fixTop = 20;
        self.zx_titleLabel.text = @"暂无数据";
        self.zx_titleLabel.font = [UIFont boldSystemFontOfSize:20];
        
        self.zx_detailLabel.textColor = [UIColor lightGrayColor];
        self.zx_detailLabel.font = [UIFont systemFontOfSize:14];
        self.zx_detailLabel.text = @"啊偶，这里没有东西哦~~";
        
        [self.zx_actionBtn setTitle:nil forState:UIControlStateNormal];
        
    }else{
        //网络错误的样式
        self.zx_topImageView.image = [UIImage imageNamed:@"netErr_icon"];
        self.zx_topImageView.zx_fixWidth = 100;
        self.zx_titleLabel.text = @"网络异常";
        self.zx_titleLabel.font = [UIFont boldSystemFontOfSize:20];
        
        self.zx_detailLabel.textColor = [UIColor lightGrayColor];
        self.zx_detailLabel.font = [UIFont systemFontOfSize:14];
        self.zx_detailLabel.text = @"网络错误，请检查网络设置，长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试网络错误，请检查网络设置，长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试长度测试网络错误，请检查网络设置，长度测试长度测";
        
        self.zx_actionBtn.zx_fixTop = 15;
        self.zx_actionBtn.zx_additionWidth = 15;
        self.zx_actionBtn.zx_additionHeight = 15;
        self.zx_actionBtn.layer.cornerRadius = 5;
        [self.zx_actionBtn setTitle:@"点击重试" forState:UIControlStateNormal];
        self.zx_actionBtn.backgroundColor = [UIColor orangeColor];
        [self.zx_actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
@end
```
* 在tableView控制器中进行初始化设置
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    //此处只摘要EmptyView设置相关代码
    [self.tableView zx_setEmptyView:[DemoEmptyView class]];
    self.tableView.zx_emptyContentView.zx_btnClickedBlock = ^(UIButton * _Nonnull sender) {
        NSLog(@"点击了重新加载...");
        [self.netErrBtn setTitle:@"网络正常" forState:UIControlStateNormal];
        [self netErrorAction:self.netErrBtn];
    };
    
}
```
* 若网络加载失败
```objective-c
//emptyView样式为[网络错误]
self.tableView.zx_emptyContentView.zx_type = 1;
```
* 若网络加载成功
```objective-c
//emptyView样式为[暂无数据]
self.tableView.zx_emptyContentView.zx_type = 0;
```
* 无需关心何时显示或隐藏ZXEmptyView，ZXEmptyView会自动处理
#### 具体代码可查看Demo中的DemoTableViewVC

#### 效果预览
<img src="http://www.zxlee.cn/ZXEmptyViewDemoImg/demo2.gif"/>

### ZXEmptyContentView UITableView & UICollectionView功能辅助
#### UITableView or UICollectionView开始加载的时候手动调用，将会隐藏emptyView
```objective-c
[self.tableView zx_startLoading];
```
#### UITableView or UICollectionView结束加载的时候手动调用，将会根据tableView中cell的个数决定是否显示emptyView
```objective-c
[self.tableView zx_endLoading];
```
***

### ZXEmptyContentView的其他设置
#### 手动显示ZXEmptyContentView
* 调用ZXEmptyContentView对象的zx_show方法
```objective-c
[emptyContentView zx_show];
```
* 调用ZXEmptyContentView所添加到的superView的zx_showEmptyView方法
```objective-c
[self.tableView zx_showEmptyView];
```
#### 手动隐藏ZXEmptyContentView
* 调用ZXEmptyContentView对象的zx_hide方法
```objective-c
[emptyContentView zx_hide];
```
* 调用ZXEmptyContentView所添加到的superView的zx_showEmptyView方法
```objective-c
[self.tableView zx_hideEmptyView];
```

#### 设置ZXEmptyContentView覆盖满整个superView
```objective-c
//isFull为YES，则覆盖满整个superView
[self.view zx_setEmptyView:@"DemoEmptyView" isFull:YES clickedBlock:^(UIButton * _Nullable btn) {
    NSLog(@"点击了按钮");
} emptyViewClickedBlock:^(UIView * _Nullable btn) {
    NSLog(@"点击了emptyView");
}];
```
#### 获取ZXEmptyContentView的zx_fullEmptyView(覆盖满整个superView的view)
* 通过ZXEmptyContentView对象的获取
```objective-c
ZXFullEmptyView *fullEmptyViewem = emptyContentView.zx_fullEmptyView;
```
* 通过ZXEmptyContentView所添加到的主视图获取
```objective-c
ZXFullEmptyView *fullEmptyViewem = self.view.zx_fullEmptyView;
```
#### 事实上，当ZXEmptyContentView为覆盖满整个目标view的时候，ZXEmptyContentView的superView为目标view；
#### 当ZXEmptyContentView需要覆盖满目标视图的时候，ZXEmptyContentView的superView是ZXFullEmptyView，ZXFullEmptyView的superView是目标view

***
### 完全自定义ZXEmptyView
#### 若ZXEmptyContentView中的子控件数量或种类无法满足需求，可以完全自定义，且仍然可以使用自动居中布局与自动显示
* 在控制器中
```objective-c
DemoCustomEmptyView *customEmptyView = [[[NSBundle mainBundle]loadNibNamed:@"DemoCustomEmptyView" owner:nil options:nil]lastObject];
customEmptyView.backgroundColor = [UIColor yellowColor];
customEmptyView.zx_size = CGSizeMake(300, 200);
[self.view zx_setCustomEmptyView:customEmptyView];
[self.view zx_showEmptyView];
```
#### 具体代码可查看Demo中的DemoCustomViewVC
#### 效果预览
<img src="http://www.zxlee.cn/ZXEmptyViewDemoImg/demo2.jpg"/>







