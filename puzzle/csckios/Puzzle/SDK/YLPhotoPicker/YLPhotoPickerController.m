//
//  YLPhotoPickerController.m
//  TZImagePickerController
//
//  Created by yiliu on 16/6/23.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "YLPhotoPickerController.h"
#import "YLAssetCell.h"
#import "TZImageManager.h"
#import "TZAssetModel.h"
#import "PuzzleController.h"
#import "MBProgressHUD.h"

#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface YLPhotoPickerController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray   *photosArry;
@property (nonatomic,strong) NSMutableArray   *copyphotosArry;

@property (nonatomic,strong) NSMutableDictionary   *selectPhotosDict;
@property (nonatomic, strong) NSTimer *observeTimer;
@end

@implementation YLPhotoPickerController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_isPrint) {
        self.navigationController.navigationBarHidden = NO;//详情页把导航隐藏了 手动调出来
    }
    
    _observeTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkPhotoAuthor) userInfo:nil repeats:YES];
    
    [self reloadPhotoArray];
    
  
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_isPrint) {
        self.navigationController.navigationBarHidden = YES;//详情页把导航隐藏了 手动藏回去
    }
    [_observeTimer invalidate];
}


- (void) checkPhotoAuthor {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
        switch (photoAuthorStatus) {
            case PHAuthorizationStatusAuthorized: {
                [self reloadPhotoArray];
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
                [self reloadPhotoArray];
                [_observeTimer invalidate];
            } break;
            case ALAuthorizationStatusDenied: NSLog(@"Denied"); break;
            case ALAuthorizationStatusNotDetermined: NSLog(@"not Determined"); break;
            case ALAuthorizationStatusRestricted: NSLog(@"Restricted"); break; default: break;
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self initNavigation];
    [self initView];
    
}

//初始化导航栏右侧按钮
-(void)initNavigation{
    
    if (_isPrint) {
        self.title = @"选择照片";
    }else{
        self.title = @"模板大师";
    }

    //文字故意加空格使得按钮往左移动 勿删
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定  " style:UIBarButtonItemStyleDone target:self action:@selector(determine)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
}

/**初始化页面的信息*/
-(void)initView{

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    if(![[TZImageManager manager] authorizationStatusAuthorized]){
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"无法访问相册.请在'设置->此时此刻->照片'设置为打开状态." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return;
    }
    
}

//确定选择
- (void)determine{
    
    if (self.selectPhotosDict.count < 1) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择至少1张照片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return;
    }
    
    NSArray *imagesArray = [self.selectPhotosDict allValues];
    if (_isPrint) {
        
        [self.navigationController popViewControllerAnimated:NO];
        if(self.dataSource && [self.dataSource respondsToSelector:@selector(completeSelection:)]){
            [self.dataSource completeSelection:imagesArray];
        }
        
    }else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PuzzleController *puzzle = [storyboard instantiateViewControllerWithIdentifier:@"Puzzle"];
        puzzle.imageArray = imagesArray;
        [self.navigationController pushViewController:puzzle animated:YES];
    }    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)reloadPhotoArray {
    
    [self.photosArry removeAllObjects];
    
    [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
        
        [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
            
            for (TZAssetModel *assetModel in models) {
                [self.photosArry addObject:assetModel];
            }
            
            [_collectionView reloadData];
            
        }];
        
    }];
    
}

#pragma -mark UICollectionViewDelegate UICollectionViewDataSource
//返回指定区(section)包含的数据源条目数(number of items)，该方法必须实现：
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.navigationController.navigationItem.rightBarButtonItem.title = [NSString stringWithFormat:@"确定(%ld)", (long)self.selectPhotosDict.count];
    return self.photosArry.count;
}

//设定全局的Cell尺寸，如果想要单独定义某个Cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.view.frame.size.width-15)/4, (self.view.frame.size.width-15)/4);
}

//返回某个indexPath对应的cell，该方法必须实现：
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    YLAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YLAssetCell" forIndexPath:indexPath];
    
    TZAssetModel *assetModel = self.photosArry[indexPath.row];
    if ([self.copyphotosArry containsObject:assetModel.asset]) {
        assetModel.isSelected = true;
    }
    
    cell.assetModel = assetModel;
    
    return cell;
}

//点击某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(_isMultiselect){
        
        TZAssetModel *assetModel = self.photosArry[indexPath.row];
        
        if (assetModel.isSelected) {
            
            assetModel.isSelected = NO;
            [self.selectPhotosDict removeObjectForKey:[NSString stringWithFormat:@"%tu",indexPath.row]];
            [self.copyphotosArry removeObject:assetModel.asset];
        }else{
            
            if (self.selectPhotosDict.count == 10 && _isPrint) {
            
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"最多只能选择10张照片哦";
                [hud hideAnimated:YES afterDelay:1];
                
                return;
                
            }else if(self.selectPhotosDict.count == 4 && !_isPrint){
            
                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"最多只能选择4张照片哦";
                [hud hideAnimated:YES afterDelay:1];
                
                return;
                
                
            } else {
                
                assetModel.isSelected = YES;
                [self.copyphotosArry addObject:assetModel.asset];
                TZAssetModel *assetModel = self.photosArry[indexPath.row];
                [[TZImageManager manager] getPhotoWithAsset:assetModel.asset photoWidth:700 completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                    [self.selectPhotosDict setObject:photo forKey:[NSString stringWithFormat:@"%tu",indexPath.row]];
                }];
                
            }
            
        }
        
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        
    }else{
        
        TZAssetModel *assetModel = self.photosArry[indexPath.row];
        EditPhotoController *edit = [[EditPhotoController alloc] init];
        edit.delegate = _delegate;
        edit.assetModel = assetModel;
        [self.navigationController pushViewController:edit animated:YES];
        
    }
 }


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 3;
        flowLayout.minimumLineSpacing = 3;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(3, 3, self.view.frame.size.width-6, self.view.frame.size.height-6) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[YLAssetCell class] forCellWithReuseIdentifier:@"YLAssetCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSMutableArray *)photosArry{
    if (!_photosArry) {
        _photosArry = [[NSMutableArray alloc] init];
    }
    return _photosArry;
}
    
- (NSMutableArray *)copyphotosArry{
    if (!_copyphotosArry) {
        _copyphotosArry = [[NSMutableArray alloc] init];
    }
    return _copyphotosArry;
}

- (NSMutableDictionary *)selectPhotosDict{
    if (!_selectPhotosDict) {
        _selectPhotosDict = [[NSMutableDictionary alloc] init];
    }
    return _selectPhotosDict;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
