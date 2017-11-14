//
//  OrderXCDetailsController.m
//  Puzzle
//
//  Created by yiliu on 2016/11/2.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "OrderXCDetailsController.h"
#import "InstancesModel.h"
#import "UIImageView+WebCache.h"

@interface OrderXCDetailsController ()

@end

@implementation OrderXCDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _xcImageView.contentMode = UIViewContentModeScaleAspectFill;
    _xcImageView.clipsToBounds = YES;
    
    _shanguangbiImageView.contentMode = UIViewContentModeScaleAspectFill;
    _shanguangbiImageView.clipsToBounds = YES;
    
    _jiaotieImageView.contentMode = UIViewContentModeScaleAspectFill;
    _jiaotieImageView.clipsToBounds = YES;
    
    InstancesModel *instancesModel = _orderModel.instancesArray[0];
    
    /** 地址 */
    _addressLabel.text = _orderModel.address;
    
    /** 相册数量 */
    _xcNumberLabel.text = instancesModel.number;
    
    /** 相册单价 */
    _xcPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[instancesModel.unitPrice floatValue]];
    
    /** 相册小计 */
    _subtotalLabel.text = [NSString stringWithFormat:@"￥%.2f",[instancesModel.unitPrice floatValue]*[instancesModel.number integerValue]];
    
    /** 总价 */
    _totalLabel.text = [NSString stringWithFormat:@"￥%.2f",_orderModel.total];
    
    
    
    //DIY相册示例图
    NSString *url = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,_commodityDict[@"examplePictures"][0][@"dataURL"]];
    [_xcImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    
    //优惠搭配
    NSArray *belongArray = _commodityDict[@"belong"];
    if (belongArray && _orderModel.instancesArray.count == 2) {
        
        _discountView.hidden = NO;
        
        //闪光笔示例图
        NSDictionary *youhuiDict = belongArray[0];
        NSString *biurl = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,youhuiDict[@"examplePictures"][0][@"dataURL"]];
        [_shanguangbiImageView sd_setImageWithURL:[NSURL URLWithString:biurl]];
        
        //角贴示例图
        NSDictionary *tieDict = belongArray[0];
        NSString *tieurl = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,tieDict[@"examplePictures"][1][@"dataURL"]];
        [_jiaotieImageView sd_setImageWithURL:[NSURL URLWithString:tieurl]];
        
        //优惠搭配名称
        _youhuidapeiNameLabel.text = [NSString stringWithFormat:@"(DIY相册伴侣(%@))",belongArray[0][@"name"]];
        
        //优惠搭配总价
        _youhuidapeiPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[belongArray[0][@"unitPrice"] floatValue]];
        
        NSArray *youhuiArray = [belongArray[0][@"name"] componentsSeparatedByString:@"+"];
        //闪光笔名称
        _shanguangbiNameLabel.text = youhuiArray[0];
        
        //角贴名称
        _jiaotieNameLabel.text = youhuiArray[1];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//返回上一页
- (IBAction)retunView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
