//
//  MaterialTypeListController.m
//  Puzzle
//
//  Created by yiliu on 16/9/5.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "MaterialTypeListController.h"
#import "MaterialTypeHotCell.h"
#import "MaterialTypeCell.h"
#import "MaterialListController.h"
#import "MaterialDetailsController.h"
#import "TemplateOperation.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"

#import "TemplateModel.h"
#import "PhotoModel.h"
#import "WrittenWordModel.h"
#import "TemplateTypeData.h"
#import "TemplateTermModel.h"


#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface MaterialTypeListController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSInteger shareNum;
    
    TemplateTypeData *templateTypeData;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong) NSTimer *observeTimer;


@property (nonatomic, strong) UITableView *hotTableView;

@property (nonatomic, strong) NSMutableArray *hotArray;

@end

@implementation MaterialTypeListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view sendSubviewToBack:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    templateTypeData = [TemplateTypeData CreateTemplateTypeData];
    
    //注册 刷新数据的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTemplate:) name:@"RefreshTemplate" object:nil];

    
    _observeTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkPhotoAuthor) userInfo:nil repeats:YES];
    
}

- (void) checkPhotoAuthor {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
        switch (photoAuthorStatus) {
            case PHAuthorizationStatusAuthorized: {
                [self getPOST];
                [_observeTimer invalidate];
            } break;
            case PHAuthorizationStatusDenied: NSLog(@"Denied"); break;
            case PHAuthorizationStatusNotDetermined: NSLog(@"not Determined"); break;
            case PHAuthorizationStatusRestricted: NSLog(@"Restricted"); break; default: break;
        }
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0){
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        switch (status) {
            case ALAuthorizationStatusAuthorized: {
                [self getPOST];
                [_observeTimer invalidate];
            } break;
            case ALAuthorizationStatusDenied: NSLog(@"Denied"); break;
            case ALAuthorizationStatusNotDetermined: NSLog(@"not Determined"); break;
            case ALAuthorizationStatusRestricted: NSLog(@"Restricted"); break; default: break;
        }
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self getPOST];
}


//刷新数据
- (void)refreshTemplate:(NSNotification*)notification{
    [self getPOST];
}

//首页
//- (IBAction)home:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//}

//表格头
- (UIView *)loadHeadView{
    
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDE, 200)];
    headView.backgroundColor = [UIColor clearColor];
    headView.contentMode = UIViewContentModeScaleAspectFill;
    headView.clipsToBounds = YES;
    headView.userInteractionEnabled = YES;
    
    TemplateModel *templateModel = _hotArray[0];
    [headView sd_setImageWithURL:[NSURL URLWithString:templateModel.templateSampleGraphUrl] placeholderImage:PlaceholderImage];
    
    UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    visualEffect.frame = headView.bounds;
    [headView addSubview:visualEffect];
    
    UIView *bkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDE, 200)];
    bkView.backgroundColor = [UIColor whiteColor];
    bkView.alpha = 0.5;
    [headView addSubview:bkView];
    
    [headView addSubview:self.hotTableView];
    
    return headView;
    
}

#pragma -mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _hotTableView) {
        return _hotArray.count;
    }
    return templateTypeData.templateTerms.count;
}

//设置分区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == _hotTableView) {
        return nil;
    }
    
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDE, 30)];
    headView.backgroundColor = [UIColor clearColor];
    headView.contentMode = UIViewContentModeScaleAspectFill;
    headView.clipsToBounds = YES;
    headView.image = [UIImage imageNamed:@"beijignsection"];
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDE, 30)];
    headLabel.font = [UIFont systemFontOfSize:15];
    headLabel.textColor = [UIColor whiteColor];
    headLabel.text = @"  专题";
    [headView addSubview:headLabel];
    
    return headView;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    if (tableView == _hotTableView) {
        UIView *viv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 5)];
        viv.backgroundColor = [UIColor clearColor];
        return viv;
    }
    return nil;
    
}

//设置分区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _hotTableView) {
        return 0.00000001;
    }
    return 30;
}

