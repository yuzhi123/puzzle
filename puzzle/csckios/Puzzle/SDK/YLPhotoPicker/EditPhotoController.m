//
//  EditPhotoController.m
//  TZImagePickerController
//
//  Created by yiliu on 16/6/23.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#define VIEWWIDTH self.view.frame.size.width
#define VIEWHEIGHT self.view.frame.size.height

#import "EditPhotoController.h"
#import "TZImageManager.h"

@interface EditPhotoController ()

@property (nonatomic,strong) UIView *X0;
@property (nonatomic,strong) UIView *X1;
@property (nonatomic,strong) UIView *X2;
@property (nonatomic,strong) UIView *X3;
@property (nonatomic,strong) UIView *V0;
@property (nonatomic,strong) UIView *V1;


@property (nonatomic,assign) BOOL isEdit;

@end

@implementation EditPhotoController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏导航栏
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewDidAppear:animated];
    //显示导航栏
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    
    [self addMB];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 22, 50, 40)];
    [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [closeBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:closeBtn];
    
    UIButton *useBtn = [[UIButton alloc] initWithFrame:CGRectMake(VIEWWIDTH-50, 22, 50, 40)];
    [useBtn addTarget:self action:@selector(used:) forControlEvents:UIControlEventTouchUpInside];
    useBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [useBtn setTitle:@"使用" forState:UIControlStateNormal];
    [self.view addSubview:useBtn];
    
    UIButton *cutBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, VIEWHEIGHT-40, 50, 40)];
    [cutBtn addTarget:self action:@selector(cut:) forControlEvents:UIControlEventTouchUpInside];
    cutBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cutBtn setTitle:@"原图" forState:UIControlStateNormal];
    [self.view addSubview:cutBtn];
    
    _isEdit = NO;
    [self cut:cutBtn];
}

//取消
- (void)close:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

//使用
- (void)used:(UIButton *)btn{
    
    CGRect rect;
    UIImage *image;
    
    if(!_isEdit || (_imageView.frame.size.width == VIEWWIDTH && _imageView.frame.size.height <= VIEWWIDTH)){
        
        //使用原图
        image = _imageView.image;
        
    }else{
        
        //截屏
        UIImage *captureImage = [self captureImageFromViewLow:self.view];
        
        float scale = captureImage.scale;
        
        if(_imageView.frame.size.width > VIEWWIDTH && _imageView.frame.size.height < VIEWWIDTH){
            
            rect = CGRectMake(1*scale, (VIEWHEIGHT/2-_imageView.frame.size.height/2)*scale, (VIEWWIDTH-2)*scale, _imageView.frame.size.height*scale);
            
        }else{
            
            rect = CGRectMake(1*scale, (VIEWHEIGHT/2-VIEWWIDTH/2+1)*scale, (VIEWWIDTH-2)*scale, (VIEWWIDTH-2)*scale);
            
        }
        
        //裁剪图片指定部分
        image = [self imageByCroppingWithStyle:captureImage rect:rect];
        
    }
    
    //返回
    NSInteger num = self.navigationController.viewControllers.count;
    [self.navigationController popToViewController:self.navigationController.viewControllers[num-3] animated:NO];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(editSuccess:)]){
        [self.delegate editSuccess:image];
    }
    
}

//裁剪
- (void)cut:(UIButton *)btn{
    
    if(_isEdit){
        
        _isEdit = NO;
        
        [btn setTitle:@"裁剪" forState:UIControlStateNormal];
        
        _X0.hidden = YES;
        _X1.hidden = YES;
        _X2.hidden = YES;
        _X3.hidden = YES;
        _V0.hidden = YES;
        _V1.hidden = YES;
        
        for (UIGestureRecognizer *gesture in _imageView.gestureRecognizers) {
            [_imageView removeGestureRecognizer:gesture];
        }
        
        _imageView.center = CGPointMake(VIEWWIDTH/2, VIEWHEIGHT/2);
        
    }else{
        
        _isEdit = YES;
        
        [btn setTitle:@"原图" forState:UIControlStateNormal];
        
        _X0.hidden = NO;
        _X1.hidden = NO;
        _X2.hidden = NO;
        _X3.hidden = NO;
        _V0.hidden = NO;
        _V1.hidden = NO;
        
        //拖动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        [_imageView addGestureRecognizer:pan];
        
        //缩放手势
        UIPinchGestureRecognizer *pinGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinGesture:)];
        [_imageView addGestureRecognizer:pinGesture];
    
    }
    
}

- (void)setAssetModel:(TZAssetModel *)assetModel{
    
    _assetModel = assetModel;
    
    [[TZImageManager manager] getPhotoWithAsset:assetModel.asset photoWidth:self.view.frame.size.width completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        
        self.imageView.image = photo;
        
        float wid = _imageView.image.size.width;
        float hig = _imageView.image.size.height;
        
        float bili = VIEWWIDTH/wid;
        _imageView.frame = CGRectMake(0, 0, VIEWWIDTH, hig*bili);
        
        _imageView.center = CGPointMake(VIEWWIDTH/2, VIEWHEIGHT/2);
        
    }];

}

