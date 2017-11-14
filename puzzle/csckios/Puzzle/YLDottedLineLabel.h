//
//  YLDottedLineLabel.h
//  Puzzle
//
//  Created by yiliu on 16/9/19.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLDottedLineLabel : UILabel

- (void)reloadViewFrame:(CGRect)frame;

/** 隐藏边框 */
- (void)hideLayer;

/** 显示边框 */
- (void)displayLayer;

/** 显示边框再隐藏边框 */
- (void)displayHideLayer;

@end
