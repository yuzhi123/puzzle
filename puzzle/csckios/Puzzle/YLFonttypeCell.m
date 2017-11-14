//
//  YLFonttypeCell.m
//  Puzzle
//
//  Created by yiliu on 16/9/20.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "YLFonttypeCell.h"

@implementation YLFonttypeCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        
        _ylImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 22, 22)];
        [self.contentView addSubview:_ylImageView];
        
        _ylTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDE, 44)];
        _ylTextLabel.textAlignment = NSTextAlignmentCenter;
        _ylTextLabel.font = [UIFont systemFontOfSize:17];
        _ylTextLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_ylTextLabel];
        
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
