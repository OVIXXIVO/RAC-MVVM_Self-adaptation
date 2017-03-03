//
//  DataTool.m
//  RAC+MVVM自适应高度cell
//
//  Created by 王子翰 on 2017/3/3.
//  Copyright © 2017年 王子翰. All rights reserved.
//

#import "DataTool.h"
#import "Key.h"

@implementation DataTool

+ (void) loadNewsWithTopic:(nullable NSString *)topic success:(nullable void (^)(id _Nullable result))success failure:(nullable void (^)(NSError * _Nullable error))failure {
    
    NSString * const URLString = @"http://v.juhe.cn/toutiao/index";
    NSDictionary *params = @{@"type":topic,@"key":nKey};
    
    [AFNetworkingTool POST:URLString parameters:params success:^(id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError * _Nullable error) {
        if (error) {
            failure(error);
        }
    }];
}

@end
