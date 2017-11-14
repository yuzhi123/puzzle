//
//  OrderOneCell.h
//  Puzzle
//
//  Created by yiliu on 16/9/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderOneCell : UITableViewCell

/** 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *spImageView;

/** 商品名称 */
@property (weak, nonatomic) IBOutlet UILabel *spNameLabel;

/** 商品单价 */
@property (weak, nonatomic) IBOutlet UILabel *spUnitPriceLabel;

/** 商品预览 */
@property (weak, nonatomic) IBOutlet UIButton *spPreviewBtn;

/** 商品小计数量 */
@property (weak, nonatomic) IBOutlet UILabel *spNumberLabel;

/** 选择的商品数量 */
@property (weak, nonatomic) IBOutlet UILabel *spSZNumLabel;

/** 折扣数量 */
@property (weak, nonatomic) IBOutlet UILabel *spDiscountNumLabel;

/** 总价 */
@property (weak, nonatomic) IBOutlet UILabel *spAllPriceLabel;


@end
