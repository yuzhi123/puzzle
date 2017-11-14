//
//  WWSpaceLabel.m
//  Puzzle
//
//  Created by 王飞 on 2017/10/23.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "WWSpaceLabel.h"

@interface WWSpaceLabel ()




@end

@implementation WWSpaceLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)drawTextInRect:(CGRect)rect{
    UIEdgeInsets insets = {_topMargin,_leftMargin,_bottomMargin,_rightMargin};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

-(void)setLeftMargin:(CGFloat)leftMargin{
    _leftMargin = leftMargin;
    //[self layoutIfNeeded];
   // [self drawTextInRect:self.bounds];
}

-(void)setRightMargin:(CGFloat)rightMargin{
    _rightMargin = rightMargin;
   // [self drawTextInRect:self.bounds];
}

-(void)setTopMargin:(CGFloat)topMargin{
    _topMargin = topMargin;
    //[self drawTextInRect:self.bounds];
}

-(void)setBottomMargin:(CGFloat)bottomMargin{
    _bottomMargin = bottomMargin;
      //[self drawTextInRect:self.bounds];
}

@end
