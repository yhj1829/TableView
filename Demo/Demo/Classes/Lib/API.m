//
//  API.m
//  Demo
//
//  Created by yhj on 2017/2/28.
//  Copyright © 2017年 cdnunion. All rights reserved.
//

#import "API.h"

//获取订阅左侧标签
#define SubscribeLeft @"http://api.budejie.com/api/api_open.php?a=category&c=subscribe"

//获取“推荐关注”中左侧标签每个标签对应的推荐用户组
#define RecommentUser @"http://api.budejie.com/api/api_open.php?a=list&c=subscribe"

@implementation API

+(void)RequestByURL:(NSString *)url paramenter:(NSDictionary *)paramenter success:(void(^)(id response))success failure:(void(^)(id error))failure
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFXMLParserResponseSerializer new]];
    manager.requestSerializer.timeoutInterval=10.0f;
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    [manager GET:url parameters:paramenter progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        failure(error);

    }];
}

// 获取左边数据
+(void)GetLeftDataWithSuccess:(void(^)(id response))success failure:(void(^)(id error))failure
{
      [self RequestByURL:SubscribeLeft paramenter:nil success:^(id response)
     {
          success(response);

      } failure:^(id error) {

          failure(error);

      }];
}


+(void)GetRightDataByUserID:(NSString *)userID success:(void(^)(id response))success failure:(void(^)(id error))failure
{
    NSString *urlStr=[NSString stringWithFormat:@"%@&category_id=%@",RecommentUser,userID];
  [self RequestByURL:urlStr paramenter:nil success:^(id response) {

      success(response);

  } failure:^(id error) {

      failure(error);

  }];

}

+(void)GetMoreDataByUserID:(NSString *)userID page:(NSString *)page success:(void (^)(id))success failure:(void (^)(id))failure
{
    NSString *urlStr=[NSString stringWithFormat:@"%@&category_id=%@&page=%@",RecommentUser,userID,page];

    [self RequestByURL:urlStr paramenter:nil success:^(id response) {

        success(response);

    } failure:^(id error) {

          failure(error);

    }];

}

@end
