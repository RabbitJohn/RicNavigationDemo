//
//  RicHomeViewModel.h
//  Kuoke
//
//  Created by Rice on 2017/11/9.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "RicBannerView.h"
#import "RicBannerModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RicHomeViewModel : NSObject

@property (nonatomic, strong, readonly) NSArray <RicBannerModel *>*banners;

- (RACSignal *)refreshContent;

@end
