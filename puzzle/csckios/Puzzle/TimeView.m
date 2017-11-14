//
//  TimeView.m
//  Puzzle
//
//  Created by yiliu on 2016/10/21.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "TimeView.h"


@interface TimeView (){
    UIDatePicker *datePicker;
}
@end

@implementation TimeView


- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, HIGH-260, WIDE, 260)];
    if (self) {
        
        [self loadView];
        
    }
    return self;
}

- (void)loadView {
    
    self.backgroundColor = RGBACOLOR(37, 54, 77, 1);
    
    UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width-50, 0, 50, 44)];
    [okBtn addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];
    [okBtn setTitle:@"完成" forState:UIControlStateNormal];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:okBtn];

    NSDate *minDate = [NSDate new];
    datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0.0,44.0,0.0,0.0)];
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.maximumDate = minDate;
    datePicker.date = minDate;
    [self addSubview:datePicker];
    
}

- (void)ok {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:datePicker.date];
    [self.delegate choiceTime:destDateString];
    
    [self removeFromSuperview];
    
}

@end
