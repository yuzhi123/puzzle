//
//  MaterialListViewController.m
//  Puzzle
//
//  Created by yiliu on 16/9/5.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "MaterialListController.h"
#import "MaterialListCell.h"
#import "TableViewIndexesView.h"
#import "MaterialDetailsController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

#import "TemplateModel.h"
#import "PhotoModel.h"
#import "WrittenWordModel.h"

#import "TemplateOperation.h"
#import "ImagesDownloadQueue.h"

#import "MBProgressHUD.h"

@interface MaterialListController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,TableViewIndexesDelegate,ImagesDownloadQueueDelegate,MaterialDetailsDelegate>

/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/** 表格 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 索引view */
@property (strong, nonatomic) TableViewIndexesView *tableIndexesView;

/** 数据 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 一键下载 */
@property (weak, nonatomic) IBOutlet UIButton *downAllBtn;

@end

@implementation MaterialListController

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_isUnlock == NO) {
        _downAllBtn.hidden = YES;
    }
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    _tableIndexesView = [[TableViewIndexesView alloc] initWithFrame:CGRectMake(WIDE-24, HIGH/2-self.dataArray.count*20, 24, self.dataArray.count*40) indexsNum:self.dataArray.count];
    _tableIndexesView.delegate = self;
    [self.view addSubview:_tableIndexesView];
    
    //获取数据
    [self post];
    
}

#pragma -mark TableViewIndexesDelegate
- (void)choiceIndex:(NSInteger)index {
    
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:0 inSection:index];
    
    [_tableView selectRowAtIndexPath:idxPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    
}

#pragma -mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    float hig = (WIDE-50.0)/3/(90.0/134.0)+10;
    float yy = scrollView.contentOffset.y / hig;
    
    NSInteger numRow = 0;
    NSInteger index = 0;
    for (int i = 0; i < _dataArray.count; i++) {
        
        numRow += [_dataArray[i] count] % 3 > 0 ? [_dataArray[i] count] / 3 + 1 : [_dataArray[i] count] / 3;
        
        if (yy > numRow) {
            
            index = i+1;
            
        }
        
    }
    
    [_tableIndexesView switchBtn:index];
    
}


#pragma -mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arry = _dataArray[section][@"content"];
    return [arry count] % 3 > 0 ? [arry count] / 3 + 1 : [arry count] / 3;
}

//设置分区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray *arry = _dataArray[section][@"content"];
    NSString *key = _dataArray[section][@"num"];
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDE, 30)];
    headLabel.font = [UIFont systemFontOfSize:15];
    headLabel.textColor = [UIColor whiteColor];
    headLabel.backgroundColor = RGBACOLOR(100, 100, 100, 1);
    headLabel.text = [NSString stringWithFormat:@"  %@张（%tu）",key,[arry count]];
    return headLabel;
    
}

//设置分区尾
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

//设置分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

