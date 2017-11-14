//
//  AddressController.h
//  Puzzle
//
//  Created by yiliu on 16/9/12.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddressDelegate <NSObject>

/** 选择的地址 */
- (void)choiceAddress;

@end


@interface AddressController : UIViewController

@property (nonatomic, weak) id <AddressDelegate> delegate;

/** 选择地址 */
@property (nonatomic, assign) BOOL selectAddress;

@end
