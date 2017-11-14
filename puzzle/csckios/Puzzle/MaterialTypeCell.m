//
//  MaterialTypeCell.m
//  Puzzle
//
//  Created by yiliu on 16/9/5.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "MaterialTypeCell.h"

@implementation MaterialTypeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _bkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDE, 120)];
        _bkImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bkImageView.clipsToBounds = YES;
        [self.contentView addSubview:_bkImageView];
        
        UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        visualEffect.frame = _bkImageView.bounds;
        [_bkImageView addSubview:visualEffect];
        
        _bkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDE, 120)];
        _bkView.backgroundColor = [UIColor blackColor];
        _bkView.alpha = 0.1;
        [self.contentView addSubview:_bkView];
        
        _materialImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 68, 100)];
        _materialImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_materialImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(98, 40, WIDE-120, 40)];
        _titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
        
        //锁定功能
        _lockView = [[LockView alloc] initWithFrame:_materialImageView.bounds];
        [_materialImageView addSubview:_lockView]; 
        
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
