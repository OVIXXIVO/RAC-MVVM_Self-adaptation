//
//  NSObject+Model.m
//  runtime字典转模型
//
//  Created by 王子翰 on 2017/2/9.
//  Copyright © 2017年 王子翰. All rights reserved.
//  使用runtime字典转模型 (与kvc相反 是遍历属性去字典中找对应的key给value赋值)

#import "NSObject+Model.h"
#import <objc/message.h>

@implementation NSObject (Model)

+ (nonnull __kindof NSObject *) modelWithDic:(nonnull NSDictionary *)dic
{
    id obj = [[self alloc] init];
    
    //1.遍历所有的成员变量(_变量名)
    /**
     *  第一个参数class 第二个参数是数量的地址
     *  返回值类型Ivar *是数组
     */
    //1.1 获取成员变量数组
    unsigned int count = 0;
    Ivar *ivarArr =  class_copyIvarList([self class], &count);
    //1.2 遍历成员变量数组
    for (int i = 0;i < count; i ++)
    {
        //1.3 获取每一个成员变量
        Ivar ivar = ivarArr[i];
        //1.4 获取成员变量的变量名 返回值类型const char *
        const char *ivarName = ivar_getName(ivar);
        //1.5 const char *转换为NSString *
        NSString *ivarNameStr = [NSString stringWithUTF8String:ivarName];
        //1.6 成员变量是带"_"(下划线的)所以要去掉下划线 此时获取到了成员变量对应的属性名
        NSString *key = [ivarNameStr substringFromIndex:1];
        //1.7 根据属性名 从字典中取值
        id value = dic[key];
        //1.8 二级转换 需要知道转换成的类型
        //1.8.1 获取属性类型
        const char *ivarClassName = ivar_getTypeEncoding(ivar);
        //1.8.2  const char *转换为NSString *
        NSString *ivarClassNameStr = [NSString stringWithUTF8String:ivarClassName];
        //1.8.3 由于有些字典可能并不需要转模型 所以要判断 该字典是否需要转换成模型 (只需要判断是否有NS就可以了 前提:自定义的模型不能以NS开头)
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarClassNameStr containsString:@"NS"])
        {
            //1.8.4 虽然已经拿到ivarClassNameStr 但是它和想要的不一样 想要的字符串是它的一部分 所以需要截取 (转义字符\"放在一起算一个字符)
            NSRange range = [ivarClassNameStr rangeOfString:@"\""];
            ivarClassNameStr = [ivarClassNameStr substringFromIndex:range.location + range.length];
            range = [ivarClassNameStr rangeOfString:@"\""];
            ivarClassNameStr = [ivarClassNameStr substringToIndex:range.location];
            //1.8.5 获取需要转换的类的类对象(类)
            Class modelClass = NSClassFromString(ivarClassNameStr);
            //1.8.6字典转模型 (要先判断value是否为空)
            if (value)
            {
                value = [modelClass modelWithDic:value];
            }
        }
        //1.9 kvc (要先判断value是否为空 因为kvc不允许赋空值)
        if (value)
        {
            [obj setValue:value forKey:key];
        }
    }
    return obj;
}

//只要实现这个方法 kvc时候 就算属性不全也不会崩溃(kvc不会崩溃)
- (void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"key === %@    value === %@",key,value);
}

@end
