//
//  WebViewController.m
//  全送超人
//
//  Created by admin on 2018/11/10.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import "WebViewController.h"
#import <UIKit/UIKit.h>


@interface WebViewController()<UIWebViewDelegate>

@property(copy,nonatomic) NSString *Url;

@property(strong,nonatomic) UIWebView *webView;

@property (nonatomic, strong) NSURLRequest *request;

@property (nonatomic, assign) BOOL isAuthed; //判断是否是HTTPS的

@property (nonatomic, strong) UIBarButtonItem *backItem; //返回按钮


@property (nonatomic, strong) UIBarButtonItem *closeItem; //关闭按钮

@end

@implementation WebViewController

-(id)initWithUrl:(NSString *)url{
    self = [self init];
    if(self){
        self.Url = url;
    }
    return self;
}

-(void)viewDidLoad{
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    [self.view addSubview: _webView];
    [self addLeftButton];
    [self loadHTML: _Url];
}

- (void)loadHTML:(NSString *)htmlString{
    NSURL * url = [NSURL URLWithString: htmlString];
    NSLog(@"url==%@",url);
    _request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest: _request];
}

#pragma mark - 代理方法

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"start");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //完成加载
    //self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //加载出错
    NSLog(@"error =%@",error);
}

#pragma mark ================= NSURLConnectionDataDelegate <NSURLConnectionDelegate>

//- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
//{
//    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
//}
//
//- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
//{
//    if ([challenge previousFailureCount] == 0) {
//        self.isAuthed = YES;
//        //NSURLCredential 这个类是表示身份验证凭据不可变对象。凭证的实际类型声明的类的构造函数来确定。
//        NSURLCredential *cre = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
//        [challenge.sender useCredential:cre forAuthenticationChallenge:challenge];
//    }
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    NSLog(@"网络不给力");
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    self.isAuthed = YES;
//    //webview 重新加载请求。
//    [self.webView loadRequest:self.request];
//    [connection cancel];
//}

#pragma mark - 添加关闭按钮

- (void)addLeftButton
{
    self.navigationItem.leftBarButtonItems = @[self.backItem, self.closeItem];
}

//点击返回的方法
- (void)backNative
{
    //判断是否有上一层H5页面
    if ([self.webView canGoBack]) {
        //如果有则返回
        [self.webView goBack];
        //同时设置返回按钮和关闭按钮为导航栏左边的按钮
        self.navigationItem.leftBarButtonItems = @[self.backItem, self.closeItem];
    } else {
        [self closeNative];
    }
}

//关闭H5页面，直接回到原生页面
- (void)closeNative
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - init

- (UIBarButtonItem *)backItem
{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] init];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"back_icon"];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backNative) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //字体的多少为btn的大小
        [btn sizeToFit];
        //左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //让返回按钮内容继续向左边偏移15，如果不设置的话，就会发现返回按钮离屏幕的左边的距离有点儿大，不美观
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        btn.frame = CGRectMake(0, 0, 40, 40);
        _backItem.customView = btn;
    }
    return _backItem;
}

- (UIBarButtonItem *)closeItem
{
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeNative)];
    }
    return _closeItem;
}
@end
