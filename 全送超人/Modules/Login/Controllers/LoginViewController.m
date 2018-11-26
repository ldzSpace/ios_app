//
//  QSCRLoginVC.m
//  
//
//  Created by cosmos on 2018/11/14.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import "LoginViewController.h"
#import "VerifyCodeData.h"
#import "LoginReq.h"
#import "VerifyCodeReq.h"
#import "TokenModel.h"
#import "YYCache.h"
#import "UserManager.h"
#import "PersonPageController.h"
#import <YTKNetwork/YTKNetwork.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <TCWebCodesSDK/TCWebCodesBridge.h>
#import <Masonry.h>

#define kTradePWD_LENGTH_LIMIT 4

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *accountLine;
@property (nonatomic, strong) UIView *passwordLine;
@property (nonatomic, strong) MBProgressHUD *HUD;

@end

static const CGFloat kMaxW = 315.f;
static const CGFloat kBtnH = 45.f;
static const CGFloat kBtnY = 40.f;
static const CGFloat kATFY = 46.f;
static const CGFloat kTextFieldH = 59.f;
static const CGFloat kLoginFontSize = 16.f;
static const CGFloat kOtherFontSize = 13.f;
static const CGFloat kTFLeftW = 35.f;
static const CGFloat kTFLeftH = 35.f;


static const CGFloat kLgnWH = 70.f;
static const CGFloat kLgnTop = 116.f;

@implementation LoginViewController

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self hideKeyboard];
}

