//
//  PuzzleController.m
//  Puzzle
//
//  Created by yiliu on 16/8/29.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "PuzzleController.h"
#import "YLPhotoPickerController.h"
#import "TemplateListView.h"
#import "PictureEditView.h"
#import "TemplateTypeView.h"
#import "SidebarView.h"
#import "ShareController.h"
#import "YLEditTextView.h"
#import "YLDottedLineLabel.h"
#import "YLFontTypeView.h"
#import "SpecialEffectsView.h"

#import "TemplateOperation.h"
#import "TemplateModel.h"
#import "PhotoModel.h"
#import "WrittenWordModel.h"
#import "TemplateTypeData.h"
#import "TemplateTermModel.h"

#import "Auxiliary.h"


#import "IQKeyboardManager.h"

@interface PuzzleController ()<EditPhotoDelegate,TemplateListDelegate,TemplateTypeDelegate,SidebarDelegate,YLEditTextViewDelegate,YLFontTypeViewDelegate,SpecialEffectsDelegate>{
    
    NSInteger selectTemplateTypeIndex;   //选中的模板类型
    NSInteger selectTemplateIndex;       //选中的模板
    
    NSInteger useTemplateTypeIndex;      //记录当前使用的模板的类型
    NSInteger useSelectImageIndex;       //记录当前选中要编辑的图片
    
    CGPoint   longPressPoint;            //长按按到的坐标
    
    NSInteger selectYLDottedLineLabel;   //正在编辑的文字框
    
    NSTimer   *timer; //定时器（隐藏文字边框）
    
}

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (strong, nonatomic) YLFontTypeView        *fontTypeView;
@property (strong, nonatomic) YLEditTextView        *editTextView;
@property (strong, nonatomic) TemplateListView      *templateListView;
@property (strong, nonatomic) TemplateTypeView      *templateTypeView;
@property (strong, nonatomic) SidebarView           *sidebarView;
@property (strong, nonatomic) SpecialEffectsView    *specialEffectsView;
@property (strong, nonatomic) NSMutableArray        *templateArray;

@end

@implementation PuzzleController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    
    self.navigationController.navigationBarHidden = YES;
    
    [self hideWrittenWords];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;//进入分享页面隐藏了原有的导航栏 所以关闭页面要显示出来
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //键盘的frame发生改变时发出的通知（位置和尺寸）
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //给背景模板添加单击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundtapGesture:)];
    [_backgroundView addGestureRecognizer:tapGesture];
    
    _backgroundView.layer.masksToBounds = YES;
    
    //加载模板列表view
    [self.view addSubview:self.templateListView];
    
    //加载模板类型
    [self.view addSubview:self.templateTypeView];
    
    TemplateTypeData *templateTypeData = [TemplateTypeData CreateTemplateTypeData];
    NSMutableArray *typeArray = [[NSMutableArray alloc] init];
    for (TemplateTermModel *templateTermModel in templateTypeData.templateTerms) {
        [typeArray addObject:templateTermModel.termName];
    }
    self.templateTypeView.typesArray = typeArray;
    
    //加载侧边栏
    [self.view addSubview:self.sidebarView];
    
    //选中的模板
    selectTemplateIndex = 0;
    
    //正在编辑的文字框
    selectYLDottedLineLabel = 9999;
    
    //默认模板类型
    selectTemplateTypeIndex = 0;
    
    //加载模板列表数据
    [self switchTemplate];
    
    TemplateModel *templateModel;
    for (NSArray *templateAry in self.templateArray) {
        if (templateAry.count > 0) {
            templateModel = (TemplateModel *)templateAry[selectTemplateIndex];
            selectTemplateTypeIndex++;
            break;
        }
    }
    
    //默认选中的模板的类型
    useTemplateTypeIndex = selectTemplateTypeIndex;
    
    //切换选择的专题
    self.templateTypeView.selectIndex = selectTemplateTypeIndex;
    
    NSArray *photosArray = templateModel.photos;
    NSArray *writtenWordsArray = templateModel.writtenWords;
    
    //加载默认模板
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@",TEMPLATEPATH,templateModel.templateImageName];
    _backgroundImageView.image = [UIImage imageWithContentsOfFile:imagePath];

    //加载图片
    [self loadImageView:photosArray];
    
    //加载文字框
    [self loadWrittenWords:writtenWordsArray];
    
}

