//
//  PrintShoppingCell.m
//  Puzzle
//
//  Created by yiliu on 16/9/8.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "PrintShoppingCell.h"

@implementation PrintShoppingCell



- (void)awakeFromNib {
    // Initialization code
    
    [super awakeFromNib];
    
    _pbtn.layer.cornerRadius = 15;
    _pbtn.layer.masksToBounds = YES;
    _pbtn.layer.borderWidth = 2;
    _pbtn.layer.borderColor = RGBACOLOR(255, 126, 121, 1).CGColor;
    
    _pImageView.contentMode = UIViewContentModeScaleAspectFill;
    _pImageView.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
