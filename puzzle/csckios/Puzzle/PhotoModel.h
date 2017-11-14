//
//  PhotoModel.h
//  Puzzle
//
//  Created by yiliu on 16/9/19.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <Foundation/Foundation.h>

//模板上的照片类
@interface PhotoModel : NSObject

/** 主键 */
@property (nonatomic, assign) NSInteger photoId;

/** x坐标 */
@property (nonatomic, assign) float xCoordinatex;

/** y坐标 */
@property (nonatomic, assign) float yCoordinatey;

/** 宽 */
@property (nonatomic, assign) float wide;

/** 高 */
@property (nonatomic, assign) float high;

/** 旋转角度 */
@property (nonatomic, assign) float rotationAngle;

@end
