//
//  StorySetCell.m
//  Puzzle
//
//  Created by yiliu on 2016/10/20.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "StorySetCell.h"

@implementation StorySetCell

- (void)awakeFromNib {
    
    self.editBtn.layer.cornerRadius = 12;
    self.editBtn.layer.masksToBounds = YES;
    self.editBtn.layer.borderWidth = 1;
    self.editBtn.layer.borderColor = RGBACOLOR(229, 202, 101, 1).CGColor;
    
    self.previewBtn.layer.cornerRadius = 12;
    self.previewBtn.layer.masksToBounds = YES;
    self.previewBtn.layer.borderWidth = 1;
    self.previewBtn.layer.borderColor = [UIColor redColor].CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
