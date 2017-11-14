//
//  SpecialEffectsCell.m
//  meitu
//
//  Created by yiliu on 15/5/27.
//  Copyright (c) 2015年 meitu. All rights reserved.
//

#import "SpecialEffectsCell.h"

@implementation SpecialEffectsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _specialImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 70, 70)];
        _specialImage.contentMode = UIViewContentModeScaleAspectFill;
        _specialImage.clipsToBounds = YES;
        _specialImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_specialImage];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
