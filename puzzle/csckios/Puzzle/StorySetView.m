//
//  StorySetView.m
//  Puzzle
//
//  Created by yiliu on 2016/10/20.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "StorySetView.h"

@interface StorySetView ()<UITextViewDelegate,UITextFieldDelegate>{
    UIImageView *headImageView;
    UITextField *titleField;
    UILabel     *timeLabel;
    UILabel     *addressLabel;
    UITextView  *contentView;
}

@end

@implementation StorySetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
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
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"zuo"] forState:UIControlStateNormal];
    [self addSubview:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width-40, headImageView.bounds.size.height/2-15, 30, 30)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"you"] forState:UIControlStateNormal];
    [self addSubview:rightBtn];
    
    titleField = [[UITextField alloc] initWithFrame:CGRectMake(20, headImageView.bounds.size.height+20, self.bounds.size.width-40, 30)];
    titleField.placeholder = @"输入故事标题";
    titleField.textAlignment = NSTextAlignmentCenter;
    titleField.font = [UIFont systemFontOfSize:20];
    [self addSubview:titleField];
    
    UILabel *xhLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, titleField.frame.origin.y+titleField.bounds.size.height+5, self.bounds.size.width-40, 1)];
    xhLabel.backgroundColor = RGBACOLOR(200, 200, 200, 1);
    [self addSubview:xhLabel];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, xhLabel.frame.origin.y+xhLabel.bounds.size.height+15, self.bounds.size.width/2-30, 16)];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = RGBACOLOR(191, 191, 191, 1);
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.text = @"2016-10-14";
    [self addSubview:timeLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2, xhLabel.frame.origin.y+xhLabel.bounds.size.height+16, 12, 12)];
    imageView.image = [UIImage imageNamed:@"zuobiao"];
    [self addSubview:imageView];
    
    addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2+15, xhLabel.frame.origin.y+xhLabel.bounds.size.height+15, self.bounds.size.width/2-20, 16)];
    addressLabel.font = [UIFont systemFontOfSize:12];
    addressLabel.textColor = RGBACOLOR(191, 191, 191, 1);
    addressLabel.text = @"编辑地点";
    [self addSubview:addressLabel];
    
    contentView = [[UITextView alloc] initWithFrame:CGRectMake(0, timeLabel.frame.origin.y+timeLabel.frame.size.height+20, self.bounds.size.width, 60)];
    contentView.delegate = self;
    contentView.font = [UIFont systemFontOfSize:15];
    contentView.textAlignment = NSTextAlignmentCenter;
    contentView.text = @"添加故事开头";
    contentView.textColor = RGBACOLOR(200, 200, 200, 1);
    [self addSubview:contentView];
    
    UITapGestureRecognizer *timeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timeTap)];
    [timeLabel addGestureRecognizer:timeTap];
    
    UITapGestureRecognizer *addressTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressTap)];
    [addressLabel addGestureRecognizer:addressTap];
    
}

//编辑时间
- (void)timeTap {
    [self.delegate editTime];
}

//编辑地点
- (void)addressTap {
    [self.delegate editAddress];
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
    }
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
    addressLabel.text = _address;
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
