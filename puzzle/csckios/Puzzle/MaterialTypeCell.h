//
//  MaterialTypeCell.h
//  Puzzle
//
//  Created by yiliu on 16/9/5.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LockView.h"

@interface MaterialTypeCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bkImageView;

@property (nonatomic, strong) UIView *bkView;

@property (nonatomic, strong) UIImageView *materialImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) LockView *lockView;

@end
