//
//  ODSecurityVC.m
//  OpenDingTalkHelperForiOS
//
//  Created by 李兆祥 on 2020/4/21.
//  Copyright © 2020 ZXLee. All rights reserved.
//

#import "ODSecurityVC.h"
#import "CRBoxInputView.h"
#import "CRSecrectImageView.h"
#import "Masonry.h"
#import "TDTouchID.h"

@interface ODSecurityVC ()
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *securityView;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UILabel *leftMainTitleLabel;
@property (copy, nonatomic) NSString *lastSecurityStr;
@property (weak, nonatomic) CRBoxInputView *boxInputView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIButton *touchIdCheckBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleH;
@end

@implementation ODSecurityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{
    self.zx_hideBaseNavBar = YES;
    self.confirmBtn.enabled = YES;
    self.leftMainTitleLabel.adjustsFontSizeToFitWidth = YES;
    self.confirmBtn.backgroundColor = [UIColor darkGrayColor];
    self.titleH.constant = 0;
    if(self.type == ODSecurityTypeSetPwd){
        self.closeBtn.hidden = NO;
        self.touchIdCheckBtn.hidden = YES;
    }else{
        if(self.type != ODSecurityTypeCheckPwd){
            self.closeBtn.hidden = YES;
        }
        self.touchIdCheckBtn.hidden = NO;
        
        [self.confirmBtn setTitle:@"验证" forState:UIControlStateNormal];
        if(IsBangScreen){
            self.subTitleLabel.text = @"请验证FaceID";
            [self.touchIdCheckBtn setTitle:@"- 使用FaceID验证 -" forState:UIControlStateNormal];
        }else{
            self.subTitleLabel.text = @"请验证指纹";
            
        }
        self.leftMainTitleLabel.text = @"安全密码验证";
        if(self.type == ODSecurityTypeCheckPwd){
            self.leftMainTitleLabel.text = @"验证身份以关闭密码保护";
        }
        if(self.type != ODSecurityTypeShowCover){
            [self securityCheck];
        }else{
            self.confirmBtn.enabled = NO;
            self.confirmBtn.backgroundColor = [UIColor lightGrayColor];
            self.subTitleLabel.text = @"请验证访问密码";
        }
    }
    if(IsBangScreen){
        [self.closeBtn setTitle:@"- 使用FaceID验证 -" forState:UIControlStateNormal];
    }
    
    [self.closeBtn setImage:[UIImage imageNamed:@"close_icon"] forState:UIControlStateNormal];
    self.titleLabel.text = @"";
    self.confirmBtn.clipsToBounds = YES;
    self.confirmBtn.layer.cornerRadius = 22;
    __weak typeof(self) weakSelf = self;
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    cellProperty.borderWidth = 0;
    cellProperty.cellCursorColor = [UIColor darkGrayColor];
    cellProperty.showLine = YES; //必需
    cellProperty.customLineViewBlock = ^CRLineView * _Nonnull{
        CRLineView *lineView = [CRLineView new];
        [lineView.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(4);
            make.left.right.bottom.offset(0);
        }];
        
        return lineView;
    };
    CRBoxInputView *boxInputView = [CRBoxInputView new];
    boxInputView.ifNeedSecurity = YES;
    boxInputView.customCellProperty = cellProperty;
    [boxInputView loadAndPrepareViewWithBeginEdit:self.type != ODSecurityTypeShowCover];
    boxInputView.textDidChangeblock = ^(NSString * _Nullable text, BOOL isFinished) {
        weakSelf.titleLabel.text = text;
        if(weakSelf.type == ODSecurityTypeSetPwd){
            weakSelf.lastSecurityStr = text;
        }
        if(text.length < 4){
            weakSelf.confirmBtn.enabled = NO;
            weakSelf.confirmBtn.backgroundColor = [UIColor lightGrayColor];
        }else{
            weakSelf.confirmBtn.enabled = YES;
            weakSelf.confirmBtn.backgroundColor = [UIColor darkGrayColor];
        }
        if(text.length == 0){
            CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animateShowTitle:)];
            [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        }else if(text.length == 1){
            CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animateShowTitle:)];
            [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        }
        
    };
    self.boxInputView = boxInputView;
    [self.securityView addSubview:boxInputView];
    if(self.type == ODSecurityTypeSetPwd){
        self.confirmBtn.enabled = NO;
        self.confirmBtn.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.boxInputView.frame = self.securityView.bounds;
}

