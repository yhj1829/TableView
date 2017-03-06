//
//  TableViewHeaderView.m
//  TableView
//
//  Created by yhj on 2017/3/3.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import "TableViewHeaderView.h"

@implementation TableViewHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {

        self.nameLabel.font=[UIFont systemFontOfSize:12];

        self.backgroundColor=[UIColor lightGrayColor];
    }
    return self;
}

// nameLabel
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel=[self getLabelWithText:@"名字" font:[UIFont systemFontOfSize:12] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByCharWrapping numberOfLines:1];
        [self  addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
    }
    return _nameLabel;
}


@end