- (void)hideWrittenWords {
    
    for (UIView *viv in [_backgroundView subviews]) {
        
        if ([viv isKindOfClass:[YLDottedLineLabel class]]) {
            
            //隐藏文字虚线边框
            YLDottedLineLabel *yldottedline = (YLDottedLineLabel *)viv;
            
            [yldottedline displayHideLayer];
            
        }
        
    }
    
}

- (void)switchTemplate:(TemplateModel *)templateModel {
    
    NSArray *photosArray = templateModel.photos;
    NSArray *writtenWordsArray = templateModel.writtenWords;
    
    for (UIView *viv in [_backgroundView subviews]) {
        
        if ([viv isKindOfClass:[PictureEditView class]] || [viv isKindOfClass:[YLDottedLineLabel class]]) {
            [viv removeFromSuperview];
        }
        
    }
    
    //加载图片
    [self loadImageView:photosArray];
    
    //加载文字框
    [self loadWrittenWords:writtenWordsArray];
    
    //隐藏所有菜单
    [self backGroundtapGesture:nil];
    
}

//加载图片
- (void)loadImageView:(NSArray *)photosArray {
    
    float proportion = (WIDE-60) / 1500;
    
    for (int i = 0; i < _imageArray.count; i++) {
        
        PhotoModel *photoModel = (PhotoModel *)photosArray[i];
        
        PictureEditView *pictureEdit = [[PictureEditView alloc] init];
        pictureEdit.tag = 1000+i;
        pictureEdit.editImageView.tag = 10000+i;
        pictureEdit.editImageView.image = _imageArray[i];
        pictureEdit.originalImage = _imageArray[i];
        [pictureEdit reloadViewFrame:CGRectMake(photoModel.xCoordinatex*proportion, photoModel.yCoordinatey*proportion, photoModel.wide*proportion, photoModel.high*proportion)];
        [_backgroundView addSubview:pictureEdit];
        
        //旋转
        pictureEdit.transform = CGAffineTransformMakeRotation(photoModel.rotationAngle/180*M_PI);
        
        [_backgroundView sendSubviewToBack:pictureEdit];

        //拖动手势
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        panGesture.minimumNumberOfTouches = 1;
        panGesture.maximumNumberOfTouches = 1;
        [pictureEdit.editImageView addGestureRecognizer:panGesture];
        
        //长按手势
        UILongPressGestureRecognizer *longGestrue = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGestre:)];
        longGestrue.minimumPressDuration = 0.5;
        [pictureEdit addGestureRecognizer:longGestrue];
        
        //单击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [pictureEdit addGestureRecognizer:tapGesture];
        
    }
    
}

//加载文字框
- (void)loadWrittenWords:(NSArray *)writtenWordsArray {
    
    float proportion = (WIDE-60) / 1500;

    for (int i = 0; i < writtenWordsArray.count; i++) {
        
        WrittenWordModel *writtenWordModel = (WrittenWordModel *)writtenWordsArray[i];
        
        YLDottedLineLabel *yldottedline = [[YLDottedLineLabel alloc] init];
        [yldottedline reloadViewFrame:CGRectMake(writtenWordModel.xCoordinatex*proportion, writtenWordModel.yCoordinatey*proportion, writtenWordModel.wide*proportion, writtenWordModel.high*proportion)];
        yldottedline.tag = 100000+i;
        yldottedline.font = [UIFont systemFontOfSize:writtenWordModel.fontSize*proportion];
        yldottedline.textColor = [Auxiliary getColor:writtenWordModel.color];
        yldottedline.text = @"KUMAN";
        [_backgroundView addSubview:yldottedline];
        
        //单击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yldottedlineTapGesture:)];
        [yldottedline addGestureRecognizer:tapGesture];
        
        [yldottedline displayHideLayer];
        
    }
}

