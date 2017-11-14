//
//  TemplateTypeView.h
//  Puzzle
//
//  Created by yiliu on 16/8/30.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TemplateTypeDelegate <NSObject>

//选择的专题下标
- (void)choiceType:(NSInteger)index;

//隐藏模板列表
- (void)hideTemplateListView;

@end


@interface TemplateTypeView : UIView

@property (nonatomic, weak) id <TemplateTypeDelegate> delegate;


@property (nonatomic, strong) NSArray *typesArray;

/** 选中的 */
@property (nonatomic, assign) NSInteger selectIndex;

@end
