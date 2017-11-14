//
//  MaterialTypeHotCell.m
//  Puzzle
//
//  Created by yiliu on 16/9/5.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "MaterialTypeHotCell.h"

@implementation MaterialTypeHotCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _materialImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 80, 120)];
        [self.contentView addSubview:_materialImageView];
        
        UIImageView *hotView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, 30, 30)];
        hotView.image = [UIImage imageNamed:@"hot"];
        [_materialImageView addSubview:hotView];
        
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
