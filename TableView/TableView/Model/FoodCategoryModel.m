//
//  FoodCategoryModel.m
//  TableView
//
//  Created by yhj on 2017/3/3.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import "FoodCategoryModel.h"

@implementation FoodCategoryModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"spus":@"FoodNameModel"
             };
}

@end

@implementation FoodNameModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
              @"foodID":@"id"
             };
}

@end
