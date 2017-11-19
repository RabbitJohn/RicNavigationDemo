//
//  RicHomeViewModel.m
//  Kuoke
//
//  Created by Rice on 2017/11/9.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "RicHomeViewModel.h"

@interface RicHomeViewModel()

@property (nonatomic, strong) NSArray <RicBannerModel *>*banners;

- (RACSignal *)updateBanners:(NSArray <RicBannerModel *>*)banners;

@end

@implementation RicHomeViewModel

- (RACSignal *)updateBanners:(NSArray <RicBannerModel *>*)banners
{
    RicBannerModel *banner1 = [RicBannerModel bannerWithImageUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510847581023&di=c95f93ffd493da63e5c21e9d27325b58&imgtype=jpg&src=http%3A%2F%2Fimg2.imgtn.bdimg.com%2Fit%2Fu%3D298624772%2C1758813169%26fm%3D214%26gp%3D0.jpg" linkUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510847581023&di=c95f93ffd493da63e5c21e9d27325b58&imgtype=jpg&src=http%3A%2F%2Fimg2.imgtn.bdimg.com%2Fit%2Fu%3D298624772%2C1758813169%26fm%3D214%26gp%3D0.jpg"];
    RicBannerModel *banner2 = [RicBannerModel bannerWithImageUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510847113821&di=34336fe5847d56933f377c3faa02ca50&imgtype=0&src=http%3A%2F%2Fwww.haha365.com%2Fuploadfile%2F2014%2F0404%2F20140404063425613.jpg" linkUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510847113821&di=34336fe5847d56933f377c3faa02ca50&imgtype=0&src=http%3A%2F%2Fwww.haha365.com%2Fuploadfile%2F2014%2F0404%2F20140404063425613.jpg"];
    RicBannerModel *banner3 = [RicBannerModel bannerWithImageUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510847614949&di=5fe5ff939ecf69df4defc3574ef8df96&imgtype=jpg&src=http%3A%2F%2Fimg2.imgtn.bdimg.com%2Fit%2Fu%3D3265914592%2C2546763950%26fm%3D214%26gp%3D0.jpg" linkUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510847614949&di=5fe5ff939ecf69df4defc3574ef8df96&imgtype=jpg&src=http%3A%2F%2Fimg2.imgtn.bdimg.com%2Fit%2Fu%3D3265914592%2C2546763950%26fm%3D214%26gp%3D0.jpg"];

    banners = @[banner1,banner2,banner3];
    self.banners = banners;
    return [RACSignal return:self];
}

- (RACSignal *)refreshContent{
    return [[self updateBanners:nil] throttle:5];
}




@end
