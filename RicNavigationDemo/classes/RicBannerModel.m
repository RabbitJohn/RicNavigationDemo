//
//  RiceBannerModel.m
//  Kuoke
//
//  Created by Rice on 2017/11/16.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "RicBannerModel.h"

@interface RicBannerModel()

@property (nonatomic, copy) NSString *bannerImageUrl;
@property (nonatomic, copy) NSString *bannerLinkUrl;


@end
@implementation RicBannerModel

+ (instancetype)bannerWithImageUrl:(NSString *)imageUrl linkUrl:(NSString *)linkUrl{
    
    RicBannerModel *banner = [[RicBannerModel alloc] init];
    banner.bannerImageUrl = imageUrl;
    banner.bannerLinkUrl = linkUrl;
    
    return banner;
}



@end
