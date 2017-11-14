//
//  PictureEditView.m
//  Puzzle
//
//  Created by yiliu on 16/8/30.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "PictureEditView.h"

@interface PictureEditView (){
    CGFloat            rotation;               //旋转角度
    
//    UIView *viv0;
//    UIView *viv1;
//    UIView *viv2;
//    UIView *viv3;
    
}
@end


@implementation PictureEditView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.layer.allowsEdgeAntialiasing = YES;
        
        self.backgroundColor = [UIColor clearColor];
        
        _editImageView = [[UIImageView alloc] init];
        _editImageView.layer.allowsEdgeAntialiasing = YES;
        _editImageView.userInteractionEnabled = YES;
        [self addSubview:_editImageView];
        
//        viv0 = [[UIView alloc] init];
//        viv1 = [[UIView alloc] init];
//        viv2 = [[UIView alloc] init];
//        viv3 = [[UIView alloc] init];
//        viv0.backgroundColor = [UIColor redColor];
//        viv1.backgroundColor = [UIColor redColor];
//        viv2.backgroundColor = [UIColor redColor];
//        viv3.backgroundColor = [UIColor redColor];
//        [self addSubview:viv0];
//        [self addSubview:viv1];
//        [self addSubview:viv2];
//        [self addSubview:viv3];
        
        //缩放手势
        UIPinchGestureRecognizer *pinGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinGesture:)];
        [_editImageView addGestureRecognizer:pinGesture];
        
        //旋转手势
        UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGesture:)];
        [_editImageView addGestureRecognizer:rotationGesture];
        
    }
    return self;
}

- (void)reloadViewFrame:(CGRect)frame {
    
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    
    self.clipsToBounds = YES;
    
    [self loadViewFrame];
    
}

- (void)reloadView {
    [self loadViewFrame];
}

- (void)loadViewFrame{
    
    CGRect frame = self.frame;
    CGRect rect = CGRectMake(0, 0, 0, 0);
    if(frame.size.width >= frame.size.height){
        
        rect.size.width = frame.size.width;
        rect.size.height = _editImageView.image.size.height / (_editImageView.image.size.width / frame.size.width);
        
        if(rect.size.height < frame.size.height){
            
            rect.size.height = frame.size.height;
            rect.size.width = _editImageView.image.size.width / (_editImageView.image.size.height / frame.size.height);
            
        }
        
    }else{
        
        rect.size.height = frame.size.height;
        rect.size.width = _editImageView.image.size.width / (_editImageView.image.size.height / frame.size.height);
        
        if(rect.size.height < frame.size.height){
            
            rect.size.width = frame.size.width;
            rect.size.height = _editImageView.image.size.height / (_editImageView.image.size.width / frame.size.width);
            
        }
        
    }
    
    _editImageView.frame = rect;
    _editImageView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
    
    
}
#pragma -mark 缩放手势
- (void)pinGesture:(UIPinchGestureRecognizer *)pin{
    
    if (pin.state == UIGestureRecognizerStateBegan || pin.state == UIGestureRecognizerStateChanged) {
        
        pin.view.transform = CGAffineTransformScale(pin.view.transform, pin.scale, pin.scale);
        pin.scale = 1;
        
    }else if (pin.state == UIGestureRecognizerStateEnded) {
        
        if(pin.view.frame.size.width < self.bounds.size.width){
            
            //使用 UIView 动画使 view 滑行到终点
            [UIView animateWithDuration:0.4
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 
                                 [self loadViewFrame];
                                 
                             }
                             completion:nil];
            
        }
        
    }
    
}

#pragma -mark 旋转手势
- (void)rotationGesture:(UIRotationGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        gesture.view.transform = CGAffineTransformRotate(gesture.view.transform, gesture.rotation);
        rotation = rotation + gesture.rotation;
        [gesture setRotation:0];
    }
}

@end
