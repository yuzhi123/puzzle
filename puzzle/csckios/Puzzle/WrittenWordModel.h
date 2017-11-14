//
//  WrittenWordModel.h
//  Puzzle
//
//  Created by yiliu on 16/9/19.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <Foundation/Foundation.h>

//模板上的文字类
@interface WrittenWordModel : NSObject

/** 主键 */
@property (nonatomic, assign) NSInteger writtenWordId;

/** x坐标 */
@property (nonatomic, assign) float xCoordinatex;

/** y坐标 */
@property (nonatomic, assign) float yCoordinatey;

/** 宽 */
@property (nonatomic, assign) float wide;

/** 高 */
@property (nonatomic, assign) float high;

/** 文字颜色 */
@property (nonatomic, strong) NSString *color;

/** 文字字体大小 */
@property (nonatomic, assign) NSInteger fontSize;

/** 最大字数 */
@property (nonatomic, assign) NSInteger numMax;

@end
