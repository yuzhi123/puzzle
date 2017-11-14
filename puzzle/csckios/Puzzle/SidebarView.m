//
//  SidebarView.m
//  Puzzle
//
//  Created by yiliu on 16/8/31.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "SidebarView.h"

@implementation SidebarView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 40, 160)];
    if (self) {
    
        //切换照片
        UIButton *btn0 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [btn0 addTarget:self action:@selector(switchImage:) forControlEvents:UIControlEventTouchUpInside];
        [btn0 setBackgroundImage:[UIImage imageNamed:@"qiehuan"] forState:UIControlStateNormal];
        [self addSubview:btn0];
        
        //旋转
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 40, 40, 40)];
        [btn1 addTarget:self action:@selector(switchImageDirection:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setBackgroundImage:[UIImage imageNamed:@"xuanzhuan"] forState:UIControlStateNormal];
        [self addSubview:btn1];
        
        //翻转
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 80, 40, 40)];
        [btn2 addTarget:self action:@selector(flipImage:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setBackgroundImage:[UIImage imageNamed:@"fanzhuan"] forState:UIControlStateNormal];
        [self addSubview:btn2];
        
        UILabel *fgLabel0 = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 20, 1)];
        fgLabel0.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        [self addSubview:fgLabel0];
        
        UILabel *fgLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 20, 1)];
        fgLabel1.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        [self addSubview:fgLabel1];
        
    }
    return self;
    
}

//重选图片
- (void)switchImage:(UIButton *)btn{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(switchImage)]){
        [self.delegate switchImage];
    }
    
}

//改变图片方向
- (void)switchImageDirection:(UIButton *)btn{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(switchImageDirection)]){
        [self.delegate switchImageDirection];
    }
    
}

//翻转图片
- (void)flipImage:(UIButton *)btn{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(flipImage)]){
        [self.delegate flipImage];
    }
    
}

@end
