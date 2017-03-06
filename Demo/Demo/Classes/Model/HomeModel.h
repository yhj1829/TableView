//
//  HomeModel.h
//  Demo
//
//  Created by yhj on 2017/3/1.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

@property(nonatomic,strong)NSMutableArray *listArr;

// 下一页
@property(nonatomic,copy)NSString *next_page;

// 总页数
@property(nonatomic,copy)NSString *total_page;

@end
