//
//  QSCRBaseLoginVC.h
//
//
//  Created by cosmos on 2018/11/14.
//  Copyright © 2018年 cosmos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QSCRBaseLoginVC : UIViewController

/** 背景视图图 */
@property (nonatomic, strong ,readonly) UIImageView *bgImageView;
/** 内容视图 */
@property (nonatomic, strong ,readonly) UIView *containerView;
/** logo */
@property (nonatomic, strong) UIImageView *logoImgView;
/** 账号输入 */
@property (nonatomic, strong) UITextField *accountTF;
/** 验证码输入 */
@property (nonatomic, strong) UITextField *passwordTF;
/** 登录按钮 */
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIButton *verifyBtn;

- (void)keyboardWillShow:(NSNotification *)notif;

- (void)keyboardWillHide:(NSNotification *)notif;

@end
