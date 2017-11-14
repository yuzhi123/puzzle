//
//  OrderTwoCell.h
//  Puzzle
//
//  Created by yiliu on 16/9/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTwoCell : UITableViewCell

/** 礼盒名称UILabel宽度约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lhNameWidthConstranit;

/** 礼盒价格UILabel宽度约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lhPriceWidthConstranit;

/** 礼盒原价UILabel宽度约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lhOriginalPriceWidthConstranit;

/** 礼盒名称 */
@property (weak, nonatomic) IBOutlet UILabel *lhNameLabel;

/** 选择/取消礼盒 按钮 */
@property (weak, nonatomic) IBOutlet UIButton *lhXZBtn;

/** 礼盒图片 */
@property (weak, nonatomic) IBOutlet UIImageView *lhImageView;

/** 礼盒名称2 */
@property (weak, nonatomic) IBOutlet UILabel *lhNameTLabel;

/** 新品体验 */
@property (weak, nonatomic) IBOutlet UILabel *lhXPLabel;

/** 礼盒价格 */
@property (weak, nonatomic) IBOutlet UILabel *lhPriceLabel;

/** 礼盒原价 */
@property (weak, nonatomic) IBOutlet UILabel *lhOriginalPriceLabel;

@end
