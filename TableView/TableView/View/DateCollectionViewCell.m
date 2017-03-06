//
//  DateCollectionViewCell.m
//  TableView
//
//  Created by yhj on 2017/3/6.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import "DateCollectionViewCell.h"

@interface DateCollectionViewCell ()

@end

@implementation DateCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {

        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
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
            make.top.mas_equalTo(kmargin/2);
        }];

    }
    return _nameLabel;
}

@end
