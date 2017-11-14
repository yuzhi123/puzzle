//
//  textFiedView.h
//  Puzzle
//
//  Created by 王武 on 2017/9/13.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface textFiedView : UIView

@property (nonatomic,strong) UITextField* subTextField;

+(UIView*)creatTextField:(CGRect)frame
          andBorderStyle:(UITextBorderStyle)borderStyle
             andDelegate:(id)target
              andKeyBord:(UIKeyboardType)keybord
           andNormalFont:(NSInteger)normalFont
         andNorfontColor:(UIColor*)normalClor
           andPlaceColor:(UIColor*)placeHoderColor
            andPlaceFont:(NSInteger)placeHoderFont
           andplaceHoder:(NSString*)title
        andMaxNumberWord:(NSInteger)wordNumber;




@end
