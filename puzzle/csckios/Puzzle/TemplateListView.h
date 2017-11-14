//
//  TemplateListView.h
//  Puzzle
//
//  Created by yiliu on 16/8/30.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//模板列表view

#import <UIKit/UIKit.h>

@protocol TemplateListDelegate <NSObject>

//选择的内容下标
- (void)choiceContent:(NSInteger)index;

@end


@interface TemplateListView : UIView

@property (nonatomic, weak) id <TemplateListDelegate> delegate;

/** 模板图片 */
@property (nonatomic, strong) NSArray *dataArray;

/** 选中的模板 */
@property (nonatomic, assign) NSInteger selectIndex;

@end