//设置分区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (WIDE-50.0)/3/(90.0/134.0)+10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"MaterialListCell";
    MaterialListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[MaterialListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.downloadOneBtn addTarget:self action:@selector(downLoadMaterial:) forControlEvents:UIControlEventTouchUpInside];
        [cell.downloadTwoBtn addTarget:self action:@selector(downLoadMaterial:) forControlEvents:UIControlEventTouchUpInside];
        [cell.downloadThreeBtn addTarget:self action:@selector(downLoadMaterial:) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeDetails:)];
        [cell.materialImageOneView addGestureRecognizer:tap];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeDetails:)];
        [cell.materialImageTwoView addGestureRecognizer:tap1];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeDetails:)];
        [cell.materialImageThreeView addGestureRecognizer:tap2];
        
    }
    
    cell.suoOneBtn.hidden = YES;
    cell.suoTwoBtn.hidden = YES;
    cell.suoThreeBtn.hidden = YES;
    
    cell.downloadOneBtn.tag = 100000*indexPath.section + indexPath.row*3;
    cell.downloadTwoBtn.tag = 100000*indexPath.section + indexPath.row*3+1;
    cell.downloadThreeBtn.tag = 100000*indexPath.section + indexPath.row*3+2;
    
    cell.materialImageOneView.tag = 100000*indexPath.section + indexPath.row*3;
    cell.materialImageTwoView.tag = 100000*indexPath.section + indexPath.row*3+1;
    cell.materialImageThreeView.tag = 100000*indexPath.section + indexPath.row*3+2;
    
    cell.downloadOneBtn.hidden = YES;
    cell.downloadTwoBtn.hidden = YES;
    cell.downloadThreeBtn.hidden = YES;
    
    cell.materialImageOneView.image = nil;
    cell.materialImageTwoView.image = nil;
    cell.materialImageThreeView.image = nil;
    
    TemplateModel *templateModel;
    
    NSArray *arry = _dataArray[indexPath.section][@"content"];
    
    if ([arry count] > indexPath.row*3) {
        
        templateModel = arry[indexPath.row*3];
        
        if (templateModel.istemplateDownload) {
            
            cell.progressOneView.hidden = YES;
            cell.downloadOneBtn.hidden = YES;
            
        }else {
            
            if (templateModel.isDownloading) {
                
                cell.progressOneView.progress = templateModel.downloadProgress;
                cell.downloadOneBtn.hidden = YES;
                cell.progressOneView.hidden = NO;
                
            }else {
                
                cell.downloadOneBtn.hidden = NO;
                cell.progressOneView.hidden = YES;
                
            }
            
        }
        
        [cell.materialImageOneView sd_setImageWithURL:[NSURL URLWithString:templateModel.templateSampleGraphUrl] placeholderImage:PlaceholderImage];
        
        //如果解除了锁定
        if (_isUnlock == NO) {
            cell.suoOneBtn.hidden = NO;
        }
        
    }
    if ([arry count] > indexPath.row*3+1) {
        
        templateModel = arry[indexPath.row*3+1];
        
        if (templateModel.istemplateDownload) {
            
            cell.progressTwoView.hidden = YES;
            cell.downloadTwoBtn.hidden = YES;
            
        }else {
            
            if (templateModel.isDownloading) {
                
                cell.progressTwoView.progress = templateModel.downloadProgress;
                cell.downloadTwoBtn.hidden = YES;
                cell.progressTwoView.hidden = NO;
                
            }else {
                
                cell.downloadTwoBtn.hidden = NO;
                cell.progressTwoView.hidden = YES;
                
            }
            
        }
        
        [cell.materialImageTwoView sd_setImageWithURL:[NSURL URLWithString:templateModel.templateSampleGraphUrl] placeholderImage:PlaceholderImage];
        
        //如果解除了锁定
        if (_isUnlock == NO) {
            cell.suoTwoBtn.hidden = NO;
        }
        
    }
    if ([arry count] > indexPath.row*3+2) {
        
        templateModel = arry[indexPath.row*3+2];
        
        if (templateModel.istemplateDownload) {
            
            cell.progressThreeView.hidden = YES;
            cell.downloadThreeBtn.hidden = YES;
            
        }else {
            
            if (templateModel.isDownloading) {
                
                cell.progressThreeView.progress = templateModel.downloadProgress;
                cell.downloadThreeBtn.hidden = YES;
                cell.progressThreeView.hidden = NO;
                
            }else {
                
                cell.downloadThreeBtn.hidden = NO;
                cell.progressThreeView.hidden = YES;
                
            }
            
        }
        
        [cell.materialImageThreeView sd_setImageWithURL:[NSURL URLWithString:templateModel.templateSampleGraphUrl] placeholderImage:PlaceholderImage];
        
        //如果解除了锁定
        if (_isUnlock == NO) {
            cell.suoThreeBtn.hidden = NO;
        }
        
    }
    
    return cell;
    
}

