# OpenDingTalkHelperForiOS

## 【推荐】钉钉打卡助手uni-app版，支持iOS和安卓👉 https://github.com/SmileZXLee/uni-dingTalkHelper

## OpenDingTalkHelperForiOS的开发离不开以下第三方框架
* ToastView: [ALToastView](https://github.com/alexleutgoeb/ALToastView)
* ToastView: UIView+Toast
* 用户引导视图: FeatureGuideView
* 选择器控件: [BRPickerView](https://github.com/91renb/BRPickerView)
* 短信验证码输入框，支持密文模式: [CRBoxInputView](https://github.com/CRAnimation/CRBoxInputView)
* 一个封装好的指纹、FaceID验证库,可以用来做iOSAPP的登录/支付等验证: [TDTouchID](https://github.com/greezi/TDTouchID)
* 快速构建TableView: [ZXTableView](https://github.com/SmileZXLee/ZXTableView)
* 滑动选择TableView: [ZXSlideSelectTableView](https://github.com/SmileZXLee/ZXSlideSelectTableView)
* 空数据与网络错误视图: [ZXEmptyView](https://github.com/SmileZXLee/ZXEmptyView)
* 数据处理与数据存储: [ZXDataHandle](https://github.com/SmileZXLee/ZXDataHandle)
* 自定义导航栏: [ZXNavigationBar](https://github.com/SmileZXLee/ZXNavigationBar)

***

## OpenDingTalkHelperForiOS的开发离不开[@kunlingyijia](https://github.com/kunlingyijia)的idea和建议

***

### 反馈&交流qq群：[790460711](https://jq.qq.com/?_wv=1027&k=vU2fKZZH)

## 功能&特点
- [x] 支持自定义设置上班/下班打卡时间区间
- [x] 通过定时打开钉钉，并在钉钉中设置极速打卡以达到远程打卡的目的
- [x] 在指定范围内随机生成打卡时间
- [x] 自动打卡记录自动存储
- [x] 一键息屏，降低能耗
- [x] 密码保护，隐私无忧

## 安装

### 如果您是iOS开发者
* 下载项目并通过Xcode将OpenDingTalkHelperForiOS安装至您的设备上

### 如果您不是iOS开发者
#### [点击此处直接下载OpenDingTalkHelperForiOS安装包](http://www.zxlee.cn/github/OpenDingTalkHelperForiOS/OpenDingTalkHelperForiOS.ipa)
#### 使用[Impactor](http://www.cydiaimpactor.com)或[爱思助手](https://www.i4.cn/news_detail_38195.html)进行重签名与安装(此处以Impactor为例，使用爱思助手可参照官网步骤)
* 点击上方链接进入官网，下载对应系统版本的安装包
* 打开Impactor，将OpenDingTalkHelperForiOS.ipa拖入窗体中
* 输入自己的AppleID账号和密码即可安装
* 若您的AppleID开启了双重认证，请至[官网](https://appleid.apple.com/account/manage)设置并使用您的(APP-SPECIFIC PASSWORDS)
* 普通用户签名有效期为7天，到期需按上方步骤重新签名，付费开发者不限制天数，若您担心影响开发者账号，可以重新注册一个账号。 

## 注意
* 此应用【钉钉定时打卡助手】仅限用于定时打开钉钉，非定位修改软件，需要把手机放在公司。
* 【权限授予】您必须授予【钉钉定时打卡助手】通知权限，且第一次跳转至钉钉时点击“允许”才可以正常使用定时跳转功能。
* 手机系统时间必须修改为24小时制。
* 请设置“打卡起始时间”与“打卡结束时间”，【钉钉定时打卡助手】将在此时间段内生成随机的时间：“下次打卡时间”，并在“下次打卡时间”到来的时候跳转至钉钉。
* 请设置“星期”，默认为每天，“下次打卡时间”受“打卡起始时间”、“打卡结束时间”与“星期”三者共同制约，“下次打卡时间”的生成规则为在“打卡起始时间”与“打卡结束时间”之间，且在“星期”之间。
* 设定的打开钉钉的时间必须在极速打卡的有效时间范围之内(钉钉默认的极速打卡时间为上班时间-上班时间后1小时，下班时间-下班时间后1小时，若您设置的打卡钉钉时间不在此范围内，请先在钉钉-考勤打卡-设置-快捷打卡方式中更改)。
* 【钉钉定时打卡助手】会自动保持屏幕常亮，您无需更改系统设置，若要正常跳转至钉钉，请务必保持【钉钉定时打卡助手】始终在前台且电量充足，切勿锁屏。
* 开发者不对使用此应用造成的任何后果负责，也无法保证应用一定不会出现跳转不了的情况，同样也无法保证应用无BUG，因此请您不要依赖此应用，仅可当作应急后备之用途，若有任何意见和反馈可以在issue中反馈，我会尽快为您解决。
* 此应用是免费的，请勿用于任何商业用途，请勿用于马甲包等任何非法用途，请勿上架，转载请注明出处，感谢理解。



## 预览
<img src="http://www.zxlee.cn/OpenDingTalkHelperForiOSDemo1.gif"/>