//获取模板数据
- (void)switchTemplate{
    
    [self.templateArray removeAllObjects];
    
    TemplateOperation *templateOperation = [[TemplateOperation alloc] init];
    
    for (NSString *termName in self.templateTypeView.typesArray) {
        NSArray *ary = [templateOperation selectTemplateTermData:termName photoNum:_imageArray.count];
        [self.templateArray addObject:ary];
    }
    
    //切换模板列表模板
    _templateListView.dataArray = self.templateArray[selectTemplateTypeIndex];

}

//修改图片层关系
- (void)modifyViewLayerRelationship {
    
    for (NSInteger i = 0; i < _imageArray.count; i++) {
        
        //让该放在下面的放在最下面
        PictureEditView *pictureEdit = (PictureEditView *)[self.view viewWithTag:1000+i];
        [_backgroundView sendSubviewToBack:pictureEdit];
        
    }
    
}

//背景模板的单击手势/隐藏图片编辑按钮
- (void)backGroundtapGesture:(UITapGestureRecognizer *)tap{
    
    //隐藏滤镜
    if (!_specialEffectsView.hidden) {
        _specialEffectsView.hidden = YES;
    }
    
    //隐藏文字编辑
    if (self.editTextView.frame.origin.y < HIGH) {
        [self.editTextView.contentField resignFirstResponder];
    }
    
    //隐藏文字虚线边框
    for (UIView *viv in [_backgroundView subviews]) {
        
        if ([viv isKindOfClass:[YLDottedLineLabel class]]) {
            
            //隐藏文字虚线边框
            YLDottedLineLabel *yldottedline = (YLDottedLineLabel *)viv;
            
            [yldottedline hideLayer];
            
        }
        
    }
    
    //隐藏图片边框
    for (int i=0; i<_imageArray.count; i++) {
        
        PictureEditView *pictureEdit = (PictureEditView *)[self.view viewWithTag:1000+i];
        
        pictureEdit.layer.borderWidth = 0;
        
    }
    
    if (self.fontTypeView.frame.origin.y < HIGH) {
        
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect = self.fontTypeView.frame;
            rect.origin.y = HIGH;
            self.fontTypeView.frame = rect;
            
            CGRect rect1 = self.editTextView.frame;
            rect1.origin.y = HIGH;
            self.editTextView.frame = rect1;
        }];
    }
    
    if (self.sidebarView.hidden == YES) {
        return;
    }
    
    //如果切换图片菜单存在就隐藏
    if (!self.sidebarView.hidden) {
        
        [UIView animateWithDuration:0.4 animations:^{
            
            CGRect rect = self.sidebarView.frame;
            rect.origin.x += 40;
            self.sidebarView.frame = rect;
            
        } completion:^(BOOL finished) {
            
            self.sidebarView.hidden = YES;
            
        }];
        
    }
    
}