#pragma mark - About UI
- (void)setupUI{
    
    /** 设置self.view */
    self.view.backgroundColor = [UIColor whiteColor];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//    [self.view addGestureRecognizer:tap];
    
    /** 设置背景 */
    //[self.bgImageView setImage:[UIImage imageNamed:@"login_bg01.jpg"]];
    [self.view addSubview:self.bgImageView];
    
    /** 设置内容视图 */
    self.containerView.backgroundColor = [UIColor clearColor];
    [self.bgImageView addSubview:self.containerView];
    
    /** 设置logo */
    [self.logoImgView setImage:[UIImage imageNamed:@"登录全送超人@2x.png"]];
    [self.containerView addSubview:self.logoImgView];

    /** 设置账号输入 */
    self.accountTF.placeholder = @"手机号";
    //self.accountTF.tintColor = [UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1.0];
    self.accountTF.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    self.accountTF.font = [UIFont systemFontOfSize:kOtherFontSize];
    self.accountTF.leftViewMode = UITextFieldViewModeAlways;
    self.accountTF.tag = 101;
    self.accountTF.delegate = self;
    [self.accountTF setValue:[UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    UIImageView *accountImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kTFLeftW, kTFLeftH)];
    accountImageV.contentMode = UIViewContentModeLeft;
    accountImageV.image = [UIImage imageNamed:@"cellphone.png"];
    self.accountTF.leftView = accountImageV;
    [self.containerView addSubview:self.accountTF];
    
    UIView *accountLine = [[UIView alloc] init];
    accountLine.backgroundColor = [UIColor colorWithRed:232.0/255 green:232.0/255 blue:232.0/255 alpha:1.0];
    self.accountLine = accountLine;
    [self.accountTF addSubview:accountLine];

    /** 设置验证码输入 */
    UIImageView *passwordImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kTFLeftW, kTFLeftH)];
    passwordImageV.contentMode = UIViewContentModeLeft;
    passwordImageV.image = [UIImage imageNamed:@"verify.png"];
    
    self.verifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.verifyBtn.backgroundColor = [UIColor clearColor];
    //CGSize buttonTextSize = [self sizeWithString:@"重新发送(201)" font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.verifyBtn.titleLabel.font = [UIFont systemFontOfSize: 15];
    [self.verifyBtn setTitleColor:[UIColor colorWithRed:33.0/255 green:91.0/255 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    self.verifyBtn.frame = CGRectMake(0, 0, 100, 59);
    [self.verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.verifyBtn.tag = 100;
    
    [self.verifyBtn addTarget:self action:@selector(verifyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //self.passwordTF.tintColor = [UIColor redColor];
    self.passwordTF.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    self.passwordTF.font = [UIFont systemFontOfSize:kOtherFontSize];
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.leftView = passwordImageV;
    self.passwordTF.tag = 102;
    self.passwordTF.rightView = self.verifyBtn;
    self.passwordTF.rightViewMode = UITextFieldViewModeAlways;
    
    self.passwordTF.placeholder = @"请输入验证码";
    self.passwordTF.delegate = self;
    [self.passwordTF setValue:[UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [self.containerView addSubview:self.passwordTF];
    
    UIView *passwordLine = [[UIView alloc] init];
    passwordLine.backgroundColor = [UIColor colorWithRed:232.0/255 green:232.0/255 blue:232.0/255 alpha:1.0];
    self.passwordLine = passwordLine;
    [self.passwordTF addSubview:passwordLine];
    
    /** 设置登录按钮 */
    self.loginBtn.layer.cornerRadius = 20.f;
    self.loginBtn.layer.masksToBounds = YES;
    //self.loginBtn.layer.borderWidth = 1.f;
    self.loginBtn.backgroundColor = [UIColor colorWithRed:33.0/255 green:91.0/255 blue:1 alpha:1.0];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:kLoginFontSize];
    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [self.containerView addSubview:self.loginBtn];

    /** 布局 */
    [self make_layout];
}

-(void)verifyBtnClick:(UIButton*)btn
{
    [self hideKeyboard];
    if (self.accountTF.text.length != 11)
    {
        [self loginButtonAction:@"请输入正确的手机号"];
        return;
    }
    //滑动验证码
    [[TCWebCodesBridge sharedBridge] loadTencentCaptcha:self.view appid:@"2068908163" callback:^(NSDictionary *resultJSON){
        if (0 == [resultJSON[@"ret"] intValue])
        {
            VerifyCodeData *data = [[VerifyCodeData alloc] initWithStuff];
            data.ticket = resultJSON[@"ticket"];
            data.randstr = resultJSON[@"randstr"];
            data.deviceToken = @"";
            data.mobile = self.accountTF.text;
            //[data show];
            NSLog(@"验证成功");
            //倒计时
            __block NSInteger time = 59; //倒计时时间
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            
            dispatch_source_set_event_handler(_timer, ^{
                
                if(time <= 0){ //倒计时结束，关闭
                    
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //设置按钮的样式
                        [self.verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                        [self.verifyBtn setTitleColor:[UIColor colorWithRed:33.0/255 green:91.0/255 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
                        self.verifyBtn.userInteractionEnabled = YES;
                    });
                    
                }else{
                    
                    int seconds = time % 60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //设置按钮显示读秒效果
                        [self.verifyBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                        [self.verifyBtn setTitleColor:[UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0] forState:UIControlStateNormal];
                        self.verifyBtn.userInteractionEnabled = NO;
                    });
                    time--;
                }
            });
            dispatch_resume(_timer);
            //获取验证码的网络请求
            VerifyCodeReq *api = [[VerifyCodeReq alloc] initWithVerifyCodeData:data];
            [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request)
             {
                 NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableLeaves error:nil];
                 int code = (int)[jsonDict objectForKey:@"code"];
                 NSLog(@"验证码回调%d",code);
             }
             failure:^(YTKBaseRequest *request)
             {
                 //弹框提示
                 NSLog(@"failed = %@\n", request.error);
                 [self loginButtonAction:@"网络错误，请重试2"];
             }];
            
            
        }
        else
        {
            [self loginButtonAction:@"网络错误，请重试3"];
            return;
        }
    }];
    
    
}

- (void)make_layout{
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kLgnWH);
        make.height.mas_equalTo(kLgnWH);
        make.top.mas_equalTo(self.containerView.mas_top).with.offset(kLgnTop);
        make.centerX.mas_equalTo(self.containerView);
    }];
    
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kMaxW);
        make.height.mas_equalTo(kTextFieldH);
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.logoImgView.mas_bottom).with.offset(kATFY);
    }];
    
    [self.accountLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kMaxW);
        make.centerX.mas_equalTo(self.containerView);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(.5f);
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kMaxW);
        make.height.mas_equalTo(kTextFieldH);
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.accountLine.mas_bottom);
    }];
    
    [self.passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kMaxW);
        make.centerX.mas_equalTo(self.containerView);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(.5f);
    }];

    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kMaxW);
        make.height.mas_equalTo(kBtnH);
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.passwordLine.mas_bottom).with.offset(kBtnY);
    }];

    
}