- (void)animateShowTitle:(CADisplayLink *)cl{
    if(self.boxInputView.textValue.length == 0){
        if(self.titleH.constant > 0){
            self.titleH.constant -= 3;
        }else{
            [cl invalidate];
        }
    }else{
        if(self.titleH.constant < 36){
            self.titleH.constant += 3;
        }else{
            [cl invalidate];
        }
    }
}

- (IBAction)confirmAction:(id)sender {
    if(self.type == ODSecurityTypeSetPwd){
        self.type = ODSecurityTypeSettingPwd;
        self.subTitleLabel.text = @"请确认访问密码";
        [self.boxInputView clearAllWithBeginEdit:YES];
        [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        self.confirmBtn.backgroundColor = [UIColor lightGrayColor];
    }else if(self.type == ODSecurityTypeSettingPwd){
        if([self.boxInputView.textValue isEqualToString:self.lastSecurityStr]){
            if(self.setSuccessBlock){
                self.setSuccessBlock();
            }
            [ODBaseUtil showToast:@"设置成功"];
            [[NSUserDefaults standardUserDefaults]setObject:self.boxInputView.textValue forKey:ODSecurityPwdKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self dismiss];
        }else{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.boxInputView clearAll];
            });
            self.confirmBtn.enabled = NO;
            self.confirmBtn.backgroundColor = [UIColor lightGrayColor];
            [ODBaseUtil showToast:@"两次输入的密码不一致"];
        }
    }else{
        NSString *securStr = [[NSUserDefaults standardUserDefaults]objectForKey:ODSecurityPwdKey];
        if(securStr.length && [self.boxInputView.textValue isEqualToString:securStr]){
            [self dismiss];
            if(self.checkSuccessBlock){
                self.checkSuccessBlock();
            }
        }else{
            [ODBaseUtil showToast:@"密码错误，请重试"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.boxInputView clearAll];
            });
        }
    }
}

- (IBAction)closeAction:(id)sender {
    [self dismiss];
}
- (IBAction)touchIdCheckAction:(id)sender {
    if(IsBangScreen){
        [self.closeBtn setTitle:@"- 使用FaceID验证 -" forState:UIControlStateNormal];
        self.subTitleLabel.text = @"请验证FaceID";
    }else{
        self.subTitleLabel.text = @"请验证指纹";
        
    }
    [self securityCheck];
}


- (void)securityCheck{
    TDTouchID *touchID = [[TDTouchID alloc] init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view endEditing:YES];
    });
    [touchID td_showTouchIDWithDescribe:@"验证您的身份以继续"  BlockState:^(TDTouchIDState state, NSError *error) {
        if (state == TDTouchIDStateNotSupport) {    //不支持TouchID/FaceID
            [ODBaseUtil showToast:@"此设备不支持生物验证或错误次数过多，请输入密码"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.boxInputView clearAll];
            });
            self.subTitleLabel.text = @"请验证访问密码";
            
        } else if (state == TDTouchIDStateSuccess) {    //TouchID/FaceID验证成功
            [self dismiss];
            if(self.type == ODSecurityTypeCheckPwd){
                if(self.checkSuccessBlock){
                    self.checkSuccessBlock();
                }
            }
            
        } else{ //用户选择手动输入密码
            [ODBaseUtil showToast:@"请验证访问密码"];
            [self .boxInputView clearAll];
            self.subTitleLabel.text = @"请验证访问密码";
        }
        
    }];
}


- (void)dismiss{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
