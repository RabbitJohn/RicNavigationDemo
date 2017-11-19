//
//  RicWebViewController.h
//  Kuoke
//
//  Created by Rice on 2017/11/16.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "RicBaseViewController.h"

@interface RicWebViewController : RicBaseViewController

@property (nonatomic, strong) NSURL *requestUrl;
@property (nonatomic, strong) NSURLRequest *request;

@end