//查看详情
- (void)seeDetails:(UITapGestureRecognizer *)tap {
    
    NSInteger section = tap.view.tag / 100000;
    NSInteger index = tap.view.tag % 100000;
    
    // 获取指定的Storyboard，name填写Storyboard的文件名
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
    MaterialDetailsController *materialDetails = [storyboard instantiateViewControllerWithIdentifier:@"MaterialDetails"];
    materialDetails.dataArray = _dataArray[section][@"content"];
    materialDetails.proportionIndex = index;
    materialDetails.section = section;
    materialDetails.delegate = self;
    materialDetails.isUnlock = _isUnlock;
    [self.navigationController pushViewController:materialDetails animated:YES];
    
}

#pragma -mark MaterialDetailsDelegate
- (void)downSuccess:(NSDictionary *)dict {
    
    NSInteger section = [dict[@"section"] integerValue];
    NSInteger index = [dict[@"index"] integerValue];
    TemplateModel *templateModel = dict[@"TemplateModel"];
    
    if ([templateModel.templateType isEqual:self.titleLabel.text] || [templateModel.templateSpecial isEqual:self.titleLabel.text]) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index/3 inSection:section];
        MaterialListCell *cell = (MaterialListCell *)[_tableView cellForRowAtIndexPath:indexPath];
        
        if (index%3 == 0) {
            
            cell.progressOneView.progress = templateModel.downloadProgress;
            
            if (templateModel.downloadProgress == 1) {
                cell.progressOneView.hidden = YES;
                cell.downloadOneBtn.hidden = YES;
            }
            
        }else if (index%3 == 1) {
            
            cell.progressTwoView.progress = templateModel.downloadProgress;
            
            if (templateModel.downloadProgress == 1) {
                cell.progressTwoView.hidden = YES;
                cell.downloadTwoBtn.hidden = YES;
            }
            
        }else if (index%3 == 2) {
            
            cell.progressThreeView.progress = templateModel.downloadProgress;
            
            if (templateModel.downloadProgress == 1) {
                cell.progressThreeView.hidden = YES;
                cell.downloadThreeBtn.hidden = YES;
            }
            
        }
        
    }
    
}

//下载
- (void)downLoadMaterial:(UIButton *)btn {
    
    NSInteger section = btn.tag / 100000;
    NSInteger index = btn.tag % 100000;
    
    NSLog(@"分组：%tu,第几个：%tu",section,index);
    
    TemplateModel *templateModel = _dataArray[section][@"content"][index];
    templateModel.isDownloading = YES;
    
    NSLog(@"第几行：%tu   第几个：%tu",index/3,index%3);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index/3 inSection:section];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    NSDictionary *dict = @{@"TemplateModel":templateModel,
                           @"section":[NSString stringWithFormat:@"%tu",section],
                           @"index":[NSString stringWithFormat:@"%tu",index]};
    
    [ImagesDownloadQueue CreateDownloadQueueManager].delegate = self;
    [[ImagesDownloadQueue CreateDownloadQueueManager] downloadImage:dict];
    
}

//一键下载
- (IBAction)allDownload:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    btn.enabled = NO;
    
    NSMutableArray *downsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < _dataArray.count; i++) {
        
        NSArray *ary = _dataArray[i][@"content"];
        
        for (int y = 0; y < ary.count; y++) {
            
            TemplateModel *templateModel = ary[y];
            
            if (!templateModel.isDownloading && !templateModel.istemplateDownload) {
                
                templateModel.isDownloading = YES;
                
                NSDictionary *dict = @{@"TemplateModel":templateModel,
                                       @"section":[NSString stringWithFormat:@"%tu",i],
                                       @"index":[NSString stringWithFormat:@"%tu",y]};
                [downsArray addObject:dict];
                
            }
            
        }
        
    }
    
    [_tableView reloadData];
    
    [ImagesDownloadQueue CreateDownloadQueueManager].delegate = self;
    [[ImagesDownloadQueue CreateDownloadQueueManager] downloadImages:downsArray];
    
}

