//
//  addressManagerCell.h
//  Puzzle
//
//  Created by 王飞 on 2017/11/6.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addressModel.h"

@interface addressManagerCell : UITableViewCell

-(CGFloat)getHeightWithModel:(addressModel*)model;

-(void)configModel:(addressModel*)model;

@end
