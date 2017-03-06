//
//  RightTableViewCell.m
//  Demo
//
//  Created by yhj on 2017/2/28.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import "RightTableViewCell.h"


@interface RightTableViewCell ()

@property(nonatomic,strong)UIImageView *headUrl;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)UILabel *numberLabel;

@end

@implementation RightTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType=UITableViewCellAccessoryNone;
        self.backgroundColor=[UIColor whiteColor];

        self.nameLabel.font=[UIFont systemFontOfSize:14];

        self.priceLabel.font=[UIFont systemFontOfSize:12];

        self.numberLabel.font=[UIFont systemFontOfSize:12];
    }
    return self;
}

// headUrl
-(UIImageView *)headUrl
{
    if (!_headUrl) {
        _headUrl=[[UIImageView alloc]init];
        [self addSubview:_headUrl];

        // 圆角和边框
        ViewBorderRadius(_headUrl,kmargin*3,kmargin/kmargin,ClearColor);

        [_headUrl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kmargin);
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kmargin*6,kmargin*6));
        }];
    }
    return _headUrl;
}


// nameLabel
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel=[self getLabelWithText:@"名字" font:[UIFont systemFontOfSize:12] textColor: [UIColor blackColor] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByCharWrapping numberOfLines:1];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headUrl.mas_right).offset(kmargin);
            make.top.mas_equalTo(kmargin);
        }];

    }
    return _nameLabel;
}

// priceLabel
- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel=[self getLabelWithText:@"详情" font:[UIFont systemFontOfSize:10] textColor: [UIColor lightGrayColor] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByCharWrapping numberOfLines:1];
        [self.contentView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headUrl.mas_right).offset(kmargin);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kmargin);
            make.right.mas_equalTo(-kmargin);
        }];
    }
    return _priceLabel;
}

// numberLabel
- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel=[self getLabelWithText:@"详情" font:[UIFont systemFontOfSize:10] textColor: [UIColor lightGrayColor] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByCharWrapping numberOfLines:1];
        [self.contentView addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headUrl.mas_right).offset(kmargin);
            make.top.mas_equalTo(self.priceLabel.mas_bottom).offset(kmargin);
            make.right.mas_equalTo(-kmargin);
        }];
    }
    return _numberLabel;
}



-(void)setFoodNameModel:(FoodNameModel *)foodNameModel
{

    [self.headUrl sd_setImageWithURL:[NSURL URLWithString:foodNameModel.picture] placeholderImage:[UIImage imageNamed:@""]];

    self.nameLabel.text=foodNameModel.name;

    self.priceLabel.text=[NSString stringWithFormat:@"最低价:%.1f",foodNameModel.min_price];

    self.numberLabel.text=[NSString stringWithFormat:@"月销量:%ld",(long)foodNameModel.month_saled];

}

@end
