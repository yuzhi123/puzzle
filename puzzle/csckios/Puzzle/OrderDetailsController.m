//
//  OrderDetailsController.m
//  Puzzle
//
//  Created by yiliu on 2016/10/31.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "OrderDetailsController.h"
#import "OrderOneCell.h"
#import "OrderTwoCell.h"
#import "OrderThreeCell.h"
#import "YLPictureBrowserView.h"
#import "YLBrowserView.h"
#import "Auxiliary.h"
#import "UIImageView+WebCache.h"

@interface OrderDetailsController ()<UITableViewDataSource,UITableViewDelegate,YLPictureBrowserDelegate>
{
    YLPictureBrowserView *ylPictureBrowser;
    NSDictionary *commodityDict;
}
@end

@implementation OrderDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    InstancesModel *instancesModel = _orderModel.instancesArray[0];
    
    if ([instancesModel.name isEqual:@"LOMO卡照片"]) {
    
        commodityDict = _commodityArray[0];
        
    }else {
        
        commodityDict = _commodityArray[1];
        
    }
    
    if (_orderModel.freight == 0) {
        _freightLabel.hidden = YES;
    }
    _totalLabel.text = [NSString stringWithFormat:@"￥%.2f",_orderModel.total];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma -mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

//分组头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

//分组尾高
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (_orderModel.instancesArray.count == 1 && section == 2) {
        
        return 0.000000001;
        
    }else if (section == 3 && _orderModel.freight == 0) {
        
        return 0.00000001;
        
    }
    return 10;
    
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        
        return 200;
        
//    }else if (indexPath.section == 2) {
//        
//        if (_orderModel.instancesArray.count == 1) {
//            
//            return 0.00000001;
//            
//        }
//        
//        return 120;
        
    }else if (indexPath.section == 2 && _orderModel.freight == 0) {
        
        return 0.00000001;
    
    }
    return 44;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString *reuseIdetify = @"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
        }
        
        cell.imageView.image = [UIImage imageNamed:@"zuobiao"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",_orderModel.address];
        
        return cell;
        
    }if (indexPath.section == 1) {
        
        static NSString *reuseIdetify = @"OrderOneCell";
        OrderOneCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.spPreviewBtn addTarget:self action:@selector(previewSP:) forControlEvents:UIControlEventTouchUpInside];
        
        InstancesModel *instancesModel = _orderModel.instancesArray[0];
        
        cell.spNameLabel.text = instancesModel.name;
        cell.spUnitPriceLabel.text = [NSString stringWithFormat:@"￥%@/张",instancesModel.unitPrice];
        cell.spSZNumLabel.text = instancesModel.number;
        cell.spDiscountNumLabel.text = @"无";
        cell.spNumberLabel.text = [NSString stringWithFormat:@"￥%@x%@张",instancesModel.unitPrice,instancesModel.number];
        cell.spAllPriceLabel.text = [NSString stringWithFormat:@"%.2f元",[instancesModel.unitPrice floatValue]*[instancesModel.number floatValue]];
        
        NSString *url = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,commodityDict[@"examplePictures"][0][@"dataURL"]];
        [cell.spImageView sd_setImageWithURL:[NSURL URLWithString:url]];
        
        cell.spImageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.spImageView.clipsToBounds = YES;
        
        return cell;
        
//    }else if (indexPath.section == 2) {
//        
//        static NSString *reuseIdetify = @"OrderTwoCell";
//        OrderTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lhPreview:)];
//        [cell.lhImageView addGestureRecognizer:tap];
//        
//        if (_orderModel.instancesArray.count > 1) {
//            
//            InstancesModel *instancesModel = _orderModel.instancesArray[1];
//            
//            NSString *originalPriceStr = [NSString stringWithFormat:@"原价￥39.90"];
//            CGSize originalPriceSize = [Auxiliary calculationHeightWidth:originalPriceStr andSize:10 andCGSize:CGSizeMake(WIDE, 20)];
//            
//            //中划线
//            NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:originalPriceStr attributes:attribtDic];
//            //修改宽度约束
//            cell.lhOriginalPriceWidthConstranit.constant = originalPriceSize.width+5;
//            
//            //名称
//            cell.lhNameTLabel.text = instancesModel.name;
//            //现价
//            cell.lhPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[instancesModel.unitPrice floatValue]];
//            //原价
//            cell.lhOriginalPriceLabel.attributedText = attribtStr;
//            
//            //相册示例图
//            NSArray *belongArray = commodityDict[@"belong"];
//            if (belongArray) {
//                
//                NSDictionary *youhuiDict = belongArray[0];
//                NSString *biurl = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,youhuiDict[@"examplePictures"][0][@"dataURL"]];
//                [cell.lhImageView sd_setImageWithURL:[NSURL URLWithString:biurl]];
//                
//                cell.lhImageView.contentMode = UIViewContentModeScaleAspectFill;
//                cell.lhImageView.clipsToBounds = YES;
//                
//            }
//            
//        }
//        
//        return cell;
        
    }else {
        
        static NSString *reuseIdetify = @"OrderThreeCell";
        OrderThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
}

