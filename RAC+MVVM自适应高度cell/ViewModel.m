//
//  ViewModel.m
//  RAC+MVVM自适应高度cell
//
//  Created by 王子翰 on 2017/3/3.
//  Copyright © 2017年 王子翰. All rights reserved.
//

#import "ViewModel.h"
#import "DataTool.h"
#import "NSObject+Model.h"
#import "NSObject+Properity.h"
#import "Model.h"
#import "FontModel.h"

@implementation ViewModel

//初始化
- (instancetype)init {
    if (self = [super init]) {
        _command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {//input:传入的参数
            return [RACReturnSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //网络请求
                [DataTool loadNewsWithTopic:input success:^(id  _Nullable result) {
                    //字典转模型
                    if ([result isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *resultDic = result[@"result"];
                        NSArray *dataArr = resultDic[@"data"];
                        //映射:字典数组转模型数组
                        NSArray *modelArr = [[dataArr.rac_sequence map:^id(id value) {
                            //要传递出去的不是model的数组 而是vm的数组
                            Model *model = [Model modelWithDic:value];
                            ViewModel *vm = [[ViewModel alloc] init];
                            vm.model = model;
                            return vm;//传递出去的是视图模型数组
                        }] array];
                        result = modelArr;
                    } else {
                        result = @"获取失败";
                    }
                    //传递值
                    [subscriber sendNext:result];
                    [subscriber sendCompleted];//RACCommand必须调用sendCompleted方法
                } failure:^(NSError * _Nullable error) {
                    //传递值
                    [subscriber sendNext:@"获取失败"];
                    [subscriber sendCompleted];//RACCommand必须调用sendCompleted方法
                }];
                return nil;
            }];
        }];
    }
    return self;
}

- (void)setModel:(Model *)model {
    _model = model;
    //设置frame 与高度
    CGFloat const marginX = 10.00f;
    CGFloat const marginY = 5.00f;
    
    CGFloat titleLabelWidth = DEF_Screen_Width - marginX * 2;
    
    CGSize titleSize = [model.title boundingRectWithSize:CGSizeMake(titleLabelWidth, DEF_Screen_Height / 2) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:titleFont + 1]} context:nil].size;
    //titleLabelFrame
    _titleLabelFrame = CGRectMake(marginX, marginY, titleLabelWidth, titleSize.height);
    //imageView0Frame
    CGFloat imgWidth = (DEF_Screen_Width - marginX * 4) / 3;
    CGFloat imgHeight = imgWidth;
    _imageView0Frame = CGRectMake(marginX, CGRectGetMaxY(_titleLabelFrame) + marginY, imgWidth, imgHeight);
    //imageView1Frame
    _imageView1Frame = CGRectMake(CGRectGetMaxX(_imageView0Frame) + marginX, CGRectGetMaxY(_titleLabelFrame) + marginY, imgWidth, imgHeight);
    //imageView2Frame
    _imageView2Frame = CGRectMake(CGRectGetMaxX(_imageView1Frame) + marginX, CGRectGetMaxY(_titleLabelFrame) + marginY, imgWidth, imgHeight);
    //timeLabelFrame
    _timeLabelFrame = CGRectMake(marginX, CGRectGetMaxY(_imageView2Frame) + marginY, DEF_Screen_Width / 2, 20.00);
    //authorLabelFrame
    _authorLabelFrame = CGRectMake(DEF_Screen_Width / 2, CGRectGetMaxY(_imageView2Frame) + marginY, DEF_Screen_Width / 2 - marginX, 20.00);
    
    //rowHeight
    _rowHeight = CGRectGetMaxY(_authorLabelFrame) + marginY;
}

@end
