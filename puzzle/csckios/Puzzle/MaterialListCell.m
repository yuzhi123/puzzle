//
//  MaterialListCell.m
//  Puzzle
//
//  Created by yiliu on 16/9/5.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "MaterialListCell.h"

@implementation MaterialListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _materialImageOneView = [[UIImageView alloc] initWithFrame:CGRectMake(12.5, 10, (WIDE-50.0)/3, (WIDE-50.0)/3/(90.0/134.0))];
        _materialImageOneView.userInteractionEnabled = YES;
        _materialImageOneView.contentMode = UIViewContentModeScaleAspectFill;
        _materialImageOneView.clipsToBounds = YES;
        [self.contentView addSubview:_materialImageOneView];
        
        _materialImageTwoView = [[UIImageView alloc] initWithFrame:CGRectMake(12.5*2+(WIDE-50.0)/3, 10, (WIDE-50.0)/3, (WIDE-50.0)/3/(90.0/134.0))];
        _materialImageTwoView.userInteractionEnabled = YES;
        _materialImageTwoView.contentMode = UIViewContentModeScaleAspectFill;
        _materialImageTwoView.clipsToBounds = YES;
        [self.contentView addSubview:_materialImageTwoView];
        
        _materialImageThreeView = [[UIImageView alloc] initWithFrame:CGRectMake(12.5*3+(WIDE-50.0)/3*2, 10, (WIDE-50.0)/3, (WIDE-50.0)/3/(90.0/134.0))];
        _materialImageThreeView.userInteractionEnabled = YES;
        _materialImageThreeView.contentMode = UIViewContentModeScaleAspectFill;
        _materialImageThreeView.clipsToBounds = YES;
        [self.contentView addSubview:_materialImageThreeView];
        
        _downloadOneBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, _materialImageOneView.bounds.size.height-30, 25, 25)];
        [_downloadOneBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [_materialImageOneView addSubview:_downloadOneBtn];
        
        _downloadTwoBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, _materialImageOneView.bounds.size.height-30, 25, 25)];
        [_downloadTwoBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [_materialImageTwoView addSubview:_downloadTwoBtn];
        
        _downloadThreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, _materialImageOneView.bounds.size.height-30, 25, 25)];
        [_downloadThreeBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [_materialImageThreeView addSubview:_downloadThreeBtn];
        
        _progressOneView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressOneView.hidden = YES;
        //设置的高度对进度条的高度没影响，整个高度=进度条的高度，进度条也是个圆角矩形
        _progressOneView.frame=CGRectMake(0, _materialImageOneView.frame.size.height-5, _materialImageOneView.frame.size.width, 5);
        //设置进度条颜色
        _progressOneView.trackTintColor=[UIColor blackColor];
        //设置进度条上进度的颜色
        _progressOneView.progressTintColor=[UIColor redColor];
        [_materialImageOneView addSubview:_progressOneView];
        
        _progressTwoView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, _materialImageTwoView.frame.size.height-5, _materialImageTwoView.frame.size.width, 5)];
        _progressTwoView.hidden = YES;
        //设置进度条颜色
        _progressTwoView.trackTintColor=[UIColor blackColor];
        //设置进度条上进度的颜色
        _progressTwoView.progressTintColor=[UIColor redColor];
        [_materialImageTwoView addSubview:_progressTwoView];
        
        _progressThreeView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressThreeView.hidden = YES;
        //设置的高度对进度条的高度没影响，整个高度=进度条的高度，进度条也是个圆角矩形
        _progressThreeView.frame=CGRectMake(0, _materialImageThreeView.frame.size.height-5, _materialImageThreeView.frame.size.width, 5);
        //设置进度条颜色
        _progressThreeView.trackTintColor=[UIColor blackColor];
        //设置进度条上进度的颜色
        _progressThreeView.progressTintColor=[UIColor redColor];
        [_materialImageThreeView addSubview:_progressThreeView];
        
        //锁定功能
        _suoOneBtn = [[UIButton alloc] initWithFrame:_materialImageOneView.bounds];
        _suoOneBtn.userInteractionEnabled = NO;
        [_suoOneBtn setImage:[UIImage imageNamed:@"suo"] forState:UIControlStateNormal];
        _suoOneBtn.backgroundColor = RGBACOLOR(1, 1, 1, 0.5);
        [_materialImageOneView addSubview:_suoOneBtn];
        
        //锁定功能
        _suoTwoBtn = [[UIButton alloc] initWithFrame:_materialImageTwoView.bounds];
        _suoTwoBtn.userInteractionEnabled = NO;
        [_suoTwoBtn setImage:[UIImage imageNamed:@"suo"] forState:UIControlStateNormal];
        _suoTwoBtn.backgroundColor = RGBACOLOR(1, 1, 1, 0.5);
        [_materialImageTwoView addSubview:_suoTwoBtn];
        
        //锁定功能
        _suoThreeBtn = [[UIButton alloc] initWithFrame:_materialImageThreeView.bounds];
        _suoThreeBtn.userInteractionEnabled = NO;
        [_suoThreeBtn setImage:[UIImage imageNamed:@"suo"] forState:UIControlStateNormal];
        _suoThreeBtn.backgroundColor = RGBACOLOR(1, 1, 1, 0.5);
        [_materialImageThreeView addSubview:_suoThreeBtn];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
