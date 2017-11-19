//
//  RiceBaseTableViewCell.h
//  Kuoke
//
//  Created by Rice on 2017/11/9.
//  Copyright © 2017年 Ric. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct RicSeparateLineInsets {
    CGFloat left, right;  //分割线的左右边距
} RicSeparateLineInsets;

@interface RicBaseTableViewCell : UITableViewCell

/**
 用来分割线的inset
 */
@property (nonatomic, assign) RicSeparateLineInsets separateLineInsets;

/**
 分割线的颜色
 */
@property (nonatomic, strong) UIColor *separateLineColor;

/**
 是否隐藏分割线
 */
@property (nonatomic, assign) BOOL separateLineHidden;

+ (CGFloat)cellHeight;
+ (CGFloat)cellHeightForCellModel:(NSObject *)cellModel;

@end
