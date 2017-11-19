//
//  RicNavigationBar.m
//  Kuoke
//
//  Created by Rice on 2017/11/13.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "RicNavigationBar.h"
#import "UIView+Const.h"

@interface RicNavigationBar()
{
    UIColor *bgColor;
}
@property (nonatomic, assign) CGFloat extendHeight;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation RicNavigationBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
    }
    return self;
}

- (CGFloat)extendHeight{
    return self.shouldExtendbackgroundColorToStatusBar ? 100:0;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    bgColor = backgroundColor;
    [self layoutIfNeeded];
    [self setNeedsLayout];
}

- (UIColor *)backgroundColor{
    return bgColor;
}

- (UIView *)backgroundView{
    if(!_backgroundView){
        CGFloat extend = [self extendHeight];
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIView navigationBarHeight] - [UIView topHeight] - extend, CGRectGetWidth([UIScreen mainScreen].bounds), [UIView topHeight] + extend)];
        _backgroundView.layer.zPosition = -10000;
        [self addSubview:_backgroundView];
        [self sendSubviewToBack:_backgroundView];
    }
    return _backgroundView;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{

    UINavigationItem *lastItem = [self.items lastObject];
    if(lastItem){
        UIView *__block targetView = nil;
        [lastItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView *view = [self responsePoint:point view:[obj customView]];
            targetView = view;
            *stop = view != nil;
        }];
        BOOL willStop = targetView != nil;
        if(!willStop){
            [lastItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIView *view = [self responsePoint:point view:[obj customView]];
                targetView = view;
                *stop = view != nil;
            }];
        }
        willStop = targetView != nil;
        if(!willStop && lastItem.titleView){
            targetView = [self responsePoint:point view:lastItem.titleView];
            willStop = targetView != nil;
        }
        return targetView;
    }else{
        return [super hitTest:point withEvent:event];
    }
}

- (UIView *)responsePoint:(CGPoint)point view:(UIView *)view{
    if(!view){
        return nil;
    }
    UIView *targetView = nil;
    CGRect viewFrame = view.frame;
    if(CGPointEqualToPoint(viewFrame.origin, CGPointZero)){
        viewFrame = [view convertRect:view.frame toView:self];
    }
    CGFloat width = CGRectGetWidth(viewFrame);
    CGFloat height = CGRectGetHeight(viewFrame);
    CGFloat minDemension = MIN(width, height);
    if(minDemension < 44){
        if(width < 44){
            viewFrame = CGRectMake(viewFrame.origin.x-22, viewFrame.origin.y, viewFrame.size.width+44, viewFrame.size.height);
        }else{
            viewFrame = CGRectMake(viewFrame.origin.x, viewFrame.origin.y-22, viewFrame.size.width, viewFrame.size.height+44);
        }
    }
    if([view isKindOfClass:[UIButton class]] && CGRectContainsPoint(viewFrame, point)){
        targetView = view;
    }
    return targetView;
}

- (UIView *)responsePoint:(CGPoint)point item:(UIBarButtonItem *)item{
    UIView *view = [item customView];
    return [self responsePoint:point view:view];
}

- (void)drawRect:(CGRect)rect {
    // Drawing
    UIColor *backImageColor = bgColor ? : [UIColor whiteColor];
    self.backgroundView.backgroundColor = backImageColor;
}

@end
