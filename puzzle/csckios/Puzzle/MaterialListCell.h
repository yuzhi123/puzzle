//
//  MaterialListCell.h
//  Puzzle
//
//  Created by yiliu on 16/9/5.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaterialListCell : UITableViewCell

@property (nonatomic, strong) UIImageView *materialImageOneView;

@property (nonatomic, strong) UIImageView *materialImageTwoView;

@property (nonatomic, strong) UIImageView *materialImageThreeView;

@property (nonatomic, strong) UIButton *downloadOneBtn;

@property (nonatomic, strong) UIButton *downloadTwoBtn;

@property (nonatomic, strong) UIButton *downloadThreeBtn;

@property (nonatomic, strong) UIProgressView *progressOneView;

@property (nonatomic, strong) UIProgressView *progressTwoView;

@property (nonatomic, strong) UIProgressView *progressThreeView;


@property (nonatomic, strong) UIButton *suoOneBtn;

@property (nonatomic, strong) UIButton *suoTwoBtn;

@property (nonatomic, strong) UIButton *suoThreeBtn;

@end
