//
//  RicBaseViewController.m
//  creditor
//
//  Created by john on 2017/2/27.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "RicBaseViewController.h"
#import "UIView+Const.h"
#import <Masonry/Masonry.h>

@interface RicBaseViewController ()

/**
 补充视图，用来挡住navigationBar透明时造成下一个页面动画过渡的时候还显示上一个页面的title的问题
 */
@property (nonatomic, strong) UIView *makeupView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIScrollView *errorContainerView;
//@property (nonatomic, strong)
@property (nonatomic, strong) NSMutableArray *viewsThatHasSetAutoLayout;
@property (nonatomic, strong) NSMutableDictionary *errorViews;
- (void)setUpNavigation;
- (void)backAction;

@end

@implementation RicBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self setUpNavigation];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.shouldSynchnizedNavBarColorToMarkupView && self.navigationController.navigationBar){
        self.makeupView.backgroundColor = self.navigationController.navigationBar.backgroundColor;
    }
    [self refreshContent];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)refreshContent{
    if(self.errorViewType == RicErrorViewTypeNone){
        [self setUpLayoutForView:self.contentView];
        self.contentView.hidden = NO;
        if(_errorContainerView){
            _errorContainerView.hidden = YES;
        }
    }else{
        [self setUpLayoutForView:self.errorContainerView];
        self.errorContainerView.hidden = NO;
        RicErrorView *errorView = [self errorViewForType:self.errorViewType];
        [self.errorContainerView addSubview:errorView];
        [self updateErrorViewConstraints:errorView];
        if(_contentView){
            _contentView.hidden = YES;
        }
    }
}
- (UIView *)makeupView{
    if(!_makeupView){
        _makeupView = [[UIView alloc] initWithFrame:CGRectMake(0, -[UIView topHeight], [UIView screenWidth], [UIView topHeight]+1)];
        _makeupView.backgroundColor = [UIColor whiteColor];
    }
    return _makeupView;
}
- (UIView *)contentView{
    if(!_contentView){
        _contentView = [[UIView alloc] init];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_contentView];
    }
    return _contentView;
}

- (UIScrollView *)errorContainerView{
    if(!_errorContainerView){
        _errorContainerView = [[UIScrollView alloc] init];
        _errorContainerView.backgroundColor = [UIColor whiteColor];
        _errorContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        _errorContainerView.alwaysBounceVertical = YES;
        [self.view addSubview:_errorContainerView];
    }
    return _errorContainerView;
}

- (NSMutableArray *)viewsThatHasSetAutoLayout{
    if(!_viewsThatHasSetAutoLayout){
        _viewsThatHasSetAutoLayout = [[NSMutableArray alloc] init];
    }
    return _viewsThatHasSetAutoLayout;
}
- (void)setUpNavigation{
    [self.view addSubview:self.makeupView];
    //TODO:设置返回按钮的大小
    if(self.navigationController.viewControllers.count > 1 && !self.presentingViewController){
        RicExpandButton *backBtn = [[RicExpandButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        backBtn.backgroundColor = [UIColor greenColor];
        [backBtn setImage:[UIImage imageNamed:@"AppIcon"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"AppIcon"] forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [self setLeftNavigationItemView:backBtn];
    }
    //Set up title view
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds)-120, 44)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
}
//返回事件
- (void)backAction{
    if(self.navigationController && self.navigationController.viewControllers.count > 0){
        [self.navigationController popViewControllerAnimated:YES];
    }else if(self.navigationController && self.navigationController.presentedViewController){
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
        }];
    }else if(self.presentedViewController){
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation RicBaseViewController(ErrorView)

- (RicErrorView *)errorViewForType:(RicErrorViewType)errorViewType{
    //TODO:做好ErrorView的配置
    RicErrorView *errorView = [self.errorViews objectForKey:@(errorViewType)];
    CGRect errorViewFrame = CGRectZero;
    if(!errorView){
        if(errorViewType == RicErrorViewTypeNone){
            errorView = nil;
        }else if(errorViewType == RicErrorViewTypeEmpty){
            errorView = [[RicEmptyErrorView alloc] initWithFrame:errorViewFrame];
        }else if(errorViewType == RicErrorViewTypeOffline){
            errorView = [[RicOfflineErrorView alloc] initWithFrame:errorViewFrame];
        }else{
            errorView = [[RicRequestErrorView alloc] initWithFrame:errorViewFrame];
        }
        if(errorView){
            [self.errorViews setObject:errorView forKey:@(errorViewType)];
        }
    }
    return errorView;
}
- (void)updateErrorViewConstraints:(RicErrorView *)errorView{
    CGFloat __block width = CGRectGetWidth(errorView.frame);
    CGFloat __block height = CGRectGetHeight(errorView.frame);
    CGFloat __block centerOffset = 0;
    if(self.edgesForExtendedLayout == UIRectEdgeTop){
        centerOffset = [UIView topHeight]/2.0;
    }
    [errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.errorContainerView.mas_centerX);
make.centerY.equalTo(self.errorContainerView.mas_centerY).offset(centerOffset);
    make.width.equalTo(@(width));
    make.height.equalTo(@(height));
    }];
}
@end

