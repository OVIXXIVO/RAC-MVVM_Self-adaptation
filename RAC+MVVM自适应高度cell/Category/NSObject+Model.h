//
//  NSObject+Model.h
//  runtime字典转模型
//
//  Created by 王子翰 on 2017/2/9.
//  Copyright © 2017年 王子翰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model)

+ (nonnull __kindof NSObject *) modelWithDic:(nonnull NSDictionary *)dic;

@end
