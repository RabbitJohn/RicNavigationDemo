//
//  RicErrorView.m
//  Kuoke
//
//  Created by Rice on 2017/11/9.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "RicErrorView.h"

@interface RicErrorView()

@property (nonatomic, strong) UIImageView *errorIconView;
@property (nonatomic, strong) UILabel *errorDesLabel;
@property (nonatomic, strong) UIButton *errorRetryButton;

- (CGRect)errorIconFrame;
- (CGRect)errorDesLabelFrame;
- (CGRect)errorRetryButtonFrame;

@end

@implementation RicErrorView

- (instancetype)initWithFrame:(CGRect)frame{
    
    CGRect viewFrame = CGRectEqualToRect(frame, CGRectZero) ? CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds),CGRectGetWidth([UIScreen mainScreen].bounds)*0.75):frame;
    
    self = [super initWithFrame:viewFrame];
    if(self){
        self.errorIconView = [[UIImageView alloc] initWithFrame:[self errorIconFrame]];
        //TODO:
        self.errorIconView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.errorIconView];
        
        self.errorDesLabel = [[UILabel alloc] initWithFrame:[self errorDesLabelFrame]];
        self.errorDesLabel.numberOfLines = 0;
        //TODO:
        self.errorDesLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.errorDesLabel];

        self.errorRetryButton = [[UIButton alloc] initWithFrame:[self errorDesLabelFrame]];
        //TODO:
        self.errorRetryButton.backgroundColor = [UIColor purpleColor];
        self.errorRetryButton.backgroundColor = [UIColor grayColor];
        [self addSubview:self.errorRetryButton];
        [self.errorRetryButton addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setDisplayType:(RicErrorViewDisplayType)displayType{
    _displayType = displayType;
    //TODO:根据这个类型来判断要不要add errorRetryButton
    if(_displayType == RicErrorViewDisplayTypeNoOperation){
        
    }else if(_displayType == RicErrorViewDisplayTypeRetry){
        
    }
}
- (void)retry{
    if(self.errorRetryAction){
        self.errorRetryAction();
    }
}

- (CGRect)errorIconFrame{
    CGFloat width = 70;
    CGFloat height = 70;
    CGFloat topY = 10;
    return CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds)-width)/2.0, topY, width, height);
}

- (CGRect)errorDesLabelFrame{
    CGFloat width = 200;
    CGFloat height = 20;
    CGFloat topY = CGRectGetMaxY([self errorIconFrame]) + 10;
    return CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds)-width)/2.0, topY, width, height);
}

- (CGRect)errorRetryButtonFrame{
    CGFloat width = 80;
    CGFloat height = 40;
    CGFloat topY = CGRectGetMaxY([self errorDesLabelFrame]) + 10;
    return CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds)-width)/2.0, topY, width, height);
}

@end

@interface RicEmptyErrorView()

@end

@implementation RicEmptyErrorView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.errorIconView.image = [UIImage imageNamed:@"AppIcon"];
        self.errorDesLabel.text = @"还没有数据哦";
        [self.errorRetryButton setTitle:@"重新尝试" forState:UIControlStateNormal];
    }
    return self;
}



@end


@interface RicOfflineErrorView()

@end

@implementation RicOfflineErrorView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.errorIconView.image = [UIImage imageNamed:@"AppIcon"];
        self.errorDesLabel.text = @"您还没连上网络哦";
        [self.errorRetryButton setTitle:@"重新尝试" forState:UIControlStateNormal];
    }
    return self;
}

@end

@interface RicRequestErrorView()

@end

@implementation RicRequestErrorView

@end