#pragma -mark ImagesDownloadQueueDelegate 下载回调
- (void)downProgress:(NSDictionary *)dict {
    
    NSInteger section = [dict[@"section"] integerValue];
    NSInteger index = [dict[@"index"] integerValue];
    TemplateModel *templateModel = dict[@"TemplateModel"];
    
    if ([templateModel.templateType isEqual:self.titleLabel.text] || [templateModel.templateSpecial isEqual:self.titleLabel.text]) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index/3 inSection:section];
        MaterialListCell *cell = (MaterialListCell *)[_tableView cellForRowAtIndexPath:indexPath];
        
        if (index%3 == 0) {
            
            cell.progressOneView.progress = templateModel.downloadProgress;
            
            if (templateModel.downloadProgress == 1) {
                cell.progressOneView.hidden = YES;
            }
            
        }else if (index%3 == 1) {
            
            cell.progressTwoView.progress = templateModel.downloadProgress;
            
            if (templateModel.downloadProgress == 1) {
                cell.progressTwoView.hidden = YES;
            }
            
        }else if (index%3 == 2) {
            
            cell.progressThreeView.progress = templateModel.downloadProgress;
            
            if (templateModel.downloadProgress == 1) {
                cell.progressThreeView.hidden = YES;
            }
            
        }
        
    }
    
}

//下载失败
- (void)downFail:(NSDictionary *)dict {
    
    NSInteger section = [dict[@"section"] integerValue];
    NSInteger index = [dict[@"index"] integerValue];
    TemplateModel *templateModel = dict[@"TemplateModel"];
    templateModel.isDownloading = NO;
    templateModel.istemplateDownload = NO;
    
    if ([templateModel.templateType isEqual:self.titleLabel.text] || [templateModel.templateSpecial isEqual:self.titleLabel.text]) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index/3 inSection:section];
        MaterialListCell *cell = (MaterialListCell *)[_tableView cellForRowAtIndexPath:indexPath];
        
        if (index%3 == 0) {
            
            cell.progressOneView.hidden = YES;
            cell.downloadOneBtn.hidden = NO;
            
        }else if (index%3 == 1) {
            
            cell.progressTwoView.hidden = YES;
            cell.downloadTwoBtn.hidden = NO;
            
        }else if (index%3 == 2) {
            
            cell.progressThreeView.hidden = YES;
            cell.downloadThreeBtn.hidden = NO;
            
        }
        
    }
    
}

