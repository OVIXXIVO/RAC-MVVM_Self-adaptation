//
//  DataTool.h
//  RAC+MVVM自适应高度cell
//
//  Created by 王子翰 on 2017/3/3.
//  Copyright © 2017年 王子翰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTool : NSObject

+ (void) loadNewsWithTopic:(nullable NSString *)topic success:(nullable void (^)(id _Nullable result))success failure:(nullable void (^)(NSError * _Nullable error))failure;

@end
