//
//  MaterialDetailsController.m
//  Puzzle
//
//  Created by yiliu on 16/9/5.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "MaterialDetailsController.h"
#import "MaterialDetailsCell.h"

#import "UIImageView+WebCache.h"

#import "TemplateModel.h"
#import "ImagesDownloadQueue.h"

#import "DownTempeBtn.h"


@interface MaterialDetailsController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,ImagesDownloadQueueDelegate>

//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

//比例
@property (weak, nonatomic) IBOutlet UILabel *proportionLabel;

//滚动视图
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//下载按钮
@property (weak, nonatomic) IBOutlet DownTempeBtn *downloadBtn;

@end

@implementation MaterialDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    TemplateModel *templateModel = _dataArray[_proportionIndex];
    [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:templateModel.templateSampleGraphUrl] placeholderImage:PlaceholderImage];
    
    if (templateModel.istemplateDownload) {
        [_downloadBtn setTitle:@"已下载" forState:UIControlStateNormal];
    }else if (templateModel.isDownloading) {
        [_downloadBtn setTitle:@"下载中" forState:UIControlStateNormal];
    }else {
        [_downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    }
    
    if (_isUnlock == NO) {
        _downloadBtn.hidden = YES;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // 更新界面
        _proportionLabel.text = [NSString stringWithFormat:@"%tu/%tu",_proportionIndex+1,_dataArray.count];
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_proportionIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        
    });

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

//设定全局的Cell尺寸，如果想要单独定义某个Cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(WIDE, _collectionView.bounds.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MaterialDetailsCell *cell = (MaterialDetailsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MaterialDetailsCell" forIndexPath:indexPath];
    
    TemplateModel *templateModel = _dataArray[indexPath.row];
    [cell.materialImageView sd_setImageWithURL:[NSURL URLWithString:templateModel.templateSampleGraphUrl] placeholderImage:PlaceholderImage];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    _proportionIndex = (scrollView.contentOffset.x + _collectionView.bounds.size.width * 0.5) / _collectionView.bounds.size.width;
    _proportionLabel.text = [NSString stringWithFormat:@"%tu/%tu",_proportionIndex+1,_dataArray.count];
    _backgroundImageView.image = [UIImage imageNamed:@"bk_shiyi"];
    
    TemplateModel *templateModel = _dataArray[_proportionIndex];
    
    if (templateModel.istemplateDownload || templateModel.isDownloading) {
        [_downloadBtn setTitle:@"已下载" forState:UIControlStateNormal];
    }else {
        [_downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    }
    
    if (templateModel.isDownloading) {
        _downloadBtn.hideProgress = NO;
    }else {
        _downloadBtn.hideProgress = YES;
    }
    
    [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:templateModel.templateSampleGraphUrl] placeholderImage:PlaceholderImage];
    
}

//上一页
- (IBAction)previousPage:(id)sender {
    
    if (_proportionIndex > 0) {
        
        _proportionIndex--;
        
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_proportionIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        
        TemplateModel *templateModel = _dataArray[_proportionIndex];
        if (templateModel.isDownloading) {
            _downloadBtn.hideProgress = NO;
        }else {
            _downloadBtn.hideProgress = YES;
        }
        
    }
    
}

//下一页
- (IBAction)nextPage:(id)sender {
    
    if (_proportionIndex < _dataArray.count-1) {
        
        _proportionIndex++;
        
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_proportionIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        
        TemplateModel *templateModel = _dataArray[_proportionIndex];
        if (templateModel.isDownloading) {
            _downloadBtn.hideProgress = NO;
        }else {
            _downloadBtn.hideProgress = YES;
        }
        
    }
    
}

//下载
- (IBAction)downloadPictures:(id)sender {
    
    TemplateModel *templateModel = _dataArray[_proportionIndex];
    _downloadBtn.hideProgress = NO;
    
    if (!templateModel.istemplateDownload && !templateModel.isDownloading) {
        
        [_downloadBtn setTitle:@"下载中" forState:UIControlStateNormal];
        
        templateModel.isDownloading = YES;
        
        NSDictionary *dict = @{@"TemplateModel":templateModel,
                               @"section":[NSString stringWithFormat:@"%tu",_section],
                               @"index":[NSString stringWithFormat:@"%tu",_proportionIndex]};
        
        [ImagesDownloadQueue CreateDownloadQueueManager].delegate = self;
        [[ImagesDownloadQueue CreateDownloadQueueManager] downloadImage:dict];
        
    }
    
}

#pragma -mark ImagesDownloadQueueDelegate 下载回调
- (void)downProgress:(NSDictionary *)dict {
    
    TemplateModel *templateModel = dict[@"TemplateModel"];
    
    TemplateModel *templateModel1 = _dataArray[_proportionIndex];
    _downloadBtn.progress = templateModel.downloadProgress;
    
    if ([templateModel.templateImageName isEqual:templateModel1.templateImageName] && templateModel.istemplateDownload) {
        
        [_downloadBtn setTitle:@"已下载" forState:UIControlStateNormal];
        _downloadBtn.hideProgress = YES;
        _downloadBtn.progress = 0;
        
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(downSuccess:)]) {
        [self.delegate downSuccess:dict];
    }
    
}

/** 下载失败 */
- (void)downFail:(NSDictionary *)dict {
    
    [_downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    _downloadBtn.hideProgress = YES;
    _downloadBtn.progress = 0;
    
}


//返回
- (IBAction)retunView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
