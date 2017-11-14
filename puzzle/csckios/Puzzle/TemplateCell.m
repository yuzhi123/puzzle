//
//  TemplateCell.m
//  Puzzle
//
//  Created by yiliu on 16/8/30.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "TemplateCell.h"

@implementation TemplateCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        _templateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 6, 50, 70)];
        _templateImageView.contentMode = UIViewContentModeScaleAspectFill;
        _templateImageView.clipsToBounds = YES;
        _templateImageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_templateImageView];
        
        _layerLabel0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 56, 3)];
        _layerLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 73, 56, 3)];
        
        _layerLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 3, 76)];
        _layerLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(53, 0, 3, 76)];
        
        _layerLabel0.backgroundColor = [UIColor redColor];
        _layerLabel1.backgroundColor = [UIColor redColor];
        _layerLabel2.backgroundColor = [UIColor redColor];
        _layerLabel3.backgroundColor = [UIColor redColor];
        
        _layerLabel0.hidden = YES;
        _layerLabel1.hidden = YES;
        _layerLabel2.hidden = YES;
        _layerLabel3.hidden = YES;
        
        [self.contentView addSubview:_layerLabel0];
        [self.contentView addSubview:_layerLabel1];
        [self.contentView addSubview:_layerLabel2];
        [self.contentView addSubview:_layerLabel3];
        
    }
    return self;
}

- (void)selectTemplate{
    _layerLabel0.hidden = NO;
    _layerLabel1.hidden = NO;
    _layerLabel2.hidden = NO;
    _layerLabel3.hidden = NO;
    _templateImageView.frame = CGRectMake(3, 3, 50, 70);
}

- (void)cancelSelectTemplate{
    _layerLabel0.hidden = YES;
    _layerLabel1.hidden = YES;
    _layerLabel2.hidden = YES;
    _layerLabel3.hidden = YES;
    _templateImageView.frame = CGRectMake(3, 6, 50, 70);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
