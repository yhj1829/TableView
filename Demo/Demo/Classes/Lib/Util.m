//
//  Util.m
//  Demo
//
//  Created by yhj on 2017/3/1.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import "Util.h"

@implementation Util

+(CGFloat)LabelHeightByText:(NSString *)text
{
    CGRect rect=[text boundingRectWithSize:CGSizeMake(APPW/4,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    CGFloat textHeight=rect.size.height;
    if (textHeight>=44)
    {
        textHeight=textHeight;
    }
    else
    {
        textHeight = 44;
    }
    return textHeight;
}


+(CGFloat)LabelHeightByText:(NSString *)text width:(CGFloat)width heightLimit:(CGFloat)heightLimit font:(CGFloat)font
{
    CGSize size = [text boundingRectWithSize:CGSizeMake(width,heightLimit) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    CGFloat textHeight=size.height;
    if (textHeight>=44)
    {
        textHeight=textHeight;
    }
    else
    {
        textHeight = 44;
    }
    return textHeight;
}

@end