- (void)loginButtonAction:(NSString*)str
{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];

    _HUD.labelText = str;
    _HUD.mode = MBProgressHUDModeText;
    
    [_HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    }
    completionBlock:^{
        [_HUD removeFromSuperview];
        _HUD = nil;
    }];
}

#pragma mark - Request Data

#pragma mark - Pravite Method
- (void)hideKeyboard{

    [self.view endEditing:YES];
}

#pragma mark - Public Method

#pragma mark - Event response
- (void)tapAction{
    NSLog(@"close");
    [self hideKeyboard];
}

- (void)loginAction:(UIButton *)sender{

    [self hideKeyboard];
    if (self.accountTF.text.length != 11)
    {
        [self loginButtonAction:@"请输入正确的手机号"];
    }
    else if (self.passwordTF.text.length != 4)
    {
        [self loginButtonAction:@"请输入正确的验证码"];
    }
    
    NSDictionary *params = @{@"mobile":self.accountTF.text, @"smsCode":self.passwordTF.text};
    NSLog(@"pragms = %@",params);
    
    [userManager login:kUserLoginTypePwd params:params completion:^(BOOL success, NSString * _Nonnull des) {
        if(success){
            NSLog(@"desc1==%@",des);
            if(self.navigationController){
                [self.navigationController popViewControllerAnimated:YES];
               
            } else{
                [self dismissViewControllerAnimated:NO completion:nil];//从nextVC界面回去
            }
        }else{
            NSLog(@"desc==%@",des);
        }
    }];
}

- (void)registAction:(UIButton *)sender{
    
    [self hideKeyboard];
    
}

- (void)resetPasswordAction:(UIButton *)sender{
    
    [self hideKeyboard];
}

- (BOOL)shouldMoblieString:(NSString *)number
{
    NSCharacterSet *firstSet = [NSCharacterSet characterSetWithCharactersInString:@"1"];
    NSCharacterSet *middleSet = [NSCharacterSet characterSetWithCharactersInString:@"345678"];
    NSCharacterSet *lastSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    // 手机号输入限制
    if (1 < number.length)
    {
        NSString *firstStr = [number substringToIndex:1];
        NSRange firstRange = [firstStr rangeOfCharacterFromSet:firstSet];
        if (firstRange.location == NSNotFound)
        {
            return NO;
        }
        // 第二位输入为3-9
        NSString *middleStr = [number substringWithRange:NSMakeRange(1, 1)];
        if (middleStr && 0 != middleStr.length)
        {
            NSRange middleRange = [middleStr rangeOfCharacterFromSet:middleSet];
            if (middleRange.location == NSNotFound)
            {
                return NO;
            }
        }
        // 第3~11位输入为0~9
        NSString *lastStr = [number substringFromIndex:2];
        if (lastStr && 0 != lastStr.length)
        {
            NSRange lastRange = [lastStr rangeOfCharacterFromSet:lastSet];
            if (lastRange.location == NSNotFound)
            {
                return NO;
            }
        }
        
    }
    else if (1 == number.length)
    {
        // 首位只能输入1
        NSRange firstRange = [number rangeOfCharacterFromSet:firstSet];
        if (firstRange.location == NSNotFound)
        {
            return NO;
        }
    }
    // 手机号最多11位
    if (11 < number.length)
    {
        return NO;
    }
    return YES;
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

#pragma mark - Delegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField.tag == 101)
    {
        return [self shouldMoblieString:aString];
    }
    else
    {
        if ([self validateNumber:string]) {
            //文字长度限制
            if ([aString length] > kTradePWD_LENGTH_LIMIT) {
                textField.text = [aString substringToIndex:kTradePWD_LENGTH_LIMIT];
                return NO;
            }
        }
        else
        {
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self hideKeyboard];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self hideKeyboard];
}

@end
