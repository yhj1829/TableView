//
//  FoodCategoryModel.h
//  TableView
//
//  Created by yhj on 2017/3/3.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodCategoryModel : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *icon;

@property(nonatomic,strong)NSArray *spus;

@end

@interface FoodNameModel : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *foodID;

@property(nonatomic,copy)NSString *picture;

@property(nonatomic,assign)NSInteger month_saled;

@property(nonatomic,assign)NSInteger praise_content;

@property(nonatomic,assign)CGFloat min_price;

@property(nonatomic,copy)NSString *icon;

@end
