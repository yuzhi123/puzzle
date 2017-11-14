//
//  orderView.h
//  Puzzle
//
//  Created by 王武 on 2017/10/21.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userModel.h"
#import "orderBT.h"

@interface orderView : UIView

@property (nonatomic,strong) orderBT* payBt;

@property (nonatomic,strong) orderBT* sendBt;

@property (nonatomic,strong) orderBT* receiveBt;

@property (nonatomic,strong) orderBT* appAppraiseBt;



@end
