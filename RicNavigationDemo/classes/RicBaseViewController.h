//
//  RicBaseViewController.h
//  creditor
//
//  Created by john on 2017/2/27.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RicErrorView.h"
#import "RicExpandButton.h"

typedef NS_ENUM(NSInteger,RicErrorViewType) {
    /**正常状态*/
    RicErrorViewTypeNone,
    /**空页面*/
    RicErrorViewTypeEmpty,
    /**无网络*/
    RicErrorViewTypeOffline,
    /**请求错误*/
    RicErrorViewTypeRequestError
};

@interface RicBaseViewController : UIViewController
//暂定
@property (nonatomic, assign) RicErrorViewType errorViewType;

@property (nonatomic, strong, readonly) UIScrollView *errorContainerView;
@property (nonatomic, strong, readonly) UIView *contentView;

@property (nonatomic, assign) BOOL shouldExendToStatusBar;
/**
 是否要将导航条颜色同步到markUpView
 */
@property (nonatomic, assign) BOOL shouldSynchnizedNavBarColorToMarkupView;
- (void)refreshContent;
- (void)backAction;

@end
@interface RicBaseViewController(ErrorView)

- (RicErrorView *)errorViewForType:(RicErrorViewType)errorViewType;
- (void)updateErrorViewConstraints:(RicErrorView *)errorView;

@end
@interface RicBaseViewController(Layout)

/**
 这个方法不要直接调用
 */
- (void)setUpLayoutForView:(UIView *)childView;

- (void)setUpWhenNavigationIsOpaqueForScrollView:(UIScrollView *)scrollView;

@end

@interface RicBaseViewController(NavigationItem)
/**
 设置标题颜色

 @param titleColor 标题颜色
 */
- (void)setTitleColor:(UIColor *)titleColor;

- (void)setLeftNavigationItemView:(UIView *)itemView;

- (RicExpandButton *)setLeftNavigationItemWithTitle:(NSString *)title target:(id)anyObject operation:(SEL)selector;

- (RicExpandButton *)setRightNavigationItemWithTitle:(NSString *)title target:(id)anyObject operation:(SEL)selector;

- (void)hideLeftNavItem;

@end