//单击出现滤镜
- (void)tapGesture:(UITapGestureRecognizer *)gesture{
    
    //隐藏文字编辑
    if (self.editTextView.frame.origin.y < HIGH) {
        [self.editTextView.contentField resignFirstResponder];
    }
    
    //隐藏文字虚线边框
    for (UIView *viv in [_backgroundView subviews]) {
        
        if ([viv isKindOfClass:[YLDottedLineLabel class]]) {
            
            //隐藏文字虚线边框
            YLDottedLineLabel *yldottedline = (YLDottedLineLabel *)viv;
            
            [yldottedline hideLayer];
            
        }
        
    }
    
    //隐藏切换图片菜单
    if (self.fontTypeView.frame.origin.y < HIGH) {
        
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect = self.fontTypeView.frame;
            rect.origin.y = HIGH;
            self.fontTypeView.frame = rect;
            
            CGRect rect1 = self.editTextView.frame;
            rect1.origin.y = HIGH;
            self.editTextView.frame = rect1;
        }];
    }
    
    //如果切换图片菜单存在就隐藏
    if (!self.sidebarView.hidden) {
        [UIView animateWithDuration:0.4 animations:^{
            
            CGRect rect = self.sidebarView.frame;
            rect.origin.x += 40;
            self.sidebarView.frame = rect;
            
        } completion:^(BOOL finished) {
            
            self.sidebarView.hidden = YES;
            
        }];
    }
    
    
    //如果滤镜菜单显示并点击的同一个图片则隐藏
    if (!self.specialEffectsView.hidden && useSelectImageIndex == gesture.view.tag) {
        self.specialEffectsView.hidden = YES;
        
        for (int i=0; i<_imageArray.count; i++) {
            
            PictureEditView *pictureEdit = (PictureEditView *)[self.view viewWithTag:1000+i];
            pictureEdit.layer.borderWidth = 0;
            
        }
        
        return;
    }
    
    //把选中的图片圈起来
    for (int i=0; i<_imageArray.count; i++) {
        
        PictureEditView *pictureEdit = (PictureEditView *)[self.view viewWithTag:1000+i];
        
        if (pictureEdit.tag == gesture.view.tag) {
            pictureEdit.layer.borderWidth = 1;
            pictureEdit.layer.borderColor = [UIColor redColor].CGColor;
        }else{
            pictureEdit.layer.borderWidth = 0;
        }
        
    }
    
    useSelectImageIndex = gesture.view.tag;
    
    //设置滤镜的原图
    PictureEditView *pictureEdit = (PictureEditView *)[self.view viewWithTag:useSelectImageIndex];
    self.specialEffectsView.photoImage = pictureEdit.originalImage;
    
    self.specialEffectsView.hidden = NO;
    
    CGRect edRect = gesture.view.frame;
    
    _specialEffectsView.frame = CGRectMake(_backgroundView.frame.origin.x+edRect.origin.x+(edRect.size.width-160)/2, _backgroundView.frame.origin.y+edRect.origin.y+edRect.size.height, 160, 40);
    
}

//长按出现切换图片菜单
- (void)longGestre:(UILongPressGestureRecognizer *)gesture {
    
    if(gesture.state == UIGestureRecognizerStateBegan) {
        
        //隐藏滤镜选项
        if (!self.specialEffectsView.hidden){
            _specialEffectsView.hidden = YES;
        }
        
        //隐藏文字编辑
        if (self.editTextView.frame.origin.y < HIGH) {
            [self.editTextView.contentField resignFirstResponder];
        }
        
        //隐藏文字虚线边框
        for (UIView *viv in [_backgroundView subviews]) {
            
            if ([viv isKindOfClass:[YLDottedLineLabel class]]) {
                
                //隐藏文字虚线边框
                YLDottedLineLabel *yldottedline = (YLDottedLineLabel *)viv;
                
                [yldottedline hideLayer];
                
            }
            
        }
        
        //选中的图片出现边框
        for (int i=0; i<_imageArray.count; i++) {
            
            PictureEditView *pictureEdit = (PictureEditView *)[self.view viewWithTag:1000+i];
            
            if (pictureEdit.tag == gesture.view.tag) {
                pictureEdit.layer.borderWidth = 1;
                pictureEdit.layer.borderColor = [UIColor redColor].CGColor;
            }else{
                pictureEdit.layer.borderWidth = 0;
            }
            
        }
        
//        if (useSelectImageIndex != gesture.view.tag && self.sidebarView.hidden == NO) {
//            
//            useSelectImageIndex = gesture.view.tag;
//            
//            return;
//            
//        }
        
        useSelectImageIndex = gesture.view.tag;
        
        //弹出侧边栏
        if (self.sidebarView.hidden == YES) {
            
            self.sidebarView.hidden = NO;
            
            [UIView animateWithDuration:0.4 animations:^{
                
                CGRect rect = self.sidebarView.frame;
                rect.origin.x -= 40;
                self.sidebarView.frame = rect;
                
            }];
            
        }else {
            
            gesture.view.layer.borderWidth = 0;
            
            [UIView animateWithDuration:0.4 animations:^{
                
                CGRect rect = self.sidebarView.frame;
                rect.origin.x += 40;
                self.sidebarView.frame = rect;
                
            } completion:^(BOOL finished) {
                
                self.sidebarView.hidden = YES;
                
            }];
            
        }
        
    }
    
}

