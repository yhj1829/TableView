//
//  Util.h
//  Demo
//
//  Created by yhj on 2017/3/1.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

// 获取高度
+(CGFloat)LabelHeightByText:(NSString *)text;

+(CGFloat)LabelHeightByText:(NSString *)text width:(CGFloat)width heightLimit:(CGFloat)heightLimit font:(CGFloat)font;

@end
