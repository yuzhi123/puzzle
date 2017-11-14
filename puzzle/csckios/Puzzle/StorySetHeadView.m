//
//  StorySetHeadView.m
//  Puzzle
//
//  Created by yiliu on 2016/10/21.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "StorySetHeadView.h"


@interface StorySetHeadView ()<UITextViewDelegate,UITextFieldDelegate>{
    UIImageView *headImageView;
    UITextField *titleField;
    UILabel     *timeLabel;
    UITextField *addressField;
    UITextView  *contentView;
}

@end

@implementation StorySetHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _index = 0;
        
        //286*370
        [self loadThemeView];
        
    }
    return self;
}

//主题
- (void)loadThemeView {
    
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, (self.bounds.size.width/320)*200)];
    headImageView.contentMode = UIViewContentModeScaleAspectFill;
    headImageView.clipsToBounds = YES;
    [self addSubview:headImageView];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, headImageView.bounds.size.height/2-15, 30, 30)];
    [leftBtn addTarget:self action:@selector(leftImage) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"zuo"] forState:UIControlStateNormal];
    [self addSubview:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width-40, headImageView.bounds.size.height/2-15, 30, 30)];
    [rightBtn addTarget:self action:@selector(rightImage) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"you"] forState:UIControlStateNormal];
    [self addSubview:rightBtn];
    
    titleField = [[UITextField alloc] initWithFrame:CGRectMake(20, headImageView.bounds.size.height+20, self.bounds.size.width-40, 30)];
    titleField.delegate = self;
    titleField.placeholder = @"输入故事标题";
    titleField.textAlignment = NSTextAlignmentCenter;
    titleField.font = [UIFont systemFontOfSize:20];
    [self addSubview:titleField];
    
    UILabel *xhLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, titleField.frame.origin.y+titleField.bounds.size.height+5, self.bounds.size.width-40, 1)];
    xhLabel.backgroundColor = RGBACOLOR(200, 200, 200, 1);
    [self addSubview:xhLabel];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, xhLabel.frame.origin.y+xhLabel.bounds.size.height+15, self.bounds.size.width/2-30, 16)];
    timeLabel.userInteractionEnabled = YES;
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = RGBACOLOR(191, 191, 191, 1);
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.text = @"2016-10-14";
    [self addSubview:timeLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2, xhLabel.frame.origin.y+xhLabel.bounds.size.height+16, 12, 12)];
    imageView.image = [UIImage imageNamed:@"zuobiao"];
    [self addSubview:imageView];
    
    addressField = [[UITextField alloc] initWithFrame:CGRectMake(self.bounds.size.width/2+15, xhLabel.frame.origin.y+xhLabel.bounds.size.height+15, self.bounds.size.width/2-20, 16)];
    addressField.delegate = self;
    addressField.font = [UIFont systemFontOfSize:12];
    addressField.textColor = RGBACOLOR(191, 191, 191, 1);
    addressField.placeholder = @"编辑地点";
    [self addSubview:addressField];
    
    contentView = [[UITextView alloc] initWithFrame:CGRectMake(0, timeLabel.frame.origin.y+timeLabel.frame.size.height+20, self.bounds.size.width, 60)];
    contentView.delegate = self;
    contentView.font = [UIFont systemFontOfSize:15];
    contentView.textAlignment = NSTextAlignmentCenter;
    contentView.text = @"添加故事开头";
    contentView.textColor = RGBACOLOR(200, 200, 200, 1);
    [self addSubview:contentView];
    
    UITapGestureRecognizer *timeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timeTap)];
    [timeLabel addGestureRecognizer:timeTap];
    
}

//左
- (void)leftImage {
    if (index > 0) {
        _index--;
        headImageView.image = _imageArry[_index];
    }
}

//右
- (void)rightImage {
    if (_index < _imageArry.count-1) {
        _index++;
        headImageView.image = _imageArry[_index];
    }
}

//编辑时间
- (void)timeTap {
    [self.delegate editTimeHeader];
}

#pragma -mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqual:@"添加故事开头"]){
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text isEqual:@""]){
        textView.text = @"添加故事开头";
        textView.textColor = RGBACOLOR(200, 200, 200, 1);
        _content = @"";
    }else {
        _content = textView.text;
    }
}

#pragma -mark UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField == addressField) {
        _address = textField.text;
    }else if (textField == titleField) {
        _title = textField.text;
    }
    return YES;
}

- (void)setImageArry:(NSArray *)imageArry {
    _imageArry = imageArry;
    headImageView.image = _imageArry[0];
}

- (void)setTime:(NSString *)time {
    _time = time;
    timeLabel.text = _time;
}

- (void)setAddress:(NSString *)address {
    _address = address;
    addressField.text = _address;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    titleField.text = _title;
}

- (void)setContent:(NSString *)content {
    _content = content;
    contentView.text = _content;
    contentView.textColor = [UIColor blackColor];
}


@end
