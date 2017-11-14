//
//  MaterialListAdministrationCell.m
//  Puzzle
//
//  Created by yiliu on 16/9/29.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "MaterialListAdministrationCell.h"

@implementation MaterialListAdministrationCell

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
        
        //选中
        _selectOneBtn = [[UIButton alloc] initWithFrame:_materialImageOneView.bounds];
        [_materialImageOneView addSubview:_selectOneBtn];
        
        //选中
        _selectTwoBtn = [[UIButton alloc] initWithFrame:_materialImageTwoView.bounds];
        [_materialImageTwoView addSubview:_selectTwoBtn];
        
        //选中
        _selectThreeBtn = [[UIButton alloc] initWithFrame:_materialImageThreeView.bounds];
        [_materialImageThreeView addSubview:_selectThreeBtn];
        
        
//        [_selectOneBtn setImage:[UIImage imageNamed:@"suo"] forState:UIControlStateNormal];
//        [_selectTwoBtn setImage:[UIImage imageNamed:@"suo"] forState:UIControlStateNormal];
//        [_selectThreeBtn setImage:[UIImage imageNamed:@"suo"] forState:UIControlStateNormal];
        
        [_selectOneBtn setImage:[UIImage imageNamed:@"yuangou"] forState:UIControlStateSelected];
        [_selectTwoBtn setImage:[UIImage imageNamed:@"yuangou"] forState:UIControlStateSelected];
        [_selectThreeBtn setImage:[UIImage imageNamed:@"yuangou"] forState:UIControlStateSelected];
        
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
