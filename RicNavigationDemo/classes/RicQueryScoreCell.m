//
//  RicQueryScoreCell.m
//  Kuoke
//
//  Created by Rice on 2017/11/16.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "RicQueryScoreCell.h"

@interface RicQueryScoreCell ()

@end

@implementation RicQueryScoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

+ (CGFloat)cellHeight{
    return 94;
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
