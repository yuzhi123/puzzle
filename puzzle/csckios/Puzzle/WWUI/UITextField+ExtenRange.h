//
//  UITextField+ExtenRange.h
//  FeiHangChuangKe
//
//  Created by 王飞 on 17/3/6.
//  Copyright © 2017年 FeiHangKeJi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ExtenRange)

-(NSRange)selectedRange;
-(void)setSelectedRange:(NSRange)range;


@end