//拖动手势
- (void)panGesture:(UIPanGestureRecognizer *)gesture {
    
    PictureEditView *pictureEdit = (PictureEditView *)[self.view viewWithTag:gesture.view.tag-9000];
    if(gesture.state == UIGestureRecognizerStateBegan){
        
        //图片的中心点坐标
        CGPoint picturePoint = CGPointMake((pictureEdit.frame.size.width/2 + pictureEdit.frame.origin.x), (pictureEdit.frame.size.height/2 + pictureEdit.frame.origin.y));
        
        //移动的起点坐标
        CGPoint movePoint = [gesture locationInView:_backgroundView];
        
        //起点和重点的差距
        longPressPoint = CGPointMake(movePoint.x - picturePoint.x, movePoint.y - picturePoint.y);
        
    }else if(gesture.state == UIGestureRecognizerStateChanged) {
        
        CGPoint currentPosition = [gesture locationInView:pictureEdit];
        CGPoint center = gesture.view.center;
        CGPoint translation = [gesture translationInView:pictureEdit];
        gesture.view.center = CGPointMake(center.x + translation.x, center.y + translation.y);
        [gesture setTranslation:CGPointZero inView:pictureEdit];
        
        NSLog(@"x:%f   y:%f",currentPosition.x,currentPosition.y);
        
        if (currentPosition.x < 0 || currentPosition.x > pictureEdit.frame.size.width || currentPosition.y < 0 || currentPosition.y > pictureEdit.frame.size.height) {
            
            pictureEdit.alpha = 0.5;
            pictureEdit.clipsToBounds = NO;
            [_backgroundView bringSubviewToFront:pictureEdit];
            
        }
        
    }else if(gesture.state == UIGestureRecognizerStateEnded) {
        
        //手指移动到的中心坐标
        CGPoint currentPosition = [gesture locationInView:_backgroundView];
        
        BOOL isMove = YES;
        for (int i=0; i<_imageArray.count; i++) {
            
            PictureEditView *pictureEdit2 = (PictureEditView *)[self.view viewWithTag:1000+i];
            
            if (currentPosition.x > pictureEdit2.frame.origin.x && currentPosition.y > pictureEdit2.frame.origin.y && currentPosition.x < pictureEdit2.frame.origin.x+pictureEdit2.frame.size.width && currentPosition.y < pictureEdit2.frame.origin.y+pictureEdit2.frame.size.height) {
                
                if (pictureEdit.tag != pictureEdit2.tag) {
                    
                    isMove = NO;
                    
                    UIImage *imge = pictureEdit.editImageView.image;
                    pictureEdit.editImageView.image = pictureEdit2.editImageView.image;
                    pictureEdit2.editImageView.image = imge;
                    
                    [pictureEdit reloadViewFrame:pictureEdit.frame];
                    [pictureEdit2 reloadViewFrame:pictureEdit2.frame];
                    
                }
                
            }
            
        }
        
        if (isMove) {
            
            CGPoint center = gesture.view.center;
            
            if (center.x + gesture.view.bounds.size.width/2 < 0 || center.x - gesture.view.bounds.size.width/2 > pictureEdit.bounds.size.width || center.y + gesture.view.bounds.size.height/2 < 0 || center.y - gesture.view.bounds.size.height/2 > pictureEdit.bounds.size.height) {
                
                [pictureEdit reloadViewFrame:pictureEdit.frame];
            }
            
        }
        
        pictureEdit.alpha = 1;
        pictureEdit.clipsToBounds = YES;
        
        //修改层级关系
        [self modifyViewLayerRelationship];
        
    }
    
}

