//
//  LeftTableViewCell.m
//  Demo
//
//  Created by yhj on 2017/2/28.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import "LeftTableViewCell.h"

@interface LeftTableViewCell ()

@property(nonatomic,strong)UIView *lineView;

@property(nonatomic,strong)UILabel *nameLabel;

@end

@implementation LeftTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.backgroundColor=[UIColor whiteColor];

        self.lineView.hidden=YES;

        self.nameLabel.font=[UIFont systemFontOfSize:12];

        self.selectionStyle=UITableViewCellSelectionStyleNone;

    }
    return self;
}

-(UIView *)lineView
{
    if (!_lineView) {
        _lineView=[UIView new];
        _lineView.backgroundColor=[UIColor redColor];
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kmargin);
            make.width.mas_equalTo(kmargin/2);
            make.left.mas_equalTo(kmargin/2);
            make.bottom.mas_equalTo(-kmargin);
        }];
    }
    return _lineView;
}

// nameLabel
- (UILabel *)nameLabel
{

    if (!_nameLabel) {
        _nameLabel=[self getLabelWithText:@"名字" font:[UIFont systemFontOfSize:12] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByCharWrapping numberOfLines:1];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kmargin*2);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _nameLabel;
}

-(void)setCategoryModel:(CategoryModel *)categoryModel
{
    self.nameLabel.text=categoryModel.name;
}

-(void)setFoodCategoryModel:(FoodCategoryModel *)foodCategoryModel
{
    self.nameLabel.text=foodCategoryModel.name;
}


-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    self.lineView.hidden=!self.selected;

    self.nameLabel.textColor=self.selected?[UIColor redColor]:[UIColor blackColor];
}

@end
