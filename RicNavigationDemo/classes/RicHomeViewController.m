//
//  RicHomeViewController.m
//  creditor
//
//  Created by Rice on 2017/11/8.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "RicHomeViewController.h"
#import "RicBaseTableViewCell.h"
#import "RicHomeViewModel.h"
#import "RicNavigationBar.h"
#import "RicHomeNoticeCell.h"
#import "RicQueryScoreCell.h"
#import "RicBannerView.h"
#import "RicWebViewController.h"
#import "UIView+Const.h"
#import <Masonry/Masonry.h>

@interface RicHomeViewController ()<UITableViewDelegate,UITableViewDataSource,RicBannerViewDelegate>

@property (nonatomic, strong) RicHomeViewModel *homeViewModel;
@property (nonatomic, strong) RicExpandButton *leftNavBtn;
@property (nonatomic, strong) RicExpandButton *rightNavBtn;
@property (nonatomic, strong) UITableView *containerTableView;
@property (nonatomic, strong) RicBannerView *bannerView;
@property (nonatomic, strong) UIView *filterView;
@property (nonatomic, assign) CGFloat sectionHeaderY;

@end

@implementation RicHomeViewController

- (RicHomeViewModel *)homeViewModel{
    if(!_homeViewModel){
        _homeViewModel = [[RicHomeViewModel alloc] init];
    }
    return _homeViewModel;
}

- (UITableView *)containerTableView{
    if(!_containerTableView){
        _containerTableView = [[UITableView alloc] initWithFrame:self.contentView.bounds];
        _containerTableView.delegate = self;
        _containerTableView.dataSource = self;
        _containerTableView.backgroundColor = [UIColor whiteColor];
        [_containerTableView registerClass:[RicBaseTableViewCell class] forCellReuseIdentifier:@"RicBaseTableViewCell"];
        [_containerTableView registerClass:[RicHomeNoticeCell class] forCellReuseIdentifier:@"RicHomeNoticeCell"];
        [_containerTableView registerClass:[RicQueryScoreCell class] forCellReuseIdentifier:@"RicQueryScoreCell"];
    }
    return _containerTableView;
}

- (RicBannerView *)bannerView{
    if(!_bannerView){
        _bannerView = [[RicBannerView alloc] initWithFrame:CGRectMake(0, 0, [UIView screenWidth], [self RicHomeBannerHeight])];
        _bannerView.backgroundColor = [UIColor purpleColor];
        _bannerView.bannerPlaceholderImage = [UIImage imageNamed:@"welcome1"];
        _bannerView.bannerDisplayDuration = 3;
        _bannerView.delegate = self;
        _bannerView.shouldIndicator = YES;
    }
    return _bannerView;
}

- (CGFloat)RicHomeBannerHeight{
    return  180.0*[UIView screenHeight]/667.0;
}

- (void)didClickBanner:(id<RicBannerItem>)bannerItem atIndex:(NSUInteger)idx bannerView:(RicBannerView *)bannerView{
    if(bannerItem.bannerLinkUrl){
        RicWebViewController *webVC = [[RicWebViewController alloc] init];
        webVC.request = [NSURLRequest requestWithURL:[NSURL URLWithString:bannerItem.bannerLinkUrl]];
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 2;
    }else{
        return 10;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RicBaseTableViewCell *cell = nil;
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                cell = [self.containerTableView dequeueReusableCellWithIdentifier:@"RicBaseTableViewCell"];
                break;
            case 1:
                cell = [self.containerTableView dequeueReusableCellWithIdentifier:@"RicHomeNoticeCell"];
                break;
            case 2:
                cell = [self.containerTableView dequeueReusableCellWithIdentifier:@"RicQueryScoreCell"];
                break;
            default:
                break;
        }
    }else{
        cell = [[RicBaseTableViewCell alloc] init];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            return [self RicHomeBannerHeight]-[UIView topHeight];
        }else if(indexPath.row == 1){
            return [RicHomeNoticeCell cellHeight];
        }else{
            return [RicQueryScoreCell cellHeight];
        }
    }else{
        return 86;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0.01;
    }else{
        return 34;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }else{
        //TODO:返回一个筛选的view
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor purpleColor];
        self.filterView = view;
        return view;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.sectionHeaderY == 0){
        self.sectionHeaderY = [self.contentView convertPoint:self.filterView.frame.origin toView:self.contentView].y;
    }
    CGFloat offset = MAX(scrollView.contentOffset.y, 0);
    CGFloat alpha = offset/(self.sectionHeaderY - [UIView topHeight]);
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithWhite:1 alpha:alpha];
    BOOL isTranslucent = alpha < 0.5;
    [self configNavBtn:self.leftNavBtn forTranslucent:isTranslucent];
    [self configNavBtn:self.rightNavBtn forTranslucent:isTranslucent];
    CGFloat y = -self.containerTableView.contentOffset.y - [UIView topHeight];
    self.bannerView.frame = CGRectMake(0,y, [UIView screenWidth], CGRectGetHeight(self.bannerView.frame));
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    @weakify(self)
    [[self.homeViewModel refreshContent] subscribeNext:^(id x) {
        @strongify(self)
        [self.bannerView quitPlay];
        self.bannerView.bannerItems = self.homeViewModel.banners;
        [self.bannerView startPlay];
        [self.containerTableView reloadData];
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout  = UIRectEdgeTop;
    self.shouldSynchnizedNavBarColorToMarkupView = YES;
    self.leftNavBtn = [self setLeftNavigationItemWithTitle:@"上海" target:self operation:@selector(chooseCityAction)];
    self.rightNavBtn = [self setRightNavigationItemWithTitle:@"分享" target:self operation:@selector(shareAction)];
    [self configNavBtn:self.leftNavBtn forTranslucent:YES];
    [self configNavBtn:self.rightNavBtn forTranslucent:YES];
    [self.contentView addSubview:self.containerTableView];
    [self.containerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.bottom.right.equalTo(@0);
    }];
    [self.contentView addSubview:self.bannerView];
//    self.containerTableView.contentOffset = CGPointMake(0, [UIView topHeight]);
    //    self.errorViewType = RicErrorViewTypeEmpty;
    
    // Do any additional setup after loading the view.
}

- (void)configNavBtn:(RicExpandButton *)navBtn forTranslucent:(BOOL)isTranslucent{
    if(!navBtn){
        return;
    }
    UIColor *normalColor = isTranslucent ? [UIColor greenColor]:[UIColor blueColor];
    UIColor *highlghtColor = isTranslucent ? [UIColor redColor]:[UIColor purpleColor];
    [navBtn setTitleColor:normalColor forState:UIControlStateNormal];
    [navBtn setTitleColor:highlghtColor forState:UIControlStateHighlighted];
}
- (void)chooseCityAction{
    NSLog(@"choose city action!");
}
- (void)shareAction{
    NSLog(@"share action!");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

