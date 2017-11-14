//
//  CouponController.m
//  Puzzle
//
//  Created by yiliu on 16/9/9.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "PrintController.h"
#import "SDCycleScrollView.h"
#import "Auxiliary.h"
#import "ReleaseOrderController.h"
#import "ReleaseOrderXCController.h"
#import "YLPhotoPickerController.h"
#import "CouponButton.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"

@interface PrintController ()<YLPhotoPickerDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@property (nonatomic, strong) UIVisualEffectView * effe;

@property (strong, nonatomic) UILabel *couponNumLabel;

@end

@implementation PrintController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *imageUrlArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *imageDict in _commodityDict[@"examplePictures"]) {
        NSString *url = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,imageDict[@"dataURL"]];
        [imageUrlArray addObject:url];
    }
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDE, 240*WIDE/320.0) imageURLStringsGroup:imageUrlArray];
    cycleScrollView.autoScrollTimeInterval = 4;
    [_scrollView addSubview:cycleScrollView];

    
    UILabel *remarksLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, cycleScrollView.frame.size.height+10, WIDE-20, 20)];
    remarksLabel.text = _type;
    remarksLabel.font = [UIFont systemFontOfSize:15];
    remarksLabel.textColor = [UIColor blackColor];
    [_scrollView addSubview:remarksLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, remarksLabel.frame.size.height + remarksLabel.frame.origin.y+4, WIDE-20, 20)];
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.textColor = [UIColor redColor];
    [_scrollView addSubview:priceLabel];
    
    float yy = 0;
    
    yy = priceLabel.frame.origin.y + priceLabel.frame.size.height +10;
    
    //商品介绍图
    NSArray *commodityIntroduceImageArray = _commodityDict[@"detailPictures"];
    for (NSDictionary *commodityIntroduceDict in commodityIntroduceImageArray) {
        
        float width = [commodityIntroduceDict[@"width"] floatValue];
        float height = [commodityIntroduceDict[@"height"] floatValue];
        
        NSString *commodityIntroduceImageUrl = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,commodityIntroduceDict[@"dataURL"]];
        UIImageView *courseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, yy, WIDE, height*(WIDE/width))];
        [courseImageView sd_setImageWithURL:[NSURL URLWithString:commodityIntroduceImageUrl]];
        [_scrollView addSubview:courseImageView];
        
        yy += height*(WIDE/width);
        
    }
        
        //提示
    UILabel *promptlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, yy+20, 100, 20)];
    promptlabel.text = @"温馨提示";
    promptlabel.textColor = RGBACOLOR(248, 118, 66, 1);
    [_scrollView addSubview:promptlabel];
        
    UILabel *fgLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, promptlabel.frame.origin.y+promptlabel.frame.size.height+10, WIDE-20, 0.5)];
    fgLabel.backgroundColor = RGBACOLOR(248, 118, 66, 0.9);
    [_scrollView addSubview:fgLabel];
        
    UILabel *promptOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, fgLabel.frame.origin.y+fgLabel.frame.size.height+10, WIDE-20, 16)];
    promptOneLabel.textColor = RGBACOLOR(248, 118, 66, 1);
    promptOneLabel.font = [UIFont systemFontOfSize:11];
    promptOneLabel.text = @"(1)建议选择像素高，颜色亮的图片，避免打印不清晰或过暗";
    [_scrollView addSubview:promptOneLabel];
        
    UILabel *promptTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, promptOneLabel.frame.origin.y+promptOneLabel.frame.size.height+6, WIDE-20, 16)];
    promptTwoLabel.textColor = RGBACOLOR(248, 118, 66, 1);
    promptTwoLabel.font = [UIFont systemFontOfSize:11];
    promptTwoLabel.text = @"(2)建议确认支付前先点击预览，确保最终打印效果没问题";
    [_scrollView addSubview:promptTwoLabel];
    
    yy = promptTwoLabel.frame.origin.y+promptTwoLabel.frame.size.height+20;
        
    
    
    //说明
    UILabel *instructionslabel = [[UILabel alloc] initWithFrame:CGRectMake(10, yy, 100, 20)];
    instructionslabel.text = @"发货说明";
    instructionslabel.textColor = RGBACOLOR(248, 118, 66, 1);
    [_scrollView addSubview:instructionslabel];
    
    UILabel *gfLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, instructionslabel.frame.origin.y+instructionslabel.frame.size.height+10, WIDE-20, 0.5)];
    gfLabel.backgroundColor = RGBACOLOR(248, 118, 66, 0.9);
    [_scrollView addSubview:gfLabel];
    
    UILabel *oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, gfLabel.frame.origin.y+gfLabel.frame.size.height+10, 16, 14)];
    oneLabel.numberOfLines = 0;
    oneLabel.textColor = RGBACOLOR(248, 118, 66, 1);
    oneLabel.font = [UIFont systemFontOfSize:11];
    oneLabel.text = @"(1)";
    [_scrollView addSubview:oneLabel];
    
    NSString *instructionsOneStr = @"照片打印为定制类商品，将在下单后的2-4工作日内发货，请耐心等待";
    CGSize instructionsOneSize = [Auxiliary calculationHeightWidth:instructionsOneStr andSize:11 andCGSize:CGSizeMake(WIDE-40, 50)];
    UILabel *instructionsOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, gfLabel.frame.origin.y+gfLabel.frame.size.height+10, WIDE-40, instructionsOneSize.height)];
    instructionsOneLabel.numberOfLines = 0;
    instructionsOneLabel.textColor = RGBACOLOR(248, 118, 66, 1);
    instructionsOneLabel.font = [UIFont systemFontOfSize:11];
    instructionsOneLabel.text = instructionsOneStr;
    [_scrollView addSubview:instructionsOneLabel];
    
    UILabel *instructionsTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, instructionsOneLabel.frame.origin.y+instructionsOneLabel.frame.size.height+6, WIDE-20, 16)];
    instructionsTwoLabel.textColor = RGBACOLOR(248, 118, 66, 1);
    instructionsTwoLabel.font = [UIFont systemFontOfSize:11];
    instructionsTwoLabel.text = @"(2)快递默认韵达EMS，统一发货地址：杭州";
    [_scrollView addSubview:instructionsTwoLabel];
    
    _scrollView.contentSize = CGSizeMake(WIDE, instructionsTwoLabel.frame.origin.y+instructionsTwoLabel.frame.size.height+10);
    
    //数据
    NSString *remarks = _commodityDict[@"name"];
    NSString *price = [NSString stringWithFormat:@"￥%@/张",_commodityDict[@"unitPrice"]];
    
    remarksLabel.text = remarks;
    priceLabel.text = price;
    
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.effe removeFromSuperview];
}
//去打印
- (IBAction)goCoupon:(id)sender {
    YLPhotoPickerController *ylPhotoPicker = [[YLPhotoPickerController alloc] init];
    ylPhotoPicker.isMultiselect = YES;
    ylPhotoPicker.isPrint = YES;
    ylPhotoPicker.dataSource = self;
    [self.navigationController pushViewController:ylPhotoPicker animated:YES];
}