#pragma -mark SidebarDelegate 侧边栏
//切换图片
- (void)switchImage{
    YLPhotoPickerController *ylPhotoPicker = [[YLPhotoPickerController alloc] init];
    ylPhotoPicker.delegate = self;
    ylPhotoPicker.isMultiselect = NO;
    [self.navigationController pushViewController:ylPhotoPicker animated:YES];
}

//旋转
- (void)switchImageDirection{
    PictureEditView *pictureEdit = (PictureEditView *)[self.view viewWithTag:useSelectImageIndex];
    pictureEdit.editImageView.transform = CGAffineTransformRotate(pictureEdit.editImageView.transform, M_PI/2);
}

//翻面
- (void)flipImage{
    PictureEditView *pictureEdit = (PictureEditView *)[self.view viewWithTag:useSelectImageIndex];
    CATransform3D myTransform = CATransform3DRotate(pictureEdit.editImageView.layer.transform, M_PI, 0.0, 1.0, 0.0);
    //myTransform = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);
    pictureEdit.editImageView.layer.transform = myTransform;
}

#pragma -mark SpecialEffectsDelegate 滤镜
-(void)specialEffectsLJImage:(UIImage *)image {
    
    PictureEditView *pictureEdit = (PictureEditView *)[self.view viewWithTag:useSelectImageIndex];
    pictureEdit.editImageView.image = image;
    
}

#pragma -mark YLPhotoPickerDataSource 选择单张图片
- (void)editSuccess:(UIImage *)image{
    
    PictureEditView *pictureEdit = (PictureEditView *)[self.view viewWithTag:useSelectImageIndex];
    pictureEdit.editImageView.image = image;
    pictureEdit.originalImage = image;
    [pictureEdit reloadView];
    
}

#pragma -mark TemplateListDelegate 切换模板
- (void)choiceContent:(NSInteger)index{
    
    if (index > selectTemplateIndex) {
        
        [self transitionWithType:kCATransitionPush WithSubtype:kCATransitionFromRight ForView:_backgroundView];
        
    }else if (index < selectTemplateIndex) {
    
        [self transitionWithType:kCATransitionPush WithSubtype:kCATransitionFromLeft ForView:_backgroundView];
        
    }
    
    useTemplateTypeIndex = selectTemplateTypeIndex;
    selectTemplateIndex = index;
    
    NSArray *templateAry = self.templateArray[selectTemplateTypeIndex];
    TemplateModel *templateModel = (TemplateModel *)templateAry[selectTemplateIndex];
    
    //切换模板
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@",TEMPLATEPATH,templateModel.templateImageName];
    _backgroundImageView.image = [UIImage imageWithContentsOfFile:imagePath];
    
    [self switchTemplate:templateModel];
    
}

#pragma -mark TemplateTypeDelegate 模板类型
//切换模板类型
- (void)choiceType:(NSInteger)index{
    
    //选中的模板
    selectTemplateTypeIndex = index;
    
    //加载模板列表数据
    [self switchTemplate];
    
    if (useTemplateTypeIndex == index) {
        
        _templateListView.selectIndex = selectTemplateIndex;
        
    }else {
        
        _templateListView.selectIndex = 999;
        
    }
    
}

