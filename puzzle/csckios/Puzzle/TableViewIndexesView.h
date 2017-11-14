//
//  TableViewIndexesView.h
//  Puzzle
//
//  Created by yiliu on 16/9/6.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//索引view

#import <UIKit/UIKit.h>

@protocol TableViewIndexesDelegate <NSObject>

//选择的下标
- (void)choiceIndex:(NSInteger)index;

@end


@interface TableViewIndexesView : UIView

@property (nonatomic, weak) id <TableViewIndexesDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame indexsNum:(NSInteger)indexsNum;


- (void)switchBtn:(NSInteger)btnTag;

@end
