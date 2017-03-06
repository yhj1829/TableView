//
//  CategoryModel.h
//  TableView
//
//  Created by yhj on 2017/3/3.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,strong)NSArray *subcategories;

@end


@interface SubcategoriesModel : NSObject

@property(nonatomic,copy)NSString *icon_url;

@property(nonatomic,copy)NSString *name;

@end
