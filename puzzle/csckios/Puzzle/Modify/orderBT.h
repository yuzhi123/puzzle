//
//  orderBT.h
//  Puzzle
//
//  Created by 王飞 on 2017/10/19.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM (NSInteger, IMAGE_DIRECTION)   {
    
    ImageLeft = 0,
    
    ImageTop = 1,
    
    ImageRight = 2,
    
    ImageBottom = 3
    
};

@interface orderBT : UIButton

@property (nonatomic,strong) UIImageView* innerImageV; // 图片

@property (nonatomic,strong) UILabel* innerLabel; //文字

@property (nonatomic,strong) UILabel* innerTipLabel;  // 数量提示


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
          andTipCenterPoint:(CGPoint)CenterPoint;//小红点位置


-(void)setTipCount:(NSInteger)tipCount;

@end
