//
//  CollectionViewCell.m
//  TableView
//
//  Created by yhj on 2017/3/3.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@property(nonatomic,strong)UIImageView *headUrl;

@property(nonatomic,strong)UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *name;

@end

@implementation CollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {

        self.backgroundColor=[UIColor redColor];
    }
    return self;
}


-(void)setSubcategoriesModel:(SubcategoriesModel *)subcategoriesModel
{
     [self.headUrl sd_setImageWithURL:[NSURL URLWithString:subcategoriesModel.icon_url] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text=subcategoriesModel.name;
}

// headUrl
-(UIImageView *)headUrl
{
    if (!_headUrl) {
        _headUrl=[[UIImageView alloc]init];
        _headUrl.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:_headUrl];

        // 圆角和边框
        ViewBorderRadius(_headUrl,(self.frame.size.width-kmargin)/2,kmargin/kmargin,ClearColor);

        [_headUrl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kmargin/2);
            make.left.mas_equalTo(kmargin/2);
            make.right.mas_equalTo(-kmargin/2);
            make.size.mas_equalTo(CGSizeMake(self.frame.size.width-kmargin,self.frame.size.width-kmargin));
        }];
    }
    return _headUrl;
}

// nameLabel
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel=[self getLabelWithText:@"名字" font:[UIFont systemFontOfSize:12] textColor: [UIColor blackColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByTruncatingTail numberOfLines:1];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(self.frame.size.width-kmargin);
            make.top.mas_equalTo(self.headUrl.mas_bottom).offset(kmargin/2);
        }];

    }
    return _nameLabel;
}


@end
