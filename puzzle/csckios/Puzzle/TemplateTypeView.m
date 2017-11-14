//
//  TemplateTypeView.m
//  Puzzle
//
//  Created by yiliu on 16/8/30.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "TemplateTypeView.h"
#import "TemplateTypeButton.h"
#import "Auxiliary.h"


@interface TemplateTypeView ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end


@implementation TemplateTypeView

- (void)setTypesArray:(NSArray *)typesArray{
    
    _typesArray = typesArray;
    
    float xw = 0;

//    if((self.frame.size.width-40) / typesArray.count < 60) {
//    
//        w = 60;
//    
//    }else {
//    
//        w = (self.frame.size.width-40) / typesArray.count;
//        
//    }
    
    for (UIView *viv in self.subviews) {
        [viv removeFromSuperview];
    }
    
    UIButton *hideBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [hideBtn setImage:[UIImage imageNamed:@"yincxia"] forState:UIControlStateNormal];
    [hideBtn addTarget:self action:@selector(hideTemplateTypeView:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:hideBtn];
    
    for (int i=0; i<typesArray.count; i++) {
        
        CGSize size = [Auxiliary calculationHeightWidth:typesArray[i] andSize:15 andCGSize:CGSizeMake(200, 20)];
        
        TemplateTypeButton *typeBtn = [[TemplateTypeButton alloc] initWithFrame:CGRectMake(40+xw, 3, size.width+10, 34)];
        [typeBtn addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        typeBtn.tag = 100+i;
        [typeBtn setTitle:typesArray[i] forState:UIControlStateNormal];
        [typeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.scrollView addSubview:typeBtn];
        
        xw += size.width+10;
        
    }
    
    TemplateTypeButton *typeBtn = (TemplateTypeButton *)[self viewWithTag:100];
    typeBtn.xhLabe.hidden = NO;
    self.scrollView.contentSize = CGSizeMake(40+xw+5, 40);

}

- (void)setSelectIndex:(NSInteger)selectIndex {
    
    _selectIndex = selectIndex;
    
    for (int i=0; i<_typesArray.count; i++) {
        
        TemplateTypeButton *typeBtn = (TemplateTypeButton *)[self viewWithTag:100+i];
        if(i == _selectIndex){
            typeBtn.xhLabe.hidden = NO;
        }else{
            typeBtn.xhLabe.hidden = YES;
        }
        
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(choiceType:)]){
        [self.delegate choiceType:_selectIndex];
    }
    
}

//隐藏模板选择view
- (void)hideTemplateTypeView:(UIButton *)btn{
    
    if (btn.selected) {
        btn.selected = NO;
        [btn setImage:[UIImage imageNamed:@"yincxia"] forState:UIControlStateNormal];
    }else {
        btn.selected = YES;
        [btn setImage:[UIImage imageNamed:@"xianshishang"] forState:UIControlStateNormal];
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(hideTemplateListView)]){
        [self.delegate hideTemplateListView];
    }
    
}

//选择类型
- (void)selectType:(TemplateTypeButton *)btn{

    for (int i=0; i<_typesArray.count; i++) {
        
        TemplateTypeButton *typeBtn = (TemplateTypeButton *)[self viewWithTag:100+i];
        if(typeBtn.tag == btn.tag){
            typeBtn.xhLabe.hidden = NO;
        }else{
            typeBtn.xhLabe.hidden = YES;
        }
        
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(choiceType:)]){
        [self.delegate choiceType:btn.tag-100];
    }
    
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

@end
