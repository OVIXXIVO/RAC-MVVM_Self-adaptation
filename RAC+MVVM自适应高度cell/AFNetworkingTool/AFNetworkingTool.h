//
//  AFNetworkingTool.h
//  demo
//
//  Created by 王子翰 on 2016/11/26.
//  Copyright © 2016年 王子翰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"

@interface AFNetworkingTool : NSObject

/**
 *  get请求
 *  不需要返回值：1.只需要获取网络数据就可以了 2.网络有延迟就算要返回值也是null 3.block是回调 用到的时候才执行
 */
+ (void) GET:(nullable NSString *)URLString
  parameters:(nullable id)parameters
     success:(nullable void (^)(id _Nullable responseObject))success
     failure:(nullable void (^)(NSError * _Nullable error))failure;

/**
 *  post请求
 *  不需要返回值：1.只需要获取网络数据就可以了 2.网络有延迟就算要返回值也是null 3.block是回调 用到的时候才执行
 */
+ (void) POST:(nullable NSString *)URLString
   parameters:(nullable id)parameters
      success:(nullable void (^)(id _Nullable responseObject))success
      failure:(nullable void (^)(NSError * _Nullable error))failure;

@end
