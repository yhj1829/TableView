//
//  CategoryModel.m
//  TableView
//
//  Created by yhj on 2017/3/3.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"subcategories":@"SubcategoriesModel"
             };
}

@end

@implementation SubcategoriesModel

@end
