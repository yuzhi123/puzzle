//
//  OrderOneCell.m
//  Puzzle
//
//  Created by yiliu on 16/9/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "OrderOneCell.h"

@implementation OrderOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.spPreviewBtn.layer.cornerRadius = 4;
    self.spPreviewBtn.layer.masksToBounds = YES;
    self.spPreviewBtn.layer.borderWidth = 1;
    self.spPreviewBtn.layer.borderColor = RGBACOLOR(96, 196, 152, 1).CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