//返回
- (IBAction)rutenView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)post {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    
    NSString *url;
    if ([_selectType isEqual:@"分类"]) {
        url = [NSString stringWithFormat:@"%@templet/type/num?typeId=%tu",POSTURL,_selectId];
    }else {
        url = [NSString stringWithFormat:@"%@templet/term/num?termId=%tu",POSTURL,_selectId];
    }
    /*
    //获得请求管理者
    AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
    manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置超时时间
    manager1.requestSerializer.timeoutInterval = 30;
    
    [manager1 GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        //按照照片数量排序
        NSArray *keys = [dict allKeys];
        NSMutableArray *keysAry = [[NSMutableArray alloc] initWithCapacity:0];
        [keysAry addObjectsFromArray:keys];
        
        NSInteger count = [keysAry count];
        
        for (int i = 0; i < count; i++) {
            
            for (int j = 0; j < count - i - 1; j++) {
                
                if([[keysAry objectAtIndex:j] compare:[keysAry objectAtIndex:j + 1] options:NSNumericSearch] == 1){
                    //同上potions  NSNumericSearch = 64,
                    //这里可以用exchangeObjectAtIndex:方法来交换两个位置的数组元素。
                    [keysAry exchangeObjectAtIndex:j withObjectAtIndex:(j + 1)];
                }
            }
        }
        
        //整理数据
        for (NSString *key in keysAry) {
            
            NSArray *ary = dict[key];
            
            NSMutableArray *templateArray = [[NSMutableArray alloc] initWithCapacity:0];
            
            for (NSDictionary *dict in ary) {
                
                //实例图片
                NSString *templateSampleGraphUrl = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,dict[@"sampleGraphUrl"]];
                
                //大图（下载地址）
                NSString *templatePictureUrl = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,dict[@"downloadURL"]];
                
                //保存图片的名字
                NSArray *ary = [templatePictureUrl componentsSeparatedByString:@"/"];
                NSString *name = ary[ary.count-1];
                
                TemplateOperation *templateOperation = [[TemplateOperation alloc] init];
                
                TemplateModel *templatModel = [[TemplateModel alloc] init];
                templatModel.templateType = dict[@"type"][@"name"];
                templatModel.templateSpecial = dict[@"termProject"][@"name"];
                templatModel.templateSampleGraphUrl = templateSampleGraphUrl;
                templatModel.templatePictureUrl = templatePictureUrl;
                templatModel.photoNum = [dict[@"maxPhotoNum"] integerValue];
                templatModel.templateImageName = name;
                templatModel.istemplateDownload = [templateOperation selectTemplateType:templatModel.templateType special:templatModel.templateSpecial imageName:templatModel.templateImageName];
                
                //图片
                NSArray *photosArrary = dict[@"photos"];
                NSMutableArray *photos = [[NSMutableArray alloc] initWithCapacity:0];
                for (NSDictionary *photoDict in photosArrary) {
                    
                    PhotoModel *photoModel = [[PhotoModel alloc] init];
                    photoModel.xCoordinatex = [photoDict[@"xCoordinatex"] floatValue];
                    photoModel.yCoordinatey = [photoDict[@"yCoordinatey"] floatValue];
                    photoModel.wide = [photoDict[@"wide"] floatValue];
                    photoModel.high = [photoDict[@"high"] floatValue];
                    photoModel.rotationAngle = [photoDict[@"rotationAngle"] floatValue];
                    [photos addObject:photoModel];
                    
                }
                
                templatModel.photos = photos;
                
                //文字
                NSArray *writtenWordsArrary = dict[@"writtenWords"];
                NSMutableArray *writtenWords = [[NSMutableArray alloc] initWithCapacity:0];
                for (NSDictionary *writtenwordsDict in writtenWordsArrary) {
                    
                    WrittenWordModel *writtenWordModel = [[WrittenWordModel alloc] init];
                    writtenWordModel.xCoordinatex = [writtenwordsDict[@"xCoordinatex"] floatValue];
                    writtenWordModel.yCoordinatey = [writtenwordsDict[@"yCoordinatey"] floatValue];
                    writtenWordModel.wide = [writtenwordsDict[@"wide"] floatValue];
                    writtenWordModel.high = [writtenwordsDict[@"high"] floatValue];
                    writtenWordModel.numMax = [writtenwordsDict[@"numMax"] integerValue];
                    writtenWordModel.fontSize = [writtenwordsDict[@"fontSize"] integerValue];
                    writtenWordModel.color = writtenwordsDict[@"color"];
                    [writtenWords addObject:writtenWordModel];
                    
                }
                
                templatModel.writtenWords = writtenWords;
                
                [templateArray addObject:templatModel];
                
            }
            
            NSDictionary *dataDict = @{@"num":key,@"content":templateArray};
            [self.dataArray addObject:dataDict];
            
        }
        
        [_tableView reloadData];
        
        [hud hideAnimated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error：%@",error);
        hud.label.text = @"网络出错";
        hud.mode = MBProgressHUDModeText;
        [hud hideAnimated:YES afterDelay:1.2];
        
    }];
   */ 
}

/*修改当前页面状态栏为白色*/
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
