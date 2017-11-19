//
//  RicErrorView.h
//  Kuoke
//
//  Created by Rice on 2017/11/9.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,RicErrorViewDisplayType) {
    RicErrorViewDisplayTypeNoOperation,
    RicErrorViewDisplayTypeRetry
};

///错误页
@interface RicErrorView : UIView

@property (nonatomic, strong, readonly) UIImageView *errorIconView;
@property (nonatomic, strong, readonly) UILabel *errorDesLabel;
@property (nonatomic, strong, readonly) UIButton *errorRetryButton;

@property (nonatomic, assign) RicErrorViewDisplayType displayType;

@property (nonatomic, copy) void(^errorRetryAction)(void);

@end

@interface RicEmptyErrorView:RicErrorView

@end

@interface RicOfflineErrorView:RicErrorView

@end

@interface RicRequestErrorView:RicErrorView

@property (nonatomic, copy) NSString *errImageIcon;
//提示消息
@property (nonatomic, copy) NSString *errMsg;
@property (nonatomic, copy) NSMutableString *errAttrMsg;
//重试标题
@property (nonatomic, copy) NSString *errRetryButtonTitle;
@property (nonatomic, copy) NSMutableString *errRetryButtonAttrTitle;

@end
