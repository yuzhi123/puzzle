//
//  OrderTwoCell.m
//  Puzzle
//
//  Created by yiliu on 16/9/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "OrderTwoCell.h"

@implementation OrderTwoCell


- (void)awakeFromNib {
    
    self.lhXPLabel.layer.cornerRadius = 2;
    self.lhXPLabel.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