//预览
- (void)previewSP:(UIButton *)btn {
    
    self.titleLabel.text = @"照片浏览";
    
    ylPictureBrowser = [[YLPictureBrowserView alloc] initWithFrame:CGRectMake(0, 50, WIDE, HIGH-50)];
    
    ylPictureBrowser.delegate = self;
    
    /** 图片URL数组 */
    InstancesModel *instancesModel = _orderModel.instancesArray[0];
    ylPictureBrowser.imageurlsArray = instancesModel.imagesURLArray;
    
    /** 图片的边框位置 */
    ylPictureBrowser.imageBkRect = CGRectMake((ylPictureBrowser.bounds.size.width-(WIDE-130+10))/2, ylPictureBrowser.bounds.size.height/2-((2100.0/1500.0)*(WIDE-130)+55)/2-5, WIDE-130+10, (2100.0/1500.0)*(WIDE-130)+10);
    
    /** 图片的位置 */
    ylPictureBrowser.imageRect = CGRectMake((ylPictureBrowser.bounds.size.width-(WIDE-130))/2, ylPictureBrowser.bounds.size.height/2-((2100.0/1500.0)*(WIDE-130)+55)/2, WIDE-130, (2100.0/1500.0)*(WIDE-130));
    
    /** 图片张数的位置 */
    ylPictureBrowser.imageProportionRect = CGRectMake((ylPictureBrowser.bounds.size.width-(WIDE-130))/2, ylPictureBrowser.bounds.size.height/2+((275.0/200.0)*(WIDE-130)+55)/2+20, WIDE-130, 35);
    
    /** 背景颜色 */
    ylPictureBrowser.bkColor = RGBACOLOR(230, 230, 230, 1);
    
    [self.view addSubview:ylPictureBrowser];
    
}

#pragma -mark YLPictureBrowserDelegate 图片浏览回调
- (void)tapYLPictureBrowserView {
    self.titleLabel.text = @"订单详情";
    [ylPictureBrowser removeFromSuperview];
    ylPictureBrowser = nil;
}

//相册预览
- (void)lhPreview:(UITapGestureRecognizer *)tap {
    
    //相册示例图
    NSArray *belongArray = commodityDict[@"belong"];
    NSArray *xcArray = belongArray[0][@"examplePictures"][@"dataURL"];
    NSString *xcurl0 = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,xcArray[0]];
    NSString *xcurl1 = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,xcArray[1]];
    NSString *xcurl2 = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,xcArray[2]];
    
    NSString *validity0 = @"尺寸：27*20*4cm     内页：30张60面\n容量：可放30-120张照片";
    NSString *validity1 = @"高档牛皮纸硬壳封面\n精致礼盒装，自用送人必备";
    NSString *validity2 = @"为你记录生活中的每一刻";
    
    NSDictionary *dict0 = @{@"image":xcurl0,@"validity":validity0};
    NSDictionary *dict1 = @{@"image":xcurl1,@"validity":validity1};
    NSDictionary *dict2 = @{@"image":xcurl2,@"validity":validity2};
    
    NSArray *arry = @[dict0,dict1,dict2];
    
    YLBrowserView *ylBrowser = [[YLBrowserView alloc] initWithFrame:CGRectMake(0, 50, WIDE, HIGH-50)];
    
    ylBrowser.dataArray = arry;
    
    [self.view addSubview:ylBrowser];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回
- (IBAction)retunView:(id)sender {
    if (ylPictureBrowser) {
        //如果是预览状态，点返回就取消预览
        [self tapYLPictureBrowserView];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



@end
