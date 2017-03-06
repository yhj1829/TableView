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

@property(nonatomic,strong)UILabel *detailLabel;

@end

@implementation RightTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType=UITableViewCellAccessoryNone;
        self.backgroundColor=[UIColor whiteColor];

        self.nameLabel.font=[UIFont systemFontOfSize:14];

        self.detailLabel.font=[UIFont systemFontOfSize:12];
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
        _nameLabel=[self getLabelWithText:@"名字" font:[UIFont systemFontOfSize:14] textColor: [UIColor blackColor] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByCharWrapping numberOfLines:1];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headUrl.mas_right).offset(kmargin);
            make.top.mas_equalTo(kmargin);
        }];

    }
    return _nameLabel;
}

// detailLabel
- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel=[self getLabelWithText:@"详情" font:[UIFont systemFontOfSize:12] textColor: [UIColor lightGrayColor] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByCharWrapping numberOfLines:0];
        [self.contentView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headUrl.mas_right).offset(kmargin);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kmargin);
            make.right.mas_equalTo(-kmargin);
            make.bottom.mas_equalTo(-kmargin/2);
        }];
    }
    return _detailLabel;
}


-(void)setListModel:(ListModel *)listModel
{

    [self.headUrl sd_setImageWithURL:[NSURL URLWithString:listModel.header] placeholderImage:[UIImage imageNamed:@""]];

     self.nameLabel.text=listModel.screen_name;

    self.detailLabel.text=listModel.introduction;

}

@end