@implementation RicBaseViewController(Layout)

- (void)setUpLayoutForView:(UIView *)childView
{
    if(!childView || [self.viewsThatHasSetAutoLayout containsObject:childView]){
        return;
    }
    [self.viewsThatHasSetAutoLayout addObject:childView];
    if(@available(iOS 9.0,*)){
        NSLayoutConstraint *topConstraint = nil;
        NSLayoutConstraint *leadingConstraint = nil;
        NSLayoutConstraint *traiingConstraint = nil;
        NSLayoutConstraint *bottomConstraint = nil;
        UILayoutGuide *guide = nil;
        if(@available(iOS 11.0,*)){
            guide = self.view.safeAreaLayoutGuide;
        }else{
            guide = self.view.layoutMarginsGuide;
        }
        topConstraint = [childView.topAnchor constraintEqualToAnchor:guide.topAnchor];
        if(@available(iOS 11.0,*)){
            if( self.shouldExendToStatusBar){
                CGFloat height = self.navigationController.navigationBarHidden ? [UIView statusBarHeight]:[UIView topHeight];
                topConstraint = [childView.topAnchor constraintEqualToAnchor:guide.topAnchor constant:-height];
            }
        }
        CGFloat standLinespace = 16.0;
        if(@available(iOS 11.0,*)){
            standLinespace = 0.0;
        }
        bottomConstraint = [guide.bottomAnchor constraintEqualToAnchor:childView.bottomAnchor];
        leadingConstraint = [childView.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:-standLinespace];
        traiingConstraint = [childView.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:standLinespace];
        [NSLayoutConstraint activateConstraints:@[leadingConstraint,
                                                  traiingConstraint,
                                                  topConstraint,
                                                  bottomConstraint
                                                  ]];
    }else{
        [childView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
}

- (void)setUpWhenNavigationIsOpaqueForScrollView:(UIScrollView *)scrollView
{
    if(!scrollView){
        return;
    }
    self.extendedLayoutIncludesOpaqueBars = YES;
    if(@available(iOS 11.0,*)){
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    scrollView.scrollIndicatorInsets = scrollView.contentInset;
}
@end


@implementation RicBaseViewController(NavigationItem)

//TODO
- (void)setLeftNavigationItemView:(UIView *)itemView{
    if(!itemView){
        return;
    }
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:itemView];
    self.navigationItem.leftBarButtonItem = buttonItem;
}
//TODO
- (void)setRightNavigationItemView:(UIView *)itemView{
    if(!itemView){
        return;
    }
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:itemView];
    self.navigationItem.rightBarButtonItem = buttonItem;
}
- (RicExpandButton *)setLeftNavigationItemWithTitle:(NSString *)title target:(id)anyObject operation:(SEL)selector{
    if(!title){
        return nil;
    }
    RicExpandButton *leftBtn = [self generateNavigationBtnWithTitle:title target:anyObject operation:selector];
    [self setLeftNavigationItemView:leftBtn];
    return leftBtn;
}

- (RicExpandButton *)setRightNavigationItemWithTitle:(NSString *)title target:(id)anyObject operation:(SEL)selector {
    if(!title){
        return nil;
    }
    RicExpandButton *rightBtn = [self generateNavigationBtnWithTitle:title target:anyObject operation:selector];
    [self setRightNavigationItemView:rightBtn];
    
    return rightBtn;
}
- (RicExpandButton *)generateNavigationBtnWithTitle:(NSString *)title target:anyObject operation:(SEL)selector{
    CGRect btnFrame = [title boundingRectWithSize:CGSizeMake(100, 30) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:NULL];
    RicExpandButton *navBtn = [[RicExpandButton alloc] initWithFrame:btnFrame];
    navBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [navBtn setTitle:title forState:UIControlStateNormal];
    [navBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [navBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateHighlighted];
    if(anyObject && [anyObject respondsToSelector:selector]){
        [navBtn addTarget:anyObject action:selector forControlEvents:UIControlEventTouchUpInside];
    }

    return navBtn;
}
- (void)hideLeftNavItem{
    self.navigationItem.leftBarButtonItem = nil;
}
- (void)setTitleColor:(UIColor *)titleColor{
    [((UILabel *)self.navigationItem.titleView) setTextColor:titleColor?:[UIColor darkTextColor]];
}

- (void)setTitle:(NSString *)title{
    [((UILabel *)self.navigationItem.titleView) setText:title?:@""];
}

@end