//设置分区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _hotTableView) {
        return 90;
    }
    return 120;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _hotTableView) {
        
        static NSString *reuseIdetify = @"MaterialTypeHotCell";
        MaterialTypeHotCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (!cell) {
            cell = [[MaterialTypeHotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
            cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        TemplateModel *templateModel = _hotArray[indexPath.row];
        [cell.materialImageView sd_setImageWithURL:[NSURL URLWithString:templateModel.templateSampleGraphUrl] placeholderImage:PlaceholderImage];
        
        return cell;
        
    }else {
        
        static NSString *reuseIdetify = @"MaterialTypeCell";
        MaterialTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (!cell) {
            cell = [[MaterialTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            [cell.lockView.shareBtn addTarget:self action:@selector(puzzle:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if (indexPath.row % 2 == 0) {
            cell.bkView.hidden = NO;
        }else {
            cell.bkView.hidden = YES;
        }
        
        TemplateTermModel *templateTermModel = templateTypeData.templateTerms[indexPath.row];
        
        NSString *termUrl = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,templateTermModel.termImageUrl];
        
        cell.titleLabel.text = [NSString stringWithFormat:@"%@(%tu)",templateTermModel.termName,templateTermModel.termNumber];
        [cell.bkImageView  sd_setImageWithURL:[NSURL URLWithString:termUrl] placeholderImage:PlaceholderImage];
        [cell.materialImageView  sd_setImageWithURL:[NSURL URLWithString:termUrl] placeholderImage:PlaceholderImage];
        
//        //是否已解锁
//        if (templateTermModel.isUnlock) {
//            
//            cell.lockView.hidden = YES;
//            
//        }else {
//            
//            cell.lockView.hidden = NO;
//            cell.lockView.shareNum = templateTermModel.shareNumUnlock;
//            
//        }
        
//        无论是否解锁 都不显示锁了
        cell.lockView.hidden = YES;

        return cell;
        
    }
    
}

#pragma -mark  选中cell后，cell颜色变化
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _hotTableView) {
        
        // 获取指定的Storyboard，name填写Storyboard的文件名
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
        MaterialDetailsController *materialDetails = [storyboard instantiateViewControllerWithIdentifier:@"MaterialDetails"];
        materialDetails.dataArray = _hotArray;
        materialDetails.proportionIndex = indexPath.row;
        materialDetails.section = 0;
        materialDetails.isUnlock = YES;
        [self.navigationController pushViewController:materialDetails animated:YES];
        
    }else {
        
        // 获取指定的Storyboard，name填写Storyboard的文件名
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
        MaterialListController *materialList = [storyboard instantiateViewControllerWithIdentifier:@"MaterialList"];
        
        TemplateTermModel *templateTermModel = templateTypeData.templateTerms[indexPath.row];
        materialList.title = templateTermModel.termName;
        materialList.selectType = @"专题";
        materialList.selectId = templateTermModel.termId;
//        materialList.isUnlock = templateTermModel.isUnlock;
//        无论是否解锁 都解锁
        materialList.isUnlock = YES;

        
        [self.navigationController pushViewController:materialList animated:YES];
        
    }
    
}

//去拼图
- (void)puzzle:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(openPuzzleView)]) {
        [self.delegate openPuzzleView];
    }
    
}

//网络请求
- (void)getPOST {
    /*
    //获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置超时时间
    manager.requestSerializer.timeoutInterval = 30;
    
    NSString *url = [NSString stringWithFormat:@"%@templet/hot",POSTURL];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *hotAry = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"hotArray：%@",hotAry);
        
        [self.hotArray removeAllObjects];
        
        for (NSDictionary *dict in hotAry) {
            
            //示例图地址
            NSString *templateSampleGraphUrl = [NSString stringWithFormat:@"%@%@",TEMPLATEDOWNURL,dict[@"sampleGraphUrl"]];
            //下载地址
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
            
            [self.hotArray addObject:templatModel];
            
        }
        
        if (self.hotArray.count > 0) {
            _tableView.tableHeaderView = [self loadHeadView];
        }
        
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"error：%@",error);
            
    }];
    
    
    //获得请求管理者
    AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
    manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置超时时间
    manager1.requestSerializer.timeoutInterval = 30;
    
    NSString *url1 = [NSString stringWithFormat:@"%@templet/typeAndTerm/count",POSTURL];
    
    [manager1 GET:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"typeArray：%@",dict);
        
        //分享次数
        shareNum = 0;
        NSString *shareNumStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"ShareNum"];
        if (shareNumStr) {
            shareNum = [shareNumStr integerValue];
        }
        
        //专题
        NSDictionary *termDict = dict[@"term"];
        
        //专题
        for (TemplateTermModel *templateTermModel in templateTypeData.templateTerms) {
            
            NSString *termId = [NSString stringWithFormat:@"%tu",templateTermModel.termId];
            templateTermModel.termNumber = [termDict[termId] integerValue];
            
            if (templateTermModel.shareNumUnlock <= shareNum) {
                
                templateTermModel.isUnlock = YES;
                
            }
            
        }
        
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error：%@",error);
        
    }];
    */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)hotTableView{
    if (!_hotTableView) {
        _hotTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, 120, WIDE)];
        _hotTableView.center = CGPointMake(WIDE/2, 115);
        _hotTableView.showsVerticalScrollIndicator = NO;
        _hotTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _hotTableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        _hotTableView.pagingEnabled = NO;
        _hotTableView.backgroundColor = [UIColor clearColor];
        _hotTableView.tableFooterView = [[UIView alloc] init];
        _hotTableView.delegate = self;
        _hotTableView.dataSource = self;
    }
    return _hotTableView;
}

- (NSMutableArray *)hotArray {
    if (!_hotArray) {
        _hotArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _hotArray;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
