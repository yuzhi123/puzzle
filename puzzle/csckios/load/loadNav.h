//
//  loadNav.h
//  Puzzle
//
//  Created by 王武 on 2017/9/12.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loadNav : UINavigationController
+(loadNav*)shareLoadVC;

// fontColor 与 fontSize 不能为nil
-(void)setBarTinColor:(UIColor*) bartinColor withtitleFont:(NSInteger)fontSize andNavIsHidden:(BOOL)isHidden andtitle:(NSString*)title andTitleColor:(UIColor*)fontColor ;
@end
