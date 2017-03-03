//
//  NSObject+Properity.m
//  字典转模型
//
//  Created by 王子翰 on 2017/2/8.
//  Copyright © 2017年 王子翰. All rights reserved.
//  解析字典 自动生成属性代码

#import "NSObject+Properity.h"

@implementation NSObject (Properity)

+ (void) createProperityWithDictonary:(nonnull NSDictionary *)dictionary
{
    NSMutableString *codeStr = [[NSMutableString alloc] init];
    
    //1.遍历字典
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop)
    {
        OVLog(@"key:%@   obj:%@",key,[obj class]);
        //属性代码
        NSString *code = nil;
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFConstantString")] || [obj isKindOfClass:NSClassFromString(@"__NSCFString")] || [obj isKindOfClass:NSClassFromString(@"NSTaggedPointerString")])
        {
            code = [NSString stringWithFormat:@"@property (copy, nonatomic) NSString *%@;",key];
        }
        else if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")])
        {
            code = [NSString stringWithFormat:@"@property (assign, nonatomic) NSNumber *%@;",key];
        }
        else if ([obj isKindOfClass:NSClassFromString(@"__NSArrayI")] || [obj isKindOfClass:NSClassFromString(@"__NSCFArray")] || [obj isKindOfClass:NSClassFromString(@"__NSArrayM")])
        {
            code = [NSString stringWithFormat:@"@property (strong, nonatomic) NSArray *%@;",key];
        }
        else if ([obj isKindOfClass:NSClassFromString(@"__NSSingleEntryDictionaryI")] || [obj isKindOfClass:NSClassFromString(@"__NSCFDictionary")] || [obj isKindOfClass:NSClassFromString(@"__NSDictionaryM")])
        {
            code = [NSString stringWithFormat:@"@property (strong, nonatomic) NSDictionary *%@;",key];
        }
        else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")])
        {
            code = [NSString stringWithFormat:@"@property (assign, nonatomic) BOOL %@;",key];
        }
        
        [codeStr appendString:[NSString stringWithFormat:@"\n%@\n",code]];
    }];
    OVLog(@"%@",codeStr);
}

@end
