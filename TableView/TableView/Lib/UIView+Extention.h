//
//  UIView+Extention.h
//  OAProject
//
//  Created by yhj on 2017/2/20.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extention)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


/**
 *  9.上 < Shortcut for frame.origin.y
 */
@property (nonatomic) CGFloat top;

/**
 *  10.下 < Shortcut for frame.origin.y + frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 *  11.左 < Shortcut for frame.origin.x.
 */
@property (nonatomic) CGFloat left;

/**
 *  12.右 < Shortcut for frame.origin.x + frame.size.width
 */
@property (nonatomic) CGFloat right;

- (void)addTarget:(id)target action:(SEL)action;

/**
 *  初始化相关属性，返回label对象
 *
 *  @param dic 设置先关属性的字典
 *
 *  @return 返回 UILabel对象
 */
- (UILabel *)getLabelWithText:(NSString *)text
                         font:(UIFont *)font
                    textColor:(UIColor *)color
                textAlignment:(NSTextAlignment)alignment
                lineBreakMode:(NSLineBreakMode)lineBreak
                numberOfLines:(NSInteger)number;
/**
 *  button初始化相关属性，返回button对象
 *
 *  @param type  类型
 *  @param title 标题
 *  @param image 图片
 *
 *  @return 返回button对象
 */
- (UIButton *)getButtonWithType:(UIButtonType)type
                          title:(NSString *)title
                          image:(UIImage *)image
                backgroundColor:(UIColor *)backgroundColor;

@end
