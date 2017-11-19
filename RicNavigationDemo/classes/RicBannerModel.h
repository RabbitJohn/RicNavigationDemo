//
//  RiceBannerModel.h
//  Kuoke
//
//  Created by Rice on 2017/11/16.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "RicBannerView.h"

@interface RicBannerModel : NSObject<RicBannerItem>

/**
 url for the banner image that will be show.
 */
@property (nonatomic, copy, readonly) NSString *bannerImageUrl;

/**
 the banner link url
 */
@property (nonatomic, copy, readonly) NSString *bannerLinkUrl;

+ (instancetype)bannerWithImageUrl:(NSString *)imageUrl linkUrl:(NSString *)linkUrl;

@end
