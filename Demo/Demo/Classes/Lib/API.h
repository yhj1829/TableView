//
//  API.h
//  Demo
//
//  Created by yhj on 2017/2/28.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API : NSObject

// 获取左边数据
+(void)GetLeftDataWithSuccess:(void(^)(id response))success failure:(void(^)(id error))failure;

// 获取右边数据
+(void)GetRightDataByUserID:(NSString *)userID success:(void(^)(id response))success failure:(void(^)(id error))failure;

// 获取更多数据
+(void)GetMoreDataByUserID:(NSString *)userID  page:(NSString *)page success:(void(^)(id response))success failure:(void(^)(id error))failure;

@end
