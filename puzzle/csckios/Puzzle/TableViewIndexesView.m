//
//  TableViewIndexesView.m
//  Puzzle
//
//  Created by yiliu on 16/9/6.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "TableViewIndexesView.h"

@interface TableViewIndexesView (){
    NSInteger indexsNumber;
    
}
@end

@implementation TableViewIndexesView

- (void)beij:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(rect.size.width/2, rect.size.width/6)];

    CAShapeLayer *layer = [[CAShapeLayer alloc] init];

    layer.path = path.CGPath;
    layer.fillColor = RGBACOLOR(50, 50, 50, 0.8).CGColor;
    
    [self.layer addSublayer:layer];
    
}

- (instancetype)initWithFrame:(CGRect)frame indexsNum:(NSInteger)indexsNum
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self beij:self.bounds];
        
        indexsNumber = indexsNum;
        
        float hig = (frame.size.height - frame.size.width) / indexsNumber;
        
        for (NSInteger i = 0; i < indexsNumber; i++) {
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, frame.size.width/2+hig*i, frame.size.width, hig)];
            [btn addTarget:self action:@selector(choiceBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:[NSString stringWithFormat:@"%tu",i+1] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setTitleColor:RGBACOLOR(239, 58, 114, 1) forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor clearColor]];
            btn.tag = 1000+i;
            [self addSubview:btn];
            
            if (i == 0) {
                btn.selected = YES;
            }
            
        }
        
    }
    return self;
}

- (void)choiceBtn:(UIButton *)btn {
    
    btn.selected = YES;
    
    for (NSInteger i = 0; i < indexsNumber; i++) {
    
        UIButton *sbtn = (UIButton *)[self viewWithTag:1000+i];
        if (sbtn.tag != btn.tag) {
            sbtn.selected = NO;
        }
        
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(choiceIndex:)]){
        [self.delegate choiceIndex:btn.tag-1000];
    }
    
}


- (void)switchBtn:(NSInteger)btnTag {

    UIButton *btn = (UIButton *)[self viewWithTag:btnTag+1000];
    
    btn.selected = YES;
    
    for (NSInteger i = 0; i < indexsNumber; i++) {
        
        UIButton *sbtn = (UIButton *)[self viewWithTag:1000+i];
        if (sbtn.tag != btn.tag) {
            sbtn.selected = NO;
        }
        
    }
    
}

@end
