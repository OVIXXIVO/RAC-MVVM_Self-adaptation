//
//  TableViewCell.m
//  RAC+MVVM自适应高度cell
//
//  Created by 王子翰 on 2017/3/3.
//  Copyright © 2017年 王子翰. All rights reserved.
//

#import "TableViewCell.h"
#import "Model.h"
#import "ViewModel.h"
#import "UIImageView+webCache.h"
#import "FontModel.h"

@interface TableViewCell ()

/**
 *  标题
 */
@property (weak, nonatomic) UILabel *titleLabel;
/**
 *  图
 */
@property (weak, nonatomic) UIImageView *imageView0;

@property (weak, nonatomic) UIImageView *imageView1;

@property (weak, nonatomic) UIImageView *imageView2;
/**
 *  时间
 */
@property (weak, nonatomic) UILabel *timeLabel;
/**
 *  来源
 */
@property (weak, nonatomic) UILabel *authorLabel;

@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont systemFontOfSize:titleFont];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
        //三张图 最好不用循环
        UIImageView *imageView0 = [[UIImageView alloc] init];
        imageView0.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView0];
        _imageView0 = imageView0;
        UIImageView *imageView1 = [[UIImageView alloc] init];
        imageView1.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView1];
        _imageView1 = imageView1;
        UIImageView *imageView2 = [[UIImageView alloc] init];
        imageView2.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView2];
        _imageView2 = imageView2;
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:timeFont];
        [self addSubview:timeLabel];
        _timeLabel = timeLabel;
        //来源
        UILabel *authorLabel = [[UILabel alloc] init];
        authorLabel.textAlignment = NSTextAlignmentRight;
        authorLabel.font = [UIFont systemFontOfSize:authorFont];
        [self addSubview:authorLabel];
        _authorLabel = authorLabel;
    }
    return self;
}

- (void)setVm:(ViewModel *)vm {
    _vm = vm;
    //frame
    _titleLabel.frame = vm.titleLabelFrame;
    _imageView0.frame = vm.imageView0Frame;
    _imageView1.frame = vm.imageView1Frame;
    _imageView2.frame = vm.imageView2Frame;
    _timeLabel.frame = vm.timeLabelFrame;
    _authorLabel.frame = vm.authorLabelFrame;
    //data
    _titleLabel.text = vm.model.title;
    [_imageView0 sd_setImageWithURL:[NSURL URLWithString:vm.model.thumbnail_pic_s] placeholderImage:[UIImage imageNamed:@""]];
    [_imageView1 sd_setImageWithURL:[NSURL URLWithString:vm.model.thumbnail_pic_s02] placeholderImage:[UIImage imageNamed:@""]];
    [_imageView2 sd_setImageWithURL:[NSURL URLWithString:vm.model.thumbnail_pic_s03] placeholderImage:[UIImage imageNamed:@""]];
    _timeLabel.text = vm.model.date;
    _authorLabel.text = vm.model.author_name;
}

@end