//隐藏模板列表
- (void)hideTemplateListView{
    
    if (_templateListView.hidden == YES) {
        
        _templateListView.hidden = NO;
        
        CGRect rect0 = _backgroundView.frame;
        
        [UIView animateWithDuration:0.4 animations:^{
            
            CGRect rect = _templateListView.frame;
            rect.origin.y -= rect.size.height;
            _templateListView.frame = rect;
            
            float bili = (WIDE - 60) / (WIDE - 20);
            _backgroundView.transform = CGAffineTransformScale(_backgroundView.transform, bili, bili);
            
            CGRect rect1 = _backgroundView.frame;
            rect1.origin.y = rect0.origin.y;
            _backgroundView.frame = rect1;
            
        }];
        
    }else {
        
        CGRect rect0 = _backgroundView.frame;
        
        [UIView animateWithDuration:0.4 animations:^{
            
            CGRect rect = _templateListView.frame;
            rect.origin.y += rect.size.height;
            _templateListView.frame = rect;
            
            float bili = (WIDE - 20) / (WIDE - 60);
            _backgroundView.transform = CGAffineTransformScale(_backgroundView.transform, bili, bili);
            
            CGRect rect1 = _backgroundView.frame;
            rect1.origin.y = rect0.origin.y;
            _backgroundView.frame = rect1;
            
        } completion:^(BOOL finished) {
            
            _templateListView.hidden = YES;
            
        }];
        
    }
    
}

#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.3;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}

//保存/分享
- (IBAction)preservationOrShareImage:(id)sender {
    
    //截屏
    UIImage *captureImage = [self captureImageFromViewLow:_backgroundView];
    
    UIImageWriteToSavedPhotosAlbum(captureImage, NULL, NULL, NULL);
    
    // 获取指定的Storyboard，name填写Storyboard的文件名
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
    ShareController *share = [storyboard instantiateViewControllerWithIdentifier:@"SharePicture"];
    share.shareImage = captureImage;
    [self.navigationController pushViewController:share animated:YES];
    
}

//返回
- (IBAction)returnVC:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//获取指定View的图片
- (UIImage *)captureImageFromViewLow:(UIView *)orgView{
    UIGraphicsBeginImageContextWithOptions(orgView.bounds.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [orgView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//点击文字框
- (void)yldottedlineTapGesture:(UITapGestureRecognizer *)tap {
    
    YLDottedLineLabel *yldottedline = (YLDottedLineLabel *)[self.view viewWithTag:tap.view.tag];
    [yldottedline displayLayer];
    
    NSArray *templateAry = self.templateArray[selectTemplateTypeIndex];
    TemplateModel *templateModel = (TemplateModel *)templateAry[selectTemplateIndex];
    NSArray *writtenWordsArray = templateModel.writtenWords;
    WrittenWordModel *writtenWordModel = (WrittenWordModel *)writtenWordsArray[tap.view.tag-100000];
    
    selectYLDottedLineLabel = tap.view.tag;
    
    self.editTextView.tag = tap.view.tag*10;
    self.editTextView.numMax = writtenWordModel.numMax;
    [self.editTextView.contentField becomeFirstResponder];
    
    for (UIView *viv in [_backgroundView subviews]) {
        
        if ([viv isKindOfClass:[YLDottedLineLabel class]] && viv.tag != tap.view.tag) {
            
            //隐藏文字虚线边框
            YLDottedLineLabel *yldottedline = (YLDottedLineLabel *)viv;
            
            [yldottedline hideLayer];
            
        }
        
    }
    
}

#pragma -mark YLEditTextViewDelegate
//完成编辑文字
- (void)ylEditTextViewCompleteEdit {
    YLDottedLineLabel *yldottedline = (YLDottedLineLabel *)[self.view viewWithTag:selectYLDottedLineLabel];
    yldottedline.text = self.editTextView.contentField.text;
    [yldottedline hideLayer];
    
    [UIView animateWithDuration:0.25 animations:^{
        if (self.fontTypeView.frame.origin.y < HIGH) {
            CGRect rect = self.fontTypeView.frame;
            rect.origin.y = HIGH;
            self.fontTypeView.frame = rect;
            
            CGRect rect1 = self.editTextView.frame;
            rect1.origin.y = HIGH;
            self.editTextView.frame = rect1;
        }
    }];
    
    [self.editTextView.contentField resignFirstResponder];
}

//切换字体
- (void)ylEditTextViewSwitchTypeface:(BOOL)isTypeface {
    
    if (isTypeface) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGRect rect = self.fontTypeView.frame;
            rect.origin.y = HIGH - 216;
            self.fontTypeView.frame = rect;
            
            CGRect rect1 = self.editTextView.frame;
            rect1.origin.y = HIGH - 216 - rect1.size.height;
            self.editTextView.frame = rect1;
            
        }];
        
        [self.editTextView.contentField resignFirstResponder];
        
    }else {
        
        CGRect rect = self.fontTypeView.frame;
        rect.origin.y = HIGH;
        self.fontTypeView.frame = rect;
        
        [self.editTextView.contentField becomeFirstResponder];
        
    }
    
}