#pragma -mark YLPhotoPickerDataSource
- (void)completeSelection:(NSArray *)imagesArray{
    
    [self uploadPictures:imagesArray];
    
}

//返回
- (IBAction)retunView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];  
}

//上传图片
- (void)uploadPictures:(NSArray *)imageArray {

    // 定义毛玻璃效果
//    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//    self.effe = [[UIVisualEffectView alloc]initWithEffect:blur];
//    self.effe.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [self.view addSubview:hud];
    hud.tag=1000;
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.label.text = @"上传照片中...";
    hud.square = YES;
    hud.contentColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    // 把要添加的视图加到毛玻璃上
//    [self.effe addSubview:hud];
//    [self.navigationController.view addSubview:self.effe];
    /*
    //获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置超时时间
    manager.requestSerializer.timeoutInterval = 30;
    
    NSString *url = [NSString stringWithFormat:@"%@file/image/upload",POSTURL];
    
    AFHTTPRequestOperation *operation = [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i=0; i<imageArray.count; i++) {
            
            UIImage *image = imageArray[i];;
            NSString *fileName = [NSString stringWithFormat:@"%i.png",i];
            
            NSData *data = UIImageJPEGRepresentation(image, 1);
            [formData appendPartWithFileData:data  name:@"pictures" fileName:fileName mimeType:@"image/png"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [hud hideAnimated:YES];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"返回值:%@",dict);
        
        // 获取指定的Storyboard，name填写Storyboard的文件名
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
        ReleaseOrderController *releaseOrder = [storyboard instantiateViewControllerWithIdentifier:@"ReleaseOrder"];
        releaseOrder.commodityDict = _commodityDict;
        releaseOrder.imagesArray = imageArray;
        releaseOrder.imagesIdArray = dict[@"imageIds"];
        releaseOrder.type = _type;
        [self.navigationController pushViewController:releaseOrder animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        hud.label.text = @"上传失败";
        [hud hideAnimated:YES afterDelay:1.2];
    }];
    
    //上传进度
    [operation setUploadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        CGFloat precent = (CGFloat)totalBytesRead / totalBytesExpectedToRead;
        hud.progress = precent;
    }];
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
