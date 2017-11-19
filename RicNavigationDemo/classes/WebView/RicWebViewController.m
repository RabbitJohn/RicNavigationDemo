//
//  RicWebViewController.m
//  Kuoke
//
//  Created by Rice on 2017/11/16.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "RicWebViewController.h"
#import "RicWebView.h"
#import <Masonry/Masonry.h>
@interface RicWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) RicWebView *webview;

@end

@implementation RicWebViewController

- (void)setRequest:(NSURLRequest *)request{
    _request = request;
    if(!_request){
        return;
    }
    [self.webview loadRequest:_request];
}

- (RicWebView *)webview{
    if(!_webview){
        _webview = [[RicWebView alloc] init];
        _webview.UIDelegate = self;
        _webview.navigationDelegate = self;
    }
    return _webview;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [((RicNavigationBar *)self.navigationController.navigationBar) startPushAnimation];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
//    [((RicNavigationBar *)self.navigationController.navigationBar) startPopAnimation];
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"xxx";
    [self.contentView addSubview:self.webview];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)backAction{
    if(self.webview.canGoBack){
        [self.webview goBack];
    }else{
        [super backAction];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures;

//API_AVAILABLE(ios(9.0));
- (void)webViewDidClose:(WKWebView *)webView {
    
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler{
    
}
//API_AVAILABLE(ios(10.0));
//- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo {
//
//}
//
////API_AVAILABLE(ios(10.0));
//- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions{
//
//}
//API_AVAILABLE(ios(10.0));
//- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController {
//
//}


@end
