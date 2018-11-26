//
//  FeedbackController.m
//  全送超人
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "FeedbackController.h"
#import "FontAndColorMacros.h"
#import "FeedbackLogic.h"
#import <Masonry/Masonry.h>
#import "MBProgressHUD+XY.h"


@interface FeedbackController()<UITextViewDelegate>
@property (strong, nonatomic) UITextView *contentTextView;
@property (strong, nonatomic) UILabel *descLab;
@property (strong, nonatomic) UIButton *sendBtn;
@property (strong, nonatomic) UILabel *stringlenghtLab;
@property (assign, nonatomic) CGSize descLabSize;
@property (strong, nonatomic) FeedbackLogic * feedbackLogic;
@end

@implementation FeedbackController


- (void)viewDidLoad{
    [self setUI];
    // 布局
    [self make_layout];
    _feedbackLogic = [[FeedbackLogic alloc] init];
}

- (void)setUI{
    [self addNavigationItemWithTitles
     :@[@"提交"] isLeft:NO target:self action:@selector(naviBtnClick:) tags:@[@1000]];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.title = @"意见反馈";
  
    NSDictionary *titleTextAttDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil, NSShadowAttributeName, nil];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(naviBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(300, 0, 30, 40);
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 30, 40);
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    [self.navigationItem setLeftBarButtonItem: leftBarButtonItem];
    [self.navigationItem setRightBarButtonItem: rightBarButtonItem];
    [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttDict];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];

    //self.navigationController.navigationBar.topItem.leftBarButtonItem.title = @"";
    _contentTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    _descLab = [[UILabel alloc]initWithFrame:CGRectZero];
    _stringlenghtLab = [[UILabel alloc]initWithFrame:CGRectZero];
    
    [self.view addSubview:_contentTextView];
    [self.view addSubview:_stringlenghtLab];
    [self.view addSubview:_descLab];
    [self.view setBackgroundColor:CViewBgColor];
  
    
    _contentTextView.delegate = self;
    _contentTextView.font = [UIFont systemFontOfSize:15];
    _stringlenghtLab.text = @"0/100";
    _stringlenghtLab.textColor = CFBTextColor;
    _stringlenghtLab.font = [UIFont systemFontOfSize:18];
    _descLab.text = @"请输入产品意见，我们将不断优化体验!";
    _descLab.font = [UIFont systemFontOfSize:15];
    _descLab.textColor = CFBTextColor;
    _descLab.userInteractionEnabled = NO;
    _descLabSize = [self sizeWithString: _descLab.text font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
}

- (void)make_layout{
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(345);
        make.height.mas_equalTo(240);
        make.top.mas_equalTo(85);
        make.left.mas_equalTo(15);
    }];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_descLabSize.width + 20);
        make.height.mas_equalTo(_descLabSize.height);
        make.top.mas_equalTo(self.contentTextView.mas_top).with.offset(10);
        make.left.mas_equalTo(self.contentTextView.mas_left).with.offset(15);
    }];
    
    [self.stringlenghtLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(self.contentTextView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(300);
        //make.rightMargin.mas_equalTo(self.view.mas_left).with.offset(20);
    }];
}

#pragma mark ----------- 提交回调 -----------------
- (void) naviBtnClick:(id)sender{

    [_feedbackLogic loadData:self.contentTextView.text CompletionBlock:^(BOOL success, NSString * _Nonnull error) {
        if(success){
            [MBProgressHUD showSuccessMessage:@"提交成功"];
             self.contentTextView.text =@"";
             self.descLab.hidden = NO;
        }else{
            [MBProgressHUD showErrorMessage:error];
        }
    }];
   
}

-(void)backBtnClicked:(UIButton*)sender
{
    NSDictionary *titleTextAttDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil, NSShadowAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttDict];
    [self.navigationController.navigationBar setBarTintColor:CNavBgColor];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textViewDidChange:(UITextView *)textView
{
    self.descLab.hidden = YES;
    textView.font = [UIFont systemFontOfSize:15];
    
    //字数限制
    if (textView.text.length >= 100) {
        textView.text = [textView.text substringToIndex:100];
        self.stringlenghtLab.text = @"100/100";
        [textView endEditing:YES];
        [MBProgressHUD showErrorMessage:@"字数太多"];
    } else {
        
        //实时显示字数
        self.stringlenghtLab.text = [NSString stringWithFormat:@"%ld/100",(long)textView.text.length];

    }
    
    
    //取消按钮点击权限，并显示文字
    if (textView.text.length == 0) {
        self.descLab.hidden = NO;
        self.sendBtn.userInteractionEnabled = NO;
        self.sendBtn.backgroundColor = [UIColor lightGrayColor];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [self.contentTextView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}


- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}

@end