//键盘高度改变
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    
    //动画的持续时间
    double duration = [userInfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //键盘的frame
    CGRect keyboardF = [userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //执行动画
    [UIView animateWithDuration:duration animations:^{
        //工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y >= HIGH) {
            
            if (self.fontTypeView.frame.origin.y == HIGH) {
                
                CGRect rect = self.editTextView.frame;
                rect.origin.y = HIGH;
                self.editTextView.frame = rect;
                
            }
            
        } else {
            
            CGRect rect = self.editTextView.frame;
            rect.origin.y = HIGH - keyboardF.size.height - rect.size.height;
            self.editTextView.frame = rect;
            self.editTextView.typefaceBtn.selected = NO;
            
        }
    }];
    
    NSLog(@"键盘高度%f",keyboardF.size.height);
    
}

#pragma -mark YLFontTypeViewDelegate 选择其他字体
- (void)ylFontTypeViewSwitchTypeface:(NSString *)typeface {
    NSLog(@"字体：%@",typeface);
    YLDottedLineLabel *yldottedline = (YLDottedLineLabel *)[self.view viewWithTag:selectYLDottedLineLabel];
    yldottedline.font = [UIFont fontWithName:typeface size:15];
    self.editTextView.contentField.font = [UIFont fontWithName:typeface size:15];
}

- (TemplateListView *)templateListView{
    if (!_templateListView) {
        _templateListView = [[TemplateListView alloc] initWithFrame:CGRectMake(0, HIGH-122, WIDE, 76)];
        _templateListView.delegate = self;
    }
    return _templateListView;
}

- (TemplateTypeView *)templateTypeView{
    if (!_templateTypeView) {
        _templateTypeView = [[TemplateTypeView alloc] initWithFrame:CGRectMake(0, HIGH-40, WIDE, 40)];
        _templateTypeView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
        _templateTypeView.delegate = self;
    }
    return _templateTypeView;
}

- (SidebarView *)sidebarView{
    if (!_sidebarView) {
        _sidebarView = [[SidebarView alloc] initWithFrame:CGRectMake(WIDE, HIGH/2-90, 0, 0)];
        _sidebarView.hidden = YES;
        _sidebarView.delegate = self;
    }
    return _sidebarView;
}

- (YLEditTextView *)editTextView {
    if (!_editTextView) {
        _editTextView = [[YLEditTextView alloc] initWithFrame:CGRectMake(0, HIGH, WIDE, 48)];
        _editTextView.delegate = self;
        [self.view addSubview:_editTextView];
    }
    return _editTextView;
}

- (YLFontTypeView *)fontTypeView {
    if (!_fontTypeView) {
        _fontTypeView = [[YLFontTypeView alloc] initWithFrame:CGRectMake(0, HIGH, WIDE, 216)];
        _fontTypeView.delegate = self;
        [self.view addSubview:_fontTypeView];
    }
    return _fontTypeView;
}

- (SpecialEffectsView *)specialEffectsView {
    if (!_specialEffectsView) {
        _specialEffectsView = [[SpecialEffectsView alloc] initWithFrame:CGRectMake(0, HIGH, 160, 40)];
        _specialEffectsView.backgroundColor = [UIColor whiteColor];
        _specialEffectsView.delegate = self;
        _specialEffectsView.hidden = YES;
        [self.view addSubview:_specialEffectsView];
    }
    return _specialEffectsView;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (NSMutableArray *)templateArray{
    if (!_templateArray) {
        _templateArray = [[NSMutableArray alloc] init];
    }
    return _templateArray;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
