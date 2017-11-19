//
//  UIView+Const.m
//  creditor
//
//  Created by Rice on 2017/9/19.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "UIView+Const.h"
#import <sys/utsname.h>

@implementation UIView (Const)

+ (BOOL)isPhoneX{
    return CGRectGetHeight([UIScreen mainScreen].bounds) == 812;
}

+ (CGFloat)statusBarHeight{
    if([self isPhoneX]){
        return 44;
    }else{
        return 20;
    }
}

+ (CGFloat)navigationBarHeight{
    return 44;
}

+ (CGFloat)topHeight{
    return [UIView isPhoneX] ? 88 :64;
}

+ (CGFloat)tabbarHeight{
    if([self isPhoneX]){
        return 83;
    }else{
        return 49;
    }
}

+ (CGFloat)safeBottomAreaHeight{
    return [UIView isPhoneX] ? 34 :0;
}

+ (CGFloat)safeTopAreaHeight{
    return [UIView isPhoneX] ? 24 :0;
}

+ (CGFloat)separateLineHeight{
    return 1.0/[UIScreen mainScreen].scale;
}

+ (CGFloat)screenWidth{
    return CGRectGetWidth([UIScreen mainScreen].bounds);
}

+ (CGFloat)screenHeight{
    return CGRectGetHeight([UIScreen mainScreen].bounds);
}

@end
