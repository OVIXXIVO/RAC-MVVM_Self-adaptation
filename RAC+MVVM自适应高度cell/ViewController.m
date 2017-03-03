//
//  ViewController.m
//  RAC+MVVM自适应高度cell
//
//  Created by 王子翰 on 2017/3/3.
//  Copyright © 2017年 王子翰. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "ViewModel.h"
#import "MJRefresh.h"
#import "Model.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

/**
 *  视图模型
 */
@property (strong, nonatomic) ViewModel *vm;

/**
 *  模型数组
 */
@property (strong, nonatomic) NSArray *viewModelArr;

/**
 *  新闻表格
 */
@property (weak, nonatomic) UITableView *tableView;

@end

@implementation ViewController


#pragma mark - 状态栏样式

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


#pragma mark - 懒加载

- (ViewModel *)vm {
    if (!_vm) {
        _vm = [[ViewModel alloc] init];
    }
    return _vm;
}


#pragma mark - 控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //刷新状态栏
    [self setNeedsStatusBarAppearanceUpdate];
    //获取数据
    [self getData];
    //页面基本样式
    [self createBaseView];
    //kvo 只要数组发生变化就刷新表格
    [[RACObserve(self, viewModelArr) skip:1] subscribeNext:^(id x) {
        [_tableView reloadData];
        OVLog(@"x === %@",x);
    }];
}


#pragma mark - 获取页面基本数据

- (void) getData {
    //类型,,top(头条，默认),shehui(社会),guonei(国内),guoji(国际),yule(娱乐),tiyu(体育)junshi(军事),keji(科技),caijing(财经),shishang(时尚)
    @weakify(self);
    [[self.vm.command execute:@"keji"] subscribeNext:^(id x) {
        if ([x isKindOfClass:[NSArray class]]) {
            @strongify(self);
            self.viewModelArr = x;
            [_tableView.mj_header endRefreshing];
        } else if ([x isKindOfClass:[NSString class]]) {
            NSLog(@"加载失败");
        }
    }];
}


#pragma mark - 页面基本样式

- (void) createBaseView {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEF_Screen_Width, DEF_Screen_Height - 64.00) style:0];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    @weakify(self);
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getData];
    }];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView.mj_header beginRefreshing];
    _tableView = tableView;
}

#pragma mark - tableView delegate

/**
 *  点选的row
 */
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView selectRowAtIndexPath:nil animated:NO scrollPosition:0];
    ViewModel *vm = self.viewModelArr[indexPath.row];
    Model *model = vm.model;
    OVLog(@"%@",model.url);
}

/**
 *  row高度
 */
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModelArr[indexPath.row] rowHeight];
}


#pragma mark - tableView dataSouce

/**
 *  行数
 */
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModelArr.count;
}

/**
 *  UITableViewCell
 */
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const reuseId = @"reuseId";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[TableViewCell alloc]initWithStyle:0 reuseIdentifier:reuseId];
    }
    cell.vm = self.viewModelArr[indexPath.row];
    return cell;
}


#pragma mark - 接收到内存警告

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
