//
//  AFNetworkingTool.m
//  demo
//
//  Created by 王子翰 on 2016/11/26.
//  Copyright © 2016年 王子翰. All rights reserved.
//

#import "AFNetworkingTool.h"
#import "AFNetworking.h"

@implementation AFNetworkingTool


#pragma mark - get请求

+ (void) GET:(nullable NSString *)URLString
  parameters:(nullable id)parameters
     success:(nullable void (^)(id _Nullable responseObject))success
     failure:(nullable void (^)(NSError * _Nullable error))failure {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];//设置相应内容类型
    //转译
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//转译
    //请求
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error = nil;
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        //原理:先把请求成功保存到代码块
        if (success) {
            if (!error) {
                success(obj);
            } else {
                success(error);
            }
        }
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (failure) {
                 failure(error);
             }
         }];
}


#pragma mark -  post请求

+ (void) POST:(nullable NSString *)URLString
   parameters:(nullable id)parameters
      success:(nullable void (^)(id _Nullable responseObject))success
      failure:(nullable void (^)(NSError * _Nullable error))failure {
    //创建请求管理者
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];//设置相应内容类型
    //转译
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//转译
    //请求
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //回调success方法
        NSError *error = nil;
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        //原理:先把请求成功保存到代码块
        if (success) {
            if (!error) {
                success(obj);
            } else {
                success(error);
            }
        }
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              //回调failure方法
              if (failure) {
                  failure(error);
              }
          }];
}


@end
