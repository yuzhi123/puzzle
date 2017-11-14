//
//  TemplateCell.h
//  Puzzle
//
//  Created by yiliu on 16/8/30.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TemplateCell : UITableViewCell

@property (nonatomic, strong) UIImageView *templateImageView;

@property (nonatomic, strong) UILabel *layerLabel0;
@property (nonatomic, strong) UILabel *layerLabel1;
@property (nonatomic, strong) UILabel *layerLabel2;
@property (nonatomic, strong) UILabel *layerLabel3;

/** 选择 */
- (void)selectTemplate;

/** 取消选择 */
- (void)cancelSelectTemplate;

@end
