//
//  ReleaseOrderController.h
//  Puzzle
//
//  Created by yiliu on 16/9/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//



// 确认订单以及结算

#import <UIKit/UIKit.h>



@interface ReleaseOrderController : UIViewController

/** 总共费用UILabel宽度约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *allPriceWidthConstraint;

/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/** 打印类型 */
@property (nonatomic, strong) NSString *type;

/** 照片预览 */
@property (nonatomic, strong) NSArray *imagesArray;

/** 上传上服务器的照片id */
@property (nonatomic, strong) NSArray *imagesIdArray;

/** 商品信息 */
@property (nonatomic, strong) NSDictionary *commodityDict;

@end
