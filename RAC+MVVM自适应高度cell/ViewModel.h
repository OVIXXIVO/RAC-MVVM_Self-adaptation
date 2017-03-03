//
//  ViewModel.h
//  RAC+MVVM自适应高度cell
//
//  Created by 王子翰 on 2017/3/3.
//  Copyright © 2017年 王子翰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACCommand;
@class Model;

@interface ViewModel : NSObject

@property (strong, nonatomic) RACCommand *command;

@property (strong, nonatomic) Model *model;

/**
 *  标题
 */
@property (assign, nonatomic) CGRect titleLabelFrame;
/**
 *  图
 */
@property (assign, nonatomic) CGRect imageView0Frame;

@property (assign, nonatomic) CGRect imageView1Frame;

@property (assign, nonatomic) CGRect imageView2Frame;
/**
 *  时间
 */
@property (assign, nonatomic) CGRect timeLabelFrame;
/**
 *  来源
 */
@property (assign, nonatomic) CGRect authorLabelFrame;

@property (assign, nonatomic) CGFloat rowHeight;

@end
