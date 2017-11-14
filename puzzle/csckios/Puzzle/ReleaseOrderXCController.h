//
//  ReleaseOrderXCController.h
//  Puzzle
//
//  Created by yiliu on 2016/10/19.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//LOMO专属相册订单确认

#import <UIKit/UIKit.h>

@interface ReleaseOrderXCController : UIViewController

/** 商品信息 */
@property (strong, nonatomic) NSDictionary *commodityDict;



//地址
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

//DIY相册图
@property (weak, nonatomic) IBOutlet UIImageView *diyImageView;

//DIY相册名字
@property (weak, nonatomic) IBOutlet UILabel *diyNameLabel;

//DIY相册价格
@property (weak, nonatomic) IBOutlet UILabel *diyPriceLabel;

//数量
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

//小计
@property (weak, nonatomic) IBOutlet UILabel *priceXJLabel;

//合计
@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;



//优惠搭配view
@property (weak, nonatomic) IBOutlet UIView *youhuidapeiView;

//优惠搭配名字
@property (weak, nonatomic) IBOutlet UILabel *youhuidapeiNameLabel;

//优惠搭配的价格
@property (weak, nonatomic) IBOutlet UILabel *youhuidapeiPriceLabel;

//闪光笔名字
@property (weak, nonatomic) IBOutlet UILabel *shanguangbiNameLabel;

//角贴名字
@property (weak, nonatomic) IBOutlet UILabel *jiaotieNameLabel;

//闪光笔图片
@property (weak, nonatomic) IBOutlet UIImageView *shanguagnbiImageView;

//角贴图片
@property (weak, nonatomic) IBOutlet UIImageView *jiaotieImageView;



//支付类型view
@property (weak, nonatomic) IBOutlet UIView *payView;

//支付类型距离优惠搭配view下边距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payConstraint;

@end