- (void)addMB{
    
    _X0 = [[UIView alloc] initWithFrame:CGRectMake(0, VIEWHEIGHT/2-VIEWWIDTH/2, VIEWWIDTH, 1)];
    _X1 = [[UIView alloc] initWithFrame:CGRectMake(0, VIEWHEIGHT/2+VIEWWIDTH/2-1, VIEWWIDTH, 1)];
    
    _X2 = [[UIView alloc] initWithFrame:CGRectMake(0, VIEWHEIGHT/2-VIEWWIDTH/2+1, 1, VIEWWIDTH-2)];
    _X3 = [[UIView alloc] initWithFrame:CGRectMake(VIEWWIDTH-1, VIEWHEIGHT/2-VIEWWIDTH/2+1, 1, VIEWWIDTH-2)];
    
    _X0.backgroundColor = [UIColor whiteColor];
    _X1.backgroundColor = [UIColor whiteColor];
    _X2.backgroundColor = [UIColor whiteColor];
    _X3.backgroundColor = [UIColor whiteColor];
    
    _X0.alpha = 0.4;
    _X1.alpha = 0.4;
    _X2.alpha = 0.4;
    _X3.alpha = 0.4;
    
    [self.view addSubview:_X0];
    [self.view addSubview:_X1];
    [self.view addSubview:_X2];
    [self.view addSubview:_X3];
    
    
    _V0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEWWIDTH, VIEWHEIGHT/2-VIEWWIDTH/2)];
    _V1 = [[UIView alloc] initWithFrame:CGRectMake(0, VIEWHEIGHT/2+VIEWWIDTH/2, VIEWWIDTH, VIEWHEIGHT/2-VIEWWIDTH/2)];
    
    _V0.backgroundColor = [UIColor blackColor];
    _V1.backgroundColor = [UIColor blackColor];
    
    _V0.alpha = 0.6;
    _V1.alpha = 0.6;
    
    [self.view addSubview:_V0];
    [self.view addSubview:_V1];
    
    _X0.hidden = YES;
    _X1.hidden = YES;
    _X2.hidden = YES;
    _X3.hidden = YES;
    _V0.hidden = YES;
    _V1.hidden = YES;
    
}

#pragma -mark 拖动手势
- (void)panGesture:(UIPanGestureRecognizer *)recognizer{
    
    CGPoint center = recognizer.view.center;
    CGPoint translation = [recognizer translationInView:self.view];
    //NSLog(@"%@", NSStringFromCGPoint(translation));
    recognizer.view.center = CGPointMake(center.x + translation.x, center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        //计算速度向量的长度，当他小于200时，滑行会很短
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        //NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult); //e.g. 397.973175, slideMult: 1.989866
        
        //基于速度和速度因素计算一个终点
        float slideFactor = 0.1 * slideMult;
        CGPoint finalPoint = CGPointMake(center.x + (velocity.x * slideFactor), center.y + (velocity.y * slideFactor));
        
        //限制最小［cornerRadius］和最大边界值［self.view.bounds.size.width - cornerRadius］，以免拖动出屏幕界限
        finalPoint.x = MIN(MAX(finalPoint.x, VIEWWIDTH - recognizer.view.frame.size.width / 2),  recognizer.view.frame.size.width / 2);
        
        if(_imageView.frame.size.height < VIEWWIDTH){
            finalPoint.y = self.view.center.y;
        }else{
            finalPoint.y = MIN(MAX(finalPoint.y, (VIEWWIDTH + VIEWHEIGHT - recognizer.view.frame.size.height)/2), (VIEWHEIGHT-VIEWWIDTH+recognizer.view.frame.size.height)/2);
        }
        
        //使用 UIView 动画使 view 滑行到终点
        [UIView animateWithDuration:0.4
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             recognizer.view.center = finalPoint;
                         }
                         completion:nil];
    }
    
}

#pragma -mark 缩放手势
- (void)pinGesture:(UIPinchGestureRecognizer *)recognizer{
    
    if (recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateChanged) {
        
        _imageView.transform = CGAffineTransformScale(_imageView.transform, recognizer.scale, recognizer.scale);
        recognizer.scale = 1;
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if(_imageView.frame.size.width < VIEWWIDTH){
            
            //使用 UIView 动画使 view 滑行到终点
            [UIView animateWithDuration:0.4
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 
                                 float bili = VIEWWIDTH/_imageView.image.size.width;
                                 CGRect frame = _imageView.frame;
                                 frame.size.width = VIEWWIDTH;
                                 frame.size.height = _imageView.image.size.height*bili;
                                 _imageView.frame = frame;
                                 _imageView.center = CGPointMake(VIEWWIDTH/2, VIEWHEIGHT/2);
                                 
                             }
                             completion:nil];
            
        }
        
    }
    
}

//获取指定View的图片
-(UIImage *)captureImageFromViewLow:(UIView *)orgView{
    UIGraphicsBeginImageContextWithOptions(orgView.bounds.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [orgView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//裁剪图片指定部分
- (UIImage *)imageByCroppingWithStyle:(UIImage *)image rect:(CGRect)rect{
    CGImageRef imageRef = image.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *cropImage = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    
    //保存图片到相册
    //UIImageWriteToSavedPhotosAlbum(cropImage, NULL, NULL, NULL);
    
    return cropImage;
}

/*修改当前页面状态栏为白色*/
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
