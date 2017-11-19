//
//  RiceBaseTableViewCell.m
//  Kuoke
//
//  Created by Rice on 2017/11/9.
//  Copyright © 2017年 Ric. All rights reserved.
//

#import "RicBaseTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIView+Const.h"

@interface RicBaseTableViewCell()

@property (nonatomic, strong) UIView *separateLine;

@end

@implementation RicBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setSeparateLineColor:(UIColor *)separateLineColor{
    self.separateLine.backgroundColor = separateLineColor;
}

- (UIView *)separateLine{
    if(!_separateLine){
        _separateLine = [[UIView alloc] init];
        _separateLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_separateLine];
        [self setNeedsUpdateConstraints];
    }
    return _separateLine;
}

- (void)setSeparateLineHidden:(BOOL)separateLineHidden{
    self.separateLine.hidden = separateLineHidden;
}

- (void)updateConstraints{
    if(_separateLine && !_separateLine.hidden){
        [self.separateLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.separateLineInsets.left);
            make.right.equalTo(self.contentView.mas_right).offset(-self.separateLineInsets.right);
            make.top.equalTo(self.contentView.mas_bottom).offset(-1);
            make.height.mas_equalTo([UIView separateLineHeight]);
        }];
    }
    [super updateConstraints];
}

+ (CGFloat)cellHeight{
    return 0.0;
}
+ (CGFloat)cellHeightForCellModel:(NSObject *)cellModel{
    return 0.0;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
