//
//  addressCell.h
//  Puzzle
//
//  Created by 王武 on 2017/10/26.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addressModel.h"

@interface addressCell : UITableViewCell

@property (nonatomic,strong) addressModel* model;

-(CGFloat)getHeightWithModel:(addressModel*)model;

-(void)configModel:(addressModel*)model;

@end
