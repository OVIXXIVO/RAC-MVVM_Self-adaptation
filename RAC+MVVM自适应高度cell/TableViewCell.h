//
//  TableViewCell.h
//  RAC+MVVM自适应高度cell
//
//  Created by 王子翰 on 2017/3/3.
//  Copyright © 2017年 王子翰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewModel;

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) ViewModel *vm;

@end
