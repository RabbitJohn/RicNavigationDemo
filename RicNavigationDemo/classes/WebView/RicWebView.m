//
//  RicWebView.m
//  Kuoke
//
//  Created by Rice on 2017/11/16.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "RicWebView.h"

@implementation RicWebView

+ (RicWebView *)sharedWebView{
    RicWebView *__block sharedWebView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!sharedWebView){
            sharedWebView = [[RicWebView alloc] initWithFrame:CGRectZero];
        }
    });
    return sharedWebView;
}

@end
