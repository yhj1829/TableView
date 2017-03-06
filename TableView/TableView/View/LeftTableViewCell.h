//
//  LeftTableViewCell.h
//  Demo
//
//  Created by yhj on 2017/2/28.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"
#import "FoodCategoryModel.h"

@interface LeftTableViewCell : UITableViewCell

@property(nonatomic,strong)CategoryModel *categoryModel;

@property(nonatomic,strong)FoodCategoryModel *foodCategoryModel;

@end
