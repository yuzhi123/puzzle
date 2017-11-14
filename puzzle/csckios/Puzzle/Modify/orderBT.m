//
//  orderBT.m
//  Puzzle
//
//  Created by 王飞 on 2017/10/19.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "orderBT.h"
#import "UILabel+ExtraWidth.h"

@interface orderBT ()


@property (nonatomic,strong) UIView* boxView;

@property (nonatomic,assign) CGPoint tipCenterPoint;



@end

@implementation orderBT

+(orderBT*)creatBtWithImage:(NSString*)imageStr  // 图
               andImageSize:(CGSize)imageSize // 图尺寸
          andDispatchHeight:(CGFloat)dispatch  //图文间距
         andlabelLineHeight:(CGFloat)labelLineHeight  // label高度
             andButtonFrame:(CGRect) frame  // 按钮frame
            andPicDirection:(IMAGE_DIRECTION) imageDIrection // 图文方向
                  andTarget:(id)target  // 事件绑定
                        sel:(SEL)sel
          andLabelTextColor:(UIColor*) textColor  //文本颜色
                andTextFont:(UIFont*) font  // 字体
               andLabelText:(NSString*)text // 文字
                andTipCount:(NSInteger) count  // 小红点数字
          andTipCenterPoint:(CGPoint)CenterPoint{  //小红点位置
    
   
    
    // 按钮
    orderBT* bt = [orderBT buttonWithType:UIButtonTypeCustom];
    bt.frame = frame;
    [bt addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    // 包裹试图
    bt.boxView = [[UIView alloc]init];
    bt.boxView.userInteractionEnabled = NO;
    [bt addSubview:bt.boxView];
    
    // 文本
    bt.innerLabel = [[UILabel alloc]init];
    bt.innerLabel.textColor = textColor;
    bt.innerLabel.text = text;
    bt.innerLabel.font = font;
    [bt.boxView addSubview:bt.innerLabel];
    
    //图片
    bt.innerImageV = [[UIImageView alloc]init];
    bt.innerImageV.image = [UIImage imageNamed:imageStr];
    [bt.boxView addSubview:bt.innerImageV];
    
    // 小红点
    bt.innerTipLabel = [[UILabel alloc]init];
    bt.innerTipLabel.backgroundColor = [UIColor redColor];
    bt.innerTipLabel.layer.cornerRadius = 11/2.0;
    bt.innerTipLabel.font = [UIFont systemFontOfSize:8];
    bt.innerTipLabel.layer.masksToBounds = YES;
    bt.innerTipLabel.textColor  = [UIColor whiteColor];
    bt.innerTipLabel.textAlignment  = NSTextAlignmentCenter;
    [bt.boxView addSubview:bt.innerTipLabel];
    [bt.innerTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CenterPoint);
        make.height.mas_equalTo(11);
    }];
    
    bt.tipCenterPoint = CenterPoint; // 记录tip位置
    
    switch (imageDIrection) {
        case ImageLeft:  // 图左
        {
            [bt.boxView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(bt);
                make.left.mas_equalTo(bt.innerImageV.mas_left);
                make.right.mas_equalTo(bt.innerLabel.mas_right);
            }];
            [bt.innerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(imageSize);
                make.centerY.mas_equalTo(bt.boxView);
            }];
            
            [bt.innerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(bt.innerImageV.mas_right).offset(dispatch);
                make.centerY.mas_equalTo(bt.innerImageV);
                make.height.mas_equalTo(labelLineHeight);
            }];
            
        }
            break;
        case ImageTop:  // 图上
        {
            [bt.boxView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(bt);
                make.top.mas_equalTo(bt.innerImageV.mas_top);
                make.bottom.mas_equalTo(bt.innerLabel.mas_bottom);
            }];
            [bt.innerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(imageSize);
                make.centerX.mas_equalTo(bt.boxView);
            }];
            [bt.innerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(bt.innerImageV.mas_bottom).offset(dispatch);
                make.centerX.mas_equalTo(bt.innerImageV);
                
            }];

        }
            break;
        case ImageRight:  // 图右
        {
            [bt.boxView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(bt);
                make.left.mas_equalTo(bt.innerLabel.mas_left);
                make.right.mas_equalTo(bt.innerImageV.mas_right);
            }];
            [bt.innerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(imageSize);
                make.centerY.mas_equalTo(bt.boxView);
            }];
            [bt.innerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(bt.innerImageV.mas_left).offset(-dispatch);
                make.centerY.mas_equalTo(bt.innerImageV);
               
            }];

        }
            break;
        case ImageBottom:  // 图下
        {
            [bt.boxView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(bt);
                make.top.mas_equalTo(bt.innerLabel.mas_top);
                make.bottom.mas_equalTo(bt.innerImageV.mas_bottom);
            }];
            [bt.innerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(imageSize);
                make.centerX.mas_equalTo(bt.boxView);
            }];
            [bt.innerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(bt.innerImageV.mas_top).offset(-dispatch);
                make.centerX.mas_equalTo(bt.innerImageV);
                make.height.mas_equalTo(labelLineHeight);
            }];
        }
            break;
            
        default:
            break;
    }
    return bt;
    
}

-(void)setTipCount:(NSInteger)tipCount{
    self.innerTipLabel.hidden = NO;
    self.innerTipLabel.extraWidth = 4;
    if (tipCount == 0) {
        self.innerTipLabel.hidden = YES;
    }
    else if (tipCount <10){
           self.innerTipLabel.text = [NSString stringWithFormat:@"%ld",tipCount] ;
        self.innerTipLabel.extraWidth = 0;
        [self.innerTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(11, 11));
            
        }];
        
        [self.innerTipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(11, 11));
            make.center.mas_equalTo(self.tipCenterPoint);
        }];
    }
    else{
        
        self.innerTipLabel.text = [NSString stringWithFormat:@"%ld",tipCount] ;
        [self.innerTipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(11);
            make.center.mas_equalTo(self.tipCenterPoint);
        }];
    }
    
}

@end
